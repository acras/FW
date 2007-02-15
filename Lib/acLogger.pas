unit acLogger;

interface

uses
  SysUtils, Classes, FMTBcd, Provider, osCustomDataSetProvider,
  osSQLDataSetProvider, DB, SqlExpr, osSQLDataSet, DBClient,
  osClientDataset;

type
  Tlogger = class(TDataModule)
    MasterDataSet: TosSQLDataSet;
    MasterProvider: TosSQLDataSetProvider;
    MasterDataSetIDLOG: TIntegerField;
    MasterDataSetIDREGISTRO: TIntegerField;
    MasterDataSetIDUSUARIO: TIntegerField;
    MasterDataSetDATAHORA: TSQLTimeStampField;
    MasterDataSetCLASSE: TIntegerField;
    MasterDataSetTIPO: TIntegerField;
    MasterDataSetDESCRICAO: TBlobField;
    cdsLogger: TosClientDataset;
    cdsLoggerIDLOG: TIntegerField;
    cdsLoggerIDREGISTRO: TIntegerField;
    cdsLoggerIDUSUARIO: TIntegerField;
    cdsLoggerDATAHORA: TSQLTimeStampField;
    cdsLoggerCLASSE: TIntegerField;
    cdsLoggerTIPO: TIntegerField;
    cdsLoggerDESCRICAO: TBlobField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure registerLog(log_class, log_code: integer; idRegistro: integer = 0;
      description: string = '');
    function getLogClassList: TStrings;
    function getLogTiposList(log_class: integer): TStrings;
    procedure registerLogForFieldChange(log_class, log_code: integer;
      field: TField; idRegistro: integer = 0);
  end;

var
  logger: Tlogger;

implementation


uses LogCodes, SQLMainData, acCustomSQLMainDataUn, UsuarioDataUn, osLogin,
  Math, Variants;

{$R *.dfm}

{ Tlogger }

function Tlogger.getLogClassList: TStrings;
var
  i: integer;
begin
  result := TStringList.Create;
  for i := 1 to MAX_CODE do
  begin
    if (logTitulosClasses[i] <> '') then
      result.Add(logTitulosClasses[i] + #9 + inttostr(i))
  end;
end;

function Tlogger.getLogTiposList(log_class: integer): TStrings;
var
  i: integer;
begin
  result := TStringList.Create;
  for i := 1 to MAX_CODE do
  begin
    if (logTitulosTipos[log_class][i] <> '') then
      result.Add(logTitulosTipos[log_class][i] + #9 + inttostr(i))
  end;
end;

procedure Tlogger.registerLog(log_class, log_code: integer; idRegistro: integer = 0;
  description: string = '');
begin
  cdsLogger.close;
  cdsLogger.Open;
  cdsLogger.Append;
  cdsLoggerIDLOG.Value := MainData.GetNewID('idLog');
  cdsLoggerCLASSE.Value := log_class;
  cdsLoggerTIPO.Value := log_code;
  cdsLoggerDATAHORA.AsDateTime := MainData.GetServerDatetime;
  if idRegistro <> 0 then
    cdsLoggerIDREGISTRO.Value := idRegistro;
  cdsLoggerDESCRICAO.Value := description;

  with TLoginUsuario.create do
  begin
    getInfoUsuarioLogadoSistema;
    cdsLoggerIDUSUARIO.Value := IDUsuario;
  end;

  cdsLogger.Post;
  cdsLogger.ApplyUpdates(0);
end;

procedure Tlogger.registerLogForFieldChange(log_class, log_code: integer;
  field: TField; idRegistro: integer = 0);
begin
  if (field.OldValue<>field.NewValue) AND (field.NewValue<>Unassigned) then
    logger.registerLog(log_class, log_code, idRegistro,
       'Valor Antigo: ' + VarToStr(field.OldValue) + ', valor novo: ' + VarToStr(field.NewValue));
end;

end.
