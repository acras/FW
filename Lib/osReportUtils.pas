unit osReportUtils;


interface

uses Classes, acCustomSQLMainDataUn, osSQLDataSet, SysUtils, DB, ppReport, daDataModule,
  daQueryDataView, ppTypes,daIDE, daDBExpress, ppCTDsgn, raIDE, myChkBox,
  ppModule, FMTBcd, osCustomDataSetProvider, SqlExpr,
  osSQLDataSetProvider, daSQl, osSQLQuery, osComboFilter, ppDBPipe, osClientDataSet,
  acReportContainer, Forms; 

  type TIdade = class
  private
    Fdias: integer;
    FdataReferencia: TDateTime;
  protected
    function getAnos: integer;
    function getDias: integer;
    function getMeses: integer;
    function getString: string;
  public
    constructor Create(dias: integer);
    property dias: integer read getDias;
    property anos: integer read getAnos;
    property meses: integer read getMeses;
    property dataReferencia: TDateTime read FdataReferencia write FdataReferencia;
    property asString: string read getString;
  end;


  function getIdadeDias(idade: string): integer;
  function getTemplateByName(name: string; stream: TStream): boolean;
  function getTemplateByID(id: integer; stream: TStream): boolean;
  function getTemplateIDByName(name: string): integer;

  procedure replaceReportSQL(report: TppReport; template: TMemoryStream; strSQL: String);
  procedure replaceReportSQLAddParam(report: TppReport; template: TMemoryStream;
    strSelect: String; strWhere: String; strOrder: string = '');

  procedure replaceReportSQLAddWhere(report: TppReport; template: TMemoryStream;
    strWHERE: String);
  function tiraNumerosDoFinal(str: String): string;
  function ConvertMask(mask: string): string;
  procedure replaceReportSQL2(report: TppReport; template: TMemoryStream;
    strSQL: String; params: TStringList = nil; mapeamentos: TStringList = nil;
    recipient: TDataModule = nil);

implementation

uses daDataView, ppClass, FwConstants, DateUtils, Dialogs; // RelatorioEditFormUn

function getTemplateByName(name: string; stream: TStream): boolean;
var
  query: TosSQLDataset;
  report: string;
begin
  name := UpperCase(Name);
  Result := false;
  report := TacReportContainer(Application.MainForm.FindComponent('FReportDepot')).
    findReportByName(name); 
  if Length(report) > 0 then
  begin
    stream.Write(report[1],Length(report));
    Result := True;
  end
  else
  begin
    query := TosSQLDataSet.Create(nil);
    try
      query.SQLConnection := acCustomSQLMainData.SQLConnectionMeta;
      query.CommandText := ' SELECT ' +
                           '   template, '+
                           '   ITEM_ID '+
                           ' FROM ' +
                           '   RB_ITEM '+
                           ' WHERE ' +
                           '   UPPER(name) like UPPER(' + quotedStr(name) + ')';
      query.Open;
      if query.RecordCount>0 then
      begin
        TBLOBField(query.fields[0]).SaveToStream(stream);
        TacReportContainer(Application.MainForm.FindComponent('FReportDepot')).
          addReport(query.fields[1].AsInteger, name, TBLOBField(query.fields[0]).AsString);
        Result := true;
      end;
    finally
      FreeAndNil(query);
    end;
  end;
end;

function getTemplateIDByName(name: string): integer;
var
  query: TosSQLDataset;
  id: Integer;
begin
  name := UpperCase(Name);
  id := TacReportContainer(Application.MainForm.FindComponent('FReportDepot')).
    findRportIdByName(name);
  if id <> -1 then
  begin
    Result := id;
  end
  else
  begin
    query := TosSQLDataSet.Create(nil);
    try
      query.SQLConnection := acCustomSQLMainData.SQLConnection;
      query.CommandText := ' SELECT ' +
                           '   ITEM_ID '+
                           ' FROM ' +
                           '   RB_Item '+
                           ' WHERE ' +
                           '   UPPER(name) like UPPER(' + quotedStr(name) + ')';
      query.Open;
      Result := -1;
      if not query.eof then
        Result := query.fields[0].asInteger;
    finally
      FreeAndNil(query);
    end;
  end;
end;


function getTemplateById(id: integer; stream: TStream): boolean;
var
  query: TosSQLDataset;
  report: string;
