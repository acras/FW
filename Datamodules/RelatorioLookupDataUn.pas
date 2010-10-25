unit RelatorioLookupDataUn;

interface

uses
  SysUtils, Classes, DB, DBClient, osClientDataset, osLookupDataUn, FMTBcd,
  Provider, osCustomDataSetProvider, osSQLDataSetProvider, SqlExpr,
  osSQLDataSet;

type
  TRelatorioLookupData = class(TosLookupData)
    TipoRelatorioClientDataSet: TosClientDataset;
    TipoRelatorioLookupDataSet: TosSQLDataSet;
    TipoRelatorioLookupProvider: TosSQLDataSetProvider;
    TipoRelatorioClientDataSetNOME: TStringField;
    TemplateClientDataset: TosClientDataset;
    TemplateLookupDataSet: TosSQLDataSet;
    TemplateLookupProvider: TosSQLDataSetProvider;
    TemplateLookupDataSetNOME: TStringField;
    TemplateLookupDataSetITEM_ID: TIntegerField;
    TemplateClientDatasetNOME: TStringField;
    TemplateClientDatasetITEM_ID: TIntegerField;
    FilterDefClientDataSet: TosClientDataset;
    FilterDefLookupDataSet: TosSQLDataSet;
    FilterDefLookupProvider: TosSQLDataSetProvider;
    FilterDefLookupDataSetNAME: TStringField;
    FilterDefClientDataSetNAME: TStringField;
    FilterDefLookupDataSetIDXFILTERDEF: TIntegerField;
    FilterDefClientDataSetIDXFILTERDEF: TIntegerField;
    TipoRelatorioClientDataSetIDTIPORELATORIO: TIntegerField;
    RelatorioClientDataset: TosClientDataset;
    RelatorioDataSet: TosSQLDataSet;
    RelatorioDataSetProvider: TosSQLDataSetProvider;
    RelatorioClientDatasetIDRELATORIO: TIntegerField;
    RelatorioClientDatasetTITULO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure GetData;  override;
  end;

var
  RelatorioLookupData: TRelatorioLookupData;

implementation

uses acCustomSQLMainDataUn;

{$R *.dfm}

procedure TRelatorioLookupData.GetData;
begin
  acCustomSQLMainData.RegisterRefreshTable(tnTipoRelatorio, TipoRelatorioClientDataSet);
end;

procedure TRelatorioLookupData.DataModuleCreate(Sender: TObject);
begin
  inherited;
   TipoRelatorioLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
   TemplateLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
   FilterDefLookupDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
   RelatorioDataSet.SQLConnection := acCustomSQLMainData.SQLConnection;
end;

end.
