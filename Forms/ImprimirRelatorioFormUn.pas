unit ImprimirRelatorioFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, osCustomEditFrm, Menus, ImgList, DB, ActnList, osActionList,
  Buttons, ExtCtrls, osUtils, DBClient, osClientDataset, StdCtrls, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, osComboFilter, osSQLQuery, ppReport,
  ppComm, ppRelatv, ppProd, ppClass, osCustomSearchFrm;

type
  TImprimirRelatorioForm = class(TosCustomEditForm)
    osClientDataset1: TosClientDataset;
    Report: TppReport;
    FilterDataSet: TosClientDataset;
    ComboFilter: TosComboFilter;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    procedure ImprimirRelatorioComFiltro(idRelatorio: integer);

    { Private declarations }
  public
    function Edit(const KeyFields: string; const KeyValues: Variant): boolean; override;
  end;

var
  ImprimirRelatorioForm: TImprimirRelatorioForm;

implementation

uses osReportUtils, SQLMainData;

{$R *.dfm}

{ TImprimirRelatorioForm }

function TImprimirRelatorioForm.Edit(const KeyFields: string;
  const KeyValues: Variant): boolean;
begin
  ImprimirRelatorioComFiltro(KeyValues);
  result := true;
end;

procedure TImprimirRelatorioForm.ImprimirRelatorioComFiltro(idRelatorio: integer);
var
  stream: TMemoryStream;
  qry: TosSQLQuery;
  templateName, FilterName: string;
  srchForm: TCustomSearchForm;
begin
  //buscar informações no catálogo de relatórios
  qry := MainData.GetQuery;
  try
    qry.sql.Text := 'SELECT ' +
                    ' RB.Name as TemplateName, '+
                    ' F.Name as NomeFiltro' +
                    ' FROM Relatorio R ' +
                    ' LEFT JOIN XFilterDef F ' +
                    '   ON F.IDXFilterDef=R.IDXFilterDef ' +
                    ' JOIN RB_ITEM RB' +
                    '   ON RB.ITEM_ID = R.ITEM_ID ' +
                    ' WHERE IdRelatorio=' + IntToStr(idRelatorio);
    qry.Open;
    templateName := qry.FieldByName('TemplateName').AsString;
    FilterName := qry.FieldByName('NomeFiltro').AsString;

  finally
    MainData.FreeQuery(qry);
  end;
  stream := TMemoryStream.Create;
  getTemplateByName(TemplateName, stream);

  if FilterName <> '' then
  begin
    srchForm := TCustomSearchForm.Create(application);

    with srchForm do
    begin
      FilterDefName := filterName;
      srchForm.DataProvider := MainData.prvFilter;
      Execute('',3,toRetornarQuery);
      replaceReportSQL(report, stream, sqlResult.GetText);
      free;
    end;
//    with ComboFilter do
//    begin
//      ClearViews;
//      FilterDefName := FilterName;
//      GetViews;
//      replaceReportSQL(report, stream, getSQLFilter(dummy));
//    end;
  end
  else
    Report.Template.LoadFromStream(stream);

  report.Print;
end;

procedure TImprimirRelatorioForm.ReportPreviewFormCreate(Sender: TObject);
begin
  inherited;
  report.PreviewForm.WindowState := wsMaximized;
//  Report.PreviewForm.
end;

initialization
  OSRegisterClass(TImprimirRelatorioForm);

end.