begin
  Result := false;
  report := TacReportContainer(Application.MainForm.FindComponent('FReportDepot')).
    findReportById(id);
  if Length(report) > 0 then
  begin
    stream.Write(report[1],Length(report));
    Result := True;
  end
  else
  begin
    query := TosSQLDataSet.Create(nil);
    try
      query.SQLConnection := acCustomSQLMainData.SQLConnection;
      query.CommandText := ' SELECT ' +
                           '   template, '+
                           '   name '+
                           ' FROM ' +
                           '   RB_ITEM '+
                           ' WHERE ' +
                           '   ITEM_ID = ' + intToStr(id);
      query.Open;
      if query.RecordCount>0 then
      begin
        TBLOBField(query.fields[0]).SaveToStream(stream);
        TacReportContainer(Application.MainForm.FindComponent('FReportDepot')).
          addReport(id, query.fields[1].AsString, query.fields[0].AsString);
        Result := True;
      end;
    finally
      FreeAndNil(query);
    end;
  end;
end;

procedure replaceReportSQLAddWhere(report: TppReport; template: TMemoryStream;
  strWHERE: String);
var
  lDataModule: TdaDataModule;
  liIndex, i: Integer;
  lDataView: TdaDataView;
  nomePipeline: string;
  aSQL: TdaSQL;
begin
  if template.Size <> 0 then
    report.Template.LoadFromStream(template);

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
          if UpperCase(nomePipeline) = 'PIPELINE' then
          begin
            aSQL := TdaQueryDataView(lDataView).SQL;
            aSQL.EditSQLAsText := True;
            aSQL.SQLText.Add(strWHERE);
          end;
        end;
        inc(liIndex);
      end;
    end;
end;


procedure replaceReportSQL2(report: TppReport; template: TMemoryStream;
  strSQL: String; params: TStringList; mapeamentos: TStringList;
  recipient: TDataModule);
var
  liIndex: Integer;
  lDataModule: TdaDataModule;
  lDataView: TdaDataView;
  aSQL: TDaSQL;
  i: integer;
  nomePipeline: string;
  pipeline: TComponent;
  function getSQL(nomePipeline: String): string;
  var
    i: integer;
    comp: TComponent;
  begin
    for i := 0 to mapeamentos.Count-1 do
    begin
      if UpperCase(nomePipeline) = UpperCase(Copy(mapeamentos[i], 0, pos(',',mapeamentos[i])-1)) then
      begin
        comp := recipient.FindComponent(copy(mapeamentos[i], pos(',',mapeamentos[i])+1,length(mapeamentos[i])));
        result := (comp as TSQLDataSet).CommandText;
        exit;
      end;
    end;
  end;

  function substParams(strSQL: String): string;
  var
    i: Integer;
    nomeParam: string;
    valor: integer;
  begin
    for i := 0 to params.Count-1 do
    begin
      nomeParam := copy(params[i], 0, pos('=', params[i])-1);
      valor := strToInt(copy(params[i], pos('=', params[i])+1, length(params[i])));
      while Pos(':'+upperCase(nomeParam), upperCase(strSQL))>0 do
      begin
        strSQL := copy(strSQL, 0, Pos(':'+upperCase(nomeParam), upperCase(strSQL))-1) + intToStr(valor) +
          copy(strSQL,Pos(':'+upperCase(nomeParam), upperCase(strSQL))+1+length(':'+nomeParam),length(strSQL))
      end;
      result := StrSQL;
    end;
  end;
begin
  report.Template.LoadFromStream(template);

//  aSQL := nil;

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
          if recipient<>nil then
          begin
            pipeline := recipient.FindComponent(nomePipeline);

            if TosClientDataSet(TppDBPipeline(pipeline).DataSource.DataSet).dataProvider<>nil then
              strSQL := TosSQLDataSet(TosSQLDataSetProvider(TosClientDataSet(TppDBPipeline(pipeline).DataSource.DataSet).dataProvider).dataset).commandtext
            else
              strSQL := getSQL(nomePipeline);

            strSQL := substParams(strSQL);

            aSQL := TdaQueryDataView(lDataView).SQL;
            aSQL.EditSQLAsText := True;
            if strSQL <> '' then
              aSQL.SQLText.Text := strSQL;
          end;
        end;
        inc(liindex);
      end;
    end;
end;

{-------------------------------------------------------------------------
�Objetivo�� > Esta fun��o foi criada para que se ache componentes renomeados
                pelo delphi. Por exemplo Pipeline vira Pipeline1
�Par�metros > str: a string a ser alterada
�Retorno��� >
�Cria��o��� >
�Observa��es> Coment�rio inicializado em 07/03/2006 por Ricardo N. Acras
�Atualiza��o> 07/03/2006 - Inserido inicializa��o do index
�------------------------------------------------------------------------}
function tiraNumerosDoFinal(str: String): string;
var
  i, index: integer;
begin
  index := 0;
  for i := length(str) downto 0 do
  begin
    if not((Ord(str[i])>=48) AND (Ord(str[i])<=57)) then
    begin
      index := i;
      break;
    end;
  end;
  result := copy(str, 0, index);
