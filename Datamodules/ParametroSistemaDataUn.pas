unit ParametroSistemaDataUn;

interface

uses
  SysUtils, Classes, FMTBcd, DB, Provider, osSQLDataSetProvider, SqlExpr,
  osCustomDataSetProvider, osUtils, osSQLQuery, osSQLDataSet, DBClient,
  osClientDataset;

type
  TParametroSistemaData = class(TDataModule)
    MasterDataSet: TosSQLDataset;
    MasterProvider: TosSQLDataSetProvider;
    ParamQuery: TosSQLQuery;
    MasterDataSetIDEMPRESA2: TIntegerField;
    MasterDataSetLOGO: TBlobField;
    FeriadoClientDataset: TosClientDataset;
    FeriadoDataSet: TSQLDataSet;
    FeriadoProvider: TosSQLDataSetProvider;
    FeriadoDataSetDATA: TSQLTimeStampField;
    FeriadoClientDatasetDATA: TSQLTimeStampField;
    MasterClientDataset: TosClientDataset;
    MasterClientDatasetNOMEFANTASIA: TStringField;
    MasterClientDatasetENDERECO: TStringField;
    MasterClientDatasetBAIRRO: TStringField;
    MasterClientDatasetCIDADE: TStringField;
    MasterClientDatasetUF: TStringField;
    MasterClientDatasetTELEFONE: TStringField;
    MasterClientDatasetLOGO: TBlobField;
    MasterClientDatasetBairroCidadeUF: TStringField;
    MasterClientDatasetIDEMPRESA: TIntegerField;
    MasterDataSetNOMEFANTASIA: TStringField;
    MasterDataSetENDERECO: TStringField;
    MasterDataSetBAIRRO: TStringField;
    MasterDataSetCIDADE: TStringField;
    MasterDataSetUF: TStringField;
    MasterDataSetTELEFONE: TStringField;
    MasterDataSetMENSAGEMORCAMENTO: TStringField;
    MasterDataSetMENSAGEMLOCACAO: TStringField;
    MasterDataSetNOMELOCATARIO: TStringField;
    MasterClientDatasetMENSAGEMORCAMENTO: TStringField;
    MasterClientDatasetMENSAGEMLOCACAO: TStringField;
    MasterClientDatasetNOMELOCATARIO: TStringField;

    procedure DataModuleCreate(Sender: TObject);
    procedure MasterClientDatasetCalcFields(DataSet: TDataSet);

  private

  public
    procedure Validate(PDataSet: TDataSet);
    function GetNextOrcamento : integer;
  end;

var
  ParametroSistemaData: TParametroSistemaData;

implementation

uses SQLMainData, osErrorHandler, osCIC;

{$R *.dfm}

function TParametroSistemaData.GetNextOrcamento: integer;
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

procedure TParametroSistemaData.Validate(PDataSet: TDataSet);
begin
  with PDataSet, HError do
  begin
    Clear;
    CheckEmpty(FieldByName('IDEmpresa'));
    Check;
  end;
end;

procedure TParametroSistemaData.DataModuleCreate(Sender: TObject);
begin
  MainData.RegisterRefreshTable(tnParametroSistema, MasterClientDataset);
  FeriadoDataSet.Params[0].AsDate := MainData.GetServerDatetime;
  MainData.RegisterRefreshTable(tnFeriado, FeriadoClientDataSet);
end;


procedure TParametroSistemaData.MasterClientDatasetCalcFields(DataSet: TDataSet);
begin
  MasterClientDatasetBairroCidadeUF.Value := MasterClientDatasetBAIRRO.Value + ' - '
                                           + MasterClientDatasetCIDADE.Value + ' - '
                                           + MasterClientDatasetUF.Value;
end;

initialization
  OSRegisterClass(TParametroSistemaData);

end.
