unit acCustomParametroSistemaDataUn;

interface

uses
  SysUtils, Classes, FMTBcd, DB, Provider, osSQLDataSetProvider, SqlExpr,
  osCustomDataSetProvider, osUtils, osSQLQuery, osSQLDataSet, DBClient,
  osClientDataset;

type
  TacCustomParametroSistemaData = class(TDataModule)
    MasterDataSet: TosSQLDataset;
    MasterProvider: TosSQLDataSetProvider;
    ParamQuery: TosSQLQuery;
    MasterClientDataset: TosClientDataset;

    procedure DataModuleCreate(Sender: TObject);
//    procedure MasterClientDatasetCalcFields(DataSet: TDataSet);

  private

  public
//    procedure Validate(PDataSet: TDataSet);
//    function GetNextOrcamento : integer;
    function getNomeImpressoraClasse(nomeClasseImpressora: string): string; virtual;
  end;

var
  acCustomParametroSistemaData: TacCustomParametroSistemaData;

implementation

uses acCustomSQLMainDataUn, osErrorHandler, osCIC, SQLMainData;

{$R *.dfm}

{function TacCustomParametroSistemaData.GetNextOrcamento: integer;
var
  sp: TSQLStoredProc;
  iNumOrcamento : integer;
begin
  sp := TSQLStoredProc.Create(nil);
  try
    sp.SQLConnection := MainData.SQLConnection;
    sp.StoredProcName := 'OS_PROTOCOLO';
    sp.ExecProc;
    iNumOrcamento := sp.Params[0].AsInteger;
  finally
    freeAndNil(sp);
  end;
  Result := (iNumOrcamento * 10) + CalcDV_Modulo11(iNumOrcamento);
end;

{procedure TacCustomParametroSistemaData.Validate(PDataSet: TDataSet);
begin
  with PDataSet, HError do
  begin
    Clear;
    CheckEmpty(FieldByName('IDEmpresa'));
    Check;
  end;
end;}

procedure TacCustomParametroSistemaData.DataModuleCreate(Sender: TObject);
begin
  MainData.RegisterRefreshTable(tnParametroSistema, MasterClientDataset);
//  MainData.RegisterRefreshTable(tnFeriado, FeriadoClientDataSet);
end;


{procedure TacCustomParametroSistemaData.MasterClientDatasetCalcFields(DataSet: TDataSet);
begin
  MasterClientDatasetBairroCidadeUF.Value := MasterClientDatasetBAIRRO.Value + ' - '
                                           + MasterClientDatasetCIDADE.Value + ' - '
                                           + MasterClientDatasetUF.Value;
end;

initialization
  OSRegisterClass(TacCustomParametroSistemaData);}

function TacCustomParametroSistemaData.getNomeImpressoraClasse(
  nomeClasseImpressora: string): string;
begin
  result := '';
end;

end.