end;

procedure replaceReportSQL(report: TppReport; template: TMemoryStream; strSQL: String);
var
  liIndex, i: Integer;
  lDataModule: TdaDataModule;
  lDataView: TdaDataView;
  aSQL: TDaSQL;
  nomePipeline: String;
begin
  report.Template.LoadFromStream(template);

  aSQL := nil;

  lDataModule := daGetDataModule(Report.MainReport);

  if (lDataModule <> nil) then
    begin

      liIndex := 0;

      while (liIndex < lDatamodule.DataViewCount) and (aSQL = nil) do
        begin

          lDataView := lDataModule.DataViews[liIndex];
          if (lDataView <> nil) and (lDataView is TdaQueryDataView) and (Report.Datapipeline <> nil)
            and (Report.DataPipeline.Dataview = lDataview) then
          begin
            for i := 0 to lDataView.DataPipelineCount-1 do
            begin
              nomePipeline := tiraNumerosDoFinal(lDataView.DataPipelines[i].Name) ;
              if (UpperCase(nomePipeline)=upperCase(report.DataPipeline.Name)) then
              begin
                aSQL := TdaQueryDataView(lDataView).SQL;
                aSQL.EditSQLAsText := True;
                if strSQL <> '' then
                  aSQL.SQLText.Text := strSQL;
              end;
            end;
          end;

          Inc(liIndex);

        end;
    end;
end;

function ConvertMask(mask: string): string;
const
  point: char = '.';
  comma: char = ',';
var
  n: integer;
  i: integer;
  c: char;
begin
  n := Length(mask);
  if n > 0 then
  begin
    SetLength(Result, n);
    for i := 1 to n do
    begin
      c := mask[i];
      if c = comma then
        c := point
      else if c = point then
        c := comma;
      Result[i] := c;
    end;
  end
  else
    Result := '';
end;

{ TIdade }

constructor TIdade.Create(dias: integer);
begin
  Fdias := dias;
  dataReferencia := acCustomSQLMainData.GetServerDate;
end;

function TIdade.getAnos: integer;
var
  dia, mes, ano: word;
  diaAtual, mesAtual, anoAtual: word;
  dataFinal: TDateTime;
  numAnos: integer;
begin
  DecodeDate(dataReferencia, anoAtual, mesAtual, diaAtual);
  DecodeDate(dataReferencia-Fdias, ano, mes, dia);
  dataFinal := dataReferencia;

  //calcular o n�mero de anos que a pessoa possui
  numAnos := anoAtual - ano;
  //se o m�s atual � maior que o m�s do nascimento, j� fechou o �ltimo ano
  //  nenhum c�lculo adicional necess�rio
  //se o m�s � menor ou o m�s � igual mas o dia � menor deve decrementar o ano
  if ((mesAtual<mes) OR ((mesAtual=mes)AND(diaAtual<dia))) then
    numAnos := numAnos-1;

  result := numAnos;
end;

function TIdade.getMeses: integer;
var
  dia, mes, ano: word;
  diaAtual, mesAtual, anoAtual: word;
  dataFinal: TDateTime;
  numMeses: integer;
begin
  DecodeDate(dataReferencia, anoAtual, mesAtual, diaAtual);
  DecodeDate(dataReferencia-Fdias, ano, mes, dia);
  dataFinal := dataReferencia;

  //calcular o n�mero de meses que a pessoa possui
  numMeses := getAnos*12;
  if mesAtual<mes then
    numMeses := numMeses + 12-mes+mesAtual;
  if mes<mesAtual then
    numMeses := numMeses + mesAtual-mes;
  if mes=mesAtual then
    numMeses:= 12;

  //corrigir o n�mero de meses pois pode ainda n�o ter fechado o �ltimo
  if diaAtual<dia then
    numMeses := numMeses-1;

  result := numMeses;
end;

function TIdade.getDias: integer;
begin
  result := Fdias;
end;

function TIdade.getString: string;
var
  numDias, numMeses, difMeses, numAnos: integer;
  dia, mes, ano: word;
  diaAtual, mesAtual, anoAtual: word;
  dataNascimento, dataCalculo1, dataCalculo2: TDateTime;
  difDias: integer;
  iTemp: integer;
  strMes: string;
