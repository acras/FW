unit RelatorioLookupDataUn;

interface

uses
  SysUtils, Classes, DB, DBClient, osClientDataset, osLookupDataUn, FMTBcd,
  Provider, osCustomDataSetProvider, osSQLDataSetProvider, SqlExpr,
  osSQLDataSet, acCustomSQLMainDataUn;

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
  private
    { Private declarations }
  public
    procedure GetData;  override;
  end;

var
  RelatorioLookupData: TRelatorioLookupData;

implementation

uses SQLMainData;

{$R *.dfm}

procedure TRelatorioLookupData.GetData;
begin
  MainData.RegisterRefreshTable(tnTipoRelatorio, TipoRelatorioClientDataSet);
end;

end.
