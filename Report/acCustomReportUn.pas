unit acCustomReportUn;

interface

uses
  SysUtils, Classes, ppComm, ppRelatv, ppProd, ppClass, ppReport, DB,
  DBClient, osClientDataset, osComboFilter, FMTBcd, Provider,
  osCustomDataSetProvider, osSQLDataSetProvider, SqlExpr, osSQLDataSet,
  ppModule, raCodMod, ppMemo, ppVar, ppBands, ppStrtch, ppSubRpt, ppCtrls,
  ppPrnabl, ppCache, ppDB, ppDBPipe, ppTypes, Forms, ppViewr, daSQl,
  daDataModule, daQueryDataView, TypInfo, ppChrtUI, Printers;

type
  TTipoAdendo = (taWHERE, taORDER);

  TAdendo = record
    tipo: TTipoAdendo;
    Pipeline: String;
    sentenca: String;
  end;

  TAdendos = class
    private
      items: array of TAdendo;
    public
      procedure add(tipo: TTipoAdendo; Pipeline: String; sentenca: String);
      function find(tipo: TTipoAdendo; pipeline: String): string;
      procedure clear;
  end;

  TReportFormat = (rfAcrobat, rfArchive, rfBitmap, rfMetafile, rfExcel,
                   rfGIF, rfHTML, rfJPEG, rfPrinter, rfReportText, rfRTF,
                   rfText, rfWindowsMetafile, rfXHTML);

  TacCustomReport = class(TDataModule)
    FilterDatasource: TDataSource;
    FilterDataset: TosClientDataset;
    Report: TppReport;
    Detail: TppDetailBand;
    raCodeModule1: TraCodeModule;
    procedure DataModuleCreate(Sender: TObject);
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    FPrintToFile: boolean;
    FTextFileName: string;
    FDeviceType: string;
    procedure replaceReportSQLAddWhere(report: TppReport;
      template: TMemoryStream; id:integer);
    function replaceId(str: string; id: integer): string;
    function replaceParamId(str: string; id: integer): string;
  protected
    beforePrint: TNotifyEvent;
    adendos: TAdendos;
    function getTemplate(id: integer; stream: TMemoryStream): boolean; virtual;
    procedure linkEvents; virtual;
    function casosEspeciais(valorOriginal: string): string; virtual;
    procedure ajustarAdendos; virtual;
  public
    { Public declarations }
    procedure Print(const PID: integer); virtual;
    function getPipeline(name: String): TppDataPipeline;
    function findComponentUserName(name: String): TComponent;
    procedure SetOutputFile(FileName: string; Format: TReportFormat = rfPrinter);
  end;

  TReportClass = class of TacCustomReport;

var
  acCustomReport: TacCustomReport;


implementation

uses SQLMainData, osReportUtils, RelatorioDataUn, Dialogs;

{$R *.dfm}

procedure TacCustomReport.linkEvents;
begin
//
end;

procedure TacCustomReport.Print(const PID: integer);
var
  stream: TMemoryStream;
  idTemplate: integer;
  encontrou: boolean;
  preview: boolean;
begin
  beforePrint := Report.BeforePrint;
  stream := TMemoryStream.Create;
  preview := true;
  try
    encontrou := false;
    if TRelatorioData.isChangeable(ClassName) then
    begin
      idTemplate := TRelatorioData.getTemplateIDForUser(ClassName, preview);
      if idTemplate <> -1 then
      begin
        if getTemplateByID(idTemplate, stream) then
          if stream.Size<>0 then
          begin
            encontrou := true;
          end;
      end;
    end;
    //chance da classe buscar seu template
    if not(encontrou) then
    begin
      encontrou := getTemplate(PID, stream);
    end;
    if not(encontrou) then
    begin
      getTemplateByName(ClassName, stream);
      if stream.size<>0 then
        encontrou := true;
    end;
    if encontrou then
    begin
      ajustarAdendos;
      replaceReportSQLAddWhere(report, stream, PID);
    end;
    report.BeforePrint := beforePrint;
    linkEvents;


{$IFDEF DESENV}
//    preview := true;
//comentado a pedido de maringá para que respeite a config 
{$ENDIF}

    if FPrintToFile then
    begin
      report.AllowPrintToFile := True;
      report.DeviceType := FDeviceType;
      report.TextFileName := FTextFileName;
      report.ShowPrintDialog := false;
    end
    else if preview then
    begin
      report.DeviceType := 'Screen';
    end
    else
    begin
      report.ShowPrintDialog := false;
      report.DeviceType := 'Printer';
    end;
    Report.Print;
  finally
    FreeAndNil(stream);
  end;
end;

procedure TacCustomReport.DataModuleCreate(Sender: TObject);
begin
  adendos := TAdendos.Create;
  FPrintToFile := False;
end;

function TacCustomReport.getPipeline(name: String): TppDataPipeline;
var
  aSQL: TDaSQL;
  lDataModule: TdaDataModule;
  liIndex, i: Integer;
  lDataView: TdaDataView;
  nomePipeline: String;
begin
  aSQL := nil;

  lDataModule := daGetDataModule(Report.MainReport);

  if (lDataModule <> nil) then
  begin
    liIndex := 0;

    while liIndex < lDatamodule.DataViewCount do
    begin
      lDataView := lDataModule.DataViews[liIndex];
      for i := 0 to lDataView.DataPipelineCount-1 do
      begin
        nomePipeline := tiraNumerosDoFinal(lDataView.DataPipelines[i].Name) ;
        if upperCase(name)=upperCase(nomePipeline) then
        begin
          result := lDataView.DataPipelines[i];
          Exit;
        end;
      end;
      inc(liindex);
    end;
  end;
  result := nil;