begin
  numAnos := Fdias div 365;
  if (Fdias mod 365) >= 360 then
    difMeses := 11
  else
    difMeses := (Fdias mod 365) div 30;
  numDias := (Fdias mod 365) mod 30;
  if Fdias<limiarDias then
  begin
    result := inttoStr(numDias) + ' dia';
    if numDias>1 then
      result := result+'s';
  end;
  if (Fdias>=limiarDias) AND (Fdias<limiarMeses) then
  begin
    if difMeses>1 then
      result := intToStr(difMeses) + ' meses'
    else
      if difMeses>0 then
        result := intToStr(difMeses) + ' m�s';
    if numDias>0 then
    begin
      if difMeses>0 then
        result := result + ' e ';
      if numDias>1 then
        result := result + IntToStr(numDias) + ' dias'
      else
        result := result + IntToStr(numDias) + ' dia';
    end;
  end;
  if (Fdias>=limiarMeses) AND (Fdias<limiarAnos) then
  begin
    if numAnos > 1 then
      result := IntToStr(numAnos) + ' anos'
    else
      result := IntToStr(numAnos) + ' ano';
    if difMeses>0 then
      if difMeses>1 then
        result := result + ' e ' + IntToStr(difMeses) + ' meses'
      else
        result := result + ' e ' + IntToStr(difMeses) + ' m�s';
  end;
  if Fdias>=limiarAnos then
  begin
    if numAnos>1 then
      result := inttoStr(numAnos) + ' anos'
    else
      result := inttoStr(numAnos) + ' ano';
  end;

end;

function getIdadeDias(idade: string): integer;
var
  tipoIdade: String;
  original, fatorMult: integer;
begin
  idade := trim(idade);
  tipoIdade := idade[length(idade)];
  fatorMult := 1;
  case tipoIdade[1] of
    'd': fatorMult := 1;
    'm': fatorMult := 30;
    'a': fatorMult := 360;
  end;
  original := StrToInt(copy(idade, 1, length(idade)-1));
  result := original * fatorMult;
end;

procedure replaceReportSQLAddParam(report: TppReport; template: TMemoryStream;
  strSelect: String; strWhere: String; strOrder: string);
var
  liIndex, i, y: Integer;
  lDataModule: TdaDataModule;
  lDataView: TdaDataView;
  aSQL: TDaSQL;
  nomePipeline: String;
  crit: TdaCriteria;
  ord: TdaField;
  criterios, item: TStringList;
begin
  report.Template.LoadFromStream(template);

  aSQL := nil;

  lDataModule := daGetDataModule(Report.MainReport);

  if (lDataModule <> nil) then
  begin

    liIndex := 0;

    while (liIndex < lDatamodule.DataViewCount) and (aSQL = nil) do
    begin

      lDataView := lDataModule.DataViews[liIndex];
      if (lDataView <> nil) and (lDataView is TdaQueryDataView) and (Report.Datapipeline <> nil)
        and (Report.DataPipeline.Dataview = lDataview) then
      begin
        for i := 0 to lDataView.DataPipelineCount-1 do
        begin
          nomePipeline := tiraNumerosDoFinal(lDataView.DataPipelines[i].Name) ;
          if (UpperCase(nomePipeline)=upperCase(report.DataPipeline.Name)) then
          begin
            aSQL := TdaQueryDataView(lDataView).SQL;
            if aSQL.EditSQLAsText then
            begin
              if strSelect <> '' then
                aSQL.SQLText.Text := strSelect;
            end
            else
            begin
              if strWhere <> '' then
              begin
                crit := aSQL.AddCriteria(dacrField);
                crit.Expression := '1';
                crit.Value := '1 AND '+strWhere;
              end;

              if strOrder <> '' then
              begin
                try
                  criterios := TStringList.Create;

                  criterios.Delimiter := ',';
                  criterios.DelimitedText :=
                    '"' + StringReplace(strOrder, ',', '"' + ',' + '"', [rfReplaceAll]) + '"';

                  for y := 0 to criterios.Count -1 do
                  begin
                    try
                      item := TStringList.Create;
                      item.Delimiter := '.';
                      item.DelimitedText := criterios.Strings[y]; 

                      ord := TdaField.Create(nil);
                      ord.ChildType := 2;
                      ord.Alias := item.Strings[1];
                      ord.FieldAlias := item.Strings[1];
                      ord.FieldName := item.Strings[1];
                      ord.SQLFieldName := item.Strings[1];
                      ord.TableAlias := nomePipeline;
                      ord.TableSQLAlias := item.Strings[0];

                      // na migra��o para o XE o comportamento da string list pode mudar
                      // atualmente independente do caracter de quebra o espa�o tbm � quebrado
                      if (item.Count = 3) and (UpperCase(item.Strings[2]) = 'DESC') then
                        aSQL.AddOrderByField(ord,False)
                      else
                        aSQL.AddOrderByField(ord,True);
                    finally
                      FreeAndNil(ord);
                      FreeAndNil(item);
                    end;
                  end;
                finally
                  FreeAndNil(criterios);
                end;
              end;
            end;
          end;
        end;
      end;

      Inc(liIndex);

    end;
  end;
end;

end.
