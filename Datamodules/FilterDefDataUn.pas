unit FilterDefDataUn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Provider, Db, DBTables, FMTBcd, SqlExpr,
  osSQLDataSetProvider, osCustomDataSetProvider, osUtils, osSQLDataSet;

type
  TFilterDefData = class(TDataModule)
    MasterDatasource: TDataSource;
    MasterProvider: TosSQLDataSetProvider;
    MasterDataset: TosSQLDataset;
    FilterDefDetailDataset: TosSQLDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FilterDefData: TFilterDefData;

implementation

uses acCustomSQLMainDataUn;

{$R *.DFM}

initialization
  OSRegisterClass(TFilterDefData);
  
end.