end;

procedure TacCustomReport.replaceReportSQLAddWhere(report: TppReport; template: TMemoryStream;
  id: integer);
var
  aSQL: TDaSQL;
  lDataModule: TdaDataModule;
  liIndex, i, iCriteria: Integer;
  lDataView: TdaDataView;
  nomePipeline: String;
  sent, sentOrder: string;
begin
  if template.Size <> 0 then
    report.Template.LoadFromStream(template);

  aSQL := nil;

  lDataModule := daGetDataModule(Report.MainReport);

  if (lDataModule <> nil) then
    begin
      liIndex := 0;

      while liIndex < lDatamodule.DataViewCount do
      begin
        lDataView := lDataModule.DataViews[liIndex];
        for i := 0 to lDataView.DataPipelineCount-1 do
        begin
          nomePipeline := tiraNumerosDoFinal(lDataView.DataPipelines[i].Name) ;
          sent := adendos.find(taWHERE, nomePipeline);
          sentOrder := adendos.find(taORDER, nomePipeline);

          aSQL := TdaQueryDataView(lDataView).SQL;

          if asql.EditSQLAsText then
          begin
            asql.SQLText.Text := replaceParamId(asql.SQLText.Text, id);
          end
          else
          begin
            for iCriteria := 1 to aSQL.CriteriaCount do
            begin
              if aSQL.Criteria[iCriteria-1].Value = '-1' then
                aSQL.Criteria[iCriteria-1].Value := IntToStr(id)
              else
                aSQL.Criteria[iCriteria-1].Value := casosEspeciais(aSQL.Criteria[iCriteria-1].Value);
            end;
          end;

          if sent<>'' then
          begin
            asql.EditSQLAsText := True;
            asql.SQLText.Add(replaceId(sent, id));
            asql.SQLText.Add(sentOrder);
          end;
        end;
        inc(liindex);
      end;
    end;
end;

function TacCustomReport.replaceId(str: string; id:integer): string;
begin
  result := StringReplace(str,'\id',IntToStr(id),[rfReplaceAll, rfIgnoreCase]);
end;

function TacCustomReport.replaceParamId(str: string; id:integer): string;
begin
  result := StringReplace(str,'-1',IntToStr(id),[rfReplaceAll, rfIgnoreCase]);
end;

{ TAdendos }

procedure TAdendos.add(tipo: TTipoAdendo; Pipeline, sentenca: String);
begin
  SetLength(items, length(items)+1);
  items[length(items)-1].tipo := tipo;
  items[length(items)-1].Pipeline := Pipeline;
  items[length(items)-1].sentenca := sentenca;
end;


procedure TAdendos.clear;
begin
  SetLength(items, 0);
end;

function TAdendos.find(tipo: TTipoAdendo; pipeline: String): string;
var
  i: integer;
begin
  result := '';
  for i := low(items) to high(items) do
  begin
    if (items[i].tipo=tipo) AND (UpperCase(items[i].Pipeline)=UpperCase(pipeline)) then
      result := items[i].sentenca;
  end;
end;

procedure TacCustomReport.ajustarAdendos;
begin
end;

function TacCustomReport.getTemplate(id: integer; stream: TMemoryStream): boolean;
begin
  result := false;
end;

function TacCustomReport.findComponentUserName(name: String): TComponent;
var
  i: integer;
  PropInfo: PPropInfo;
begin
  result := nil;
  for i := 0 to ComponentCount-1 do
  begin
    PropInfo := GetPropInfo(components[i], 'userName');
    if Assigned(propInfo) then
      if UpperCase(GetStrProp(Components[i], 'userName'))  = UpperCase(name)then
        result := Components[i];
  end;
end;


procedure TacCustomReport.SetOutputFile(FileName: string; Format: TReportFormat);
begin
  with Report do
  begin
    FPrintToFile := True;
    FTextFileName := FileName;
    TextFileName := FileName;
    case Format of
      rfAcrobat:
        DeviceType := 'Adobe Acrobat Document';

      rfArchive:
        begin
          AllowPrintToArchive := True;
          ArchiveFileName := FileName;
          DeviceType := 'ArchiveFile';
        end;

      rfBitmap:
        DeviceType := 'Bitmap File';

      rfMetafile:
        DeviceType := 'Enhanced Metafile';

      rfExcel:
        DeviceType := 'Excel Document';

      rfGIF:
        DeviceType := 'GIF Image File';

      rfHTML:
        DeviceType := 'HTML Document';

      rfJPEG:
        DeviceType := 'JPEG Image File';

      rfPrinter:
        DeviceType := 'Printer';

      rfReportText:
        DeviceType := 'ReportTextFile';

      rfRTF:
        DeviceType := 'RTF Document';

      rfText:
        DeviceType := 'TextFile';

      rfWindowsMetafile:
        DeviceType := 'Windows Metafile';

      rfXHTML:
        DeviceType := 'XHTML Document';

      else
        DeviceType := 'Screen';
    end; // case
  end;
  FDeviceType := Report.DeviceType;
end;


function TacCustomReport.casosEspeciais(valorOriginal: string): string;
begin
  result := valorOriginal;
end;

procedure TacCustomReport.ReportPreviewFormCreate(Sender: TObject);
begin
  //
end;

end.



