unit AdministracaoLookupDataUn;

interface

uses
  SysUtils, Classes, DB, DBClient, osClientDataset, osLookupDataUn, FMTBcd,
  Provider, osCustomDataSetProvider, osSQLDataSetProvider, SqlExpr,
  osSQLDataSet, acCustomSQLMainDataUn;

type
  TAdministracaoLookupData = class(TosLookupData)
    UsuarioClientDataSet: TosClientDataset;
    UsuarioClientDataSetIDUSUARIO: TIntegerField;
    UsuarioClientDataSetNOME: TStringField;
    RecursoClientDataset: TosClientDataset;
    RecursoClientDatasetIDRECURSO: TIntegerField;
    RecursoClientDatasetNOME: TStringField;
    AcaoClientDataSet: TosClientDataset;
    AcaoClientDataSetIDACAO: TIntegerField;
    AcaoClientDataSetIDRECURSO: TIntegerField;
    AcaoClientDataSetNOME: TStringField;
    DominioClientDataset: TosClientDataset;
    DominioClientDatasetIDDOMINIO: TIntegerField;
    DominioClientDatasetDESCRICAO: TStringField;
    TipoRecursoClientDataSet: TosClientDataset;
    TipoRecursoClientDataSetIDTIPORECURSO: TIntegerField;
    TipoRecursoClientDataSetDESCRICAO: TStringField;
    CargoClientDataSet: TosClientDataset;
    CargoClientDataSetIDCARGO: TIntegerField;
    CargoClientDataSetNOME: TStringField;
    CargoLookupDataSet: TosSQLDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    CargoLookupProvider: TosSQLDataSetProvider;
    TipoRecursoLookupDataSet: TosSQLDataSet;
    IntegerField2: TIntegerField;
    StringField2: TStringField;
    TipoRecursoLookupProvider: TosSQLDataSetProvider;
    DominioLookupDataSet: TosSQLDataSet;
    DominioLookupDataSetIDDOMINIO: TIntegerField;
    DominioLookupDataSetDESCRICAO: TStringField;
    DominioLookupProvider: TosSQLDataSetProvider;
    AcaoLookupDataSet: TosSQLDataSet;
    AcaoLookupDataSetIDACAO: TIntegerField;
    AcaoLookupDataSetIDRECURSO: TIntegerField;
    AcaoLookupDataSetNOME: TStringField;
    AcaoLookupProvider: TosSQLDataSetProvider;
    RecursoLookupDataSet: TSQLDataSet;
    RecursoLookupDataSetIDRECURSO: TIntegerField;
    RecursoLookupDataSetNOME: TStringField;
    RecursoLookupProvider: TosSQLDataSetProvider;
    UsuarioLookupDataSet: TSQLDataSet;
    UsuarioLookupProvider: TosSQLDataSetProvider;
    UsuarioLookupDataSetIDUSUARIO: TIntegerField;
    UsuarioLookupDataSetNOME: TStringField;
    GrupoClientDataSet: TosClientDataset;
    GrupoLookupDataSet: TosSQLDataSet;
    GrupoLookupProvider: TosSQLDataSetProvider;
    GrupoLookupDataSetIDGRUPO: TIntegerField;
    GrupoLookupDataSetNOME: TStringField;
    GrupoClientDataSetIDGRUPO: TIntegerField;
    GrupoClientDataSetNOME: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure GetData; override;

  end;

var
  AdministracaoLookupData: TAdministracaoLookupData;

implementation


{$R *.dfm}


procedure TAdministracaoLookupData.GetData;
begin
  with acCustomSQLMainData do
  begin
    RegisterRefreshTable(tnUsuario, UsuarioClientDataSet);
    RegisterRefreshTable(tnRecurso, RecursoClientDataset);
    RegisterRefreshTable(tnAcao, AcaoClientDataSet);
    RegisterRefreshTable(tnDominio, DominioClientDataset);
    RegisterRefreshTable(tnTipoRecurso, TipoRecursoClientDataSet);
    RegisterRefreshTable(tnCargo, CargoClientDataSet);
    RegisterRefreshTable(tnGrupo, GrupoClientDataSet);
  end;
end;

procedure TAdministracaoLookupData.DataModuleCreate(Sender: TObject);
begin
  inherited;
  UsuarioLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
  RecursoLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
  AcaoLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
  DominioLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
  TipoRecursoLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
  CargoLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
  GrupoLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
  GetData;
end;

end.
