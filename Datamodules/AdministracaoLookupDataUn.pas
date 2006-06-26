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
  private
    { Private declarations }
  public
    procedure GetData; override;

  end;

var
  AdministracaoLookupData: TAdministracaoLookupData;

implementation

uses SQLMainData;


{$R *.dfm}


procedure TAdministracaoLookupData.GetData;
begin
  with MainData do
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

end.
