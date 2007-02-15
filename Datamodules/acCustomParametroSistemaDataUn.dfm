object acCustomParametroSistemaData: TacCustomParametroSistemaData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 641
  Top = 357
  Height = 326
  Width = 383
  object MasterDataSet: TosSQLDataSet
    CommandText = 'SELECT'#13#10'  '#13#10'FROM'#13#10'  ParametroSistema P'#13#10#13#10
    MaxBlobSize = 32
    Params = <>
    SQLConnection = MainData.SQLConnection
    Left = 40
    Top = 24
  end
  object MasterProvider: TosSQLDataSetProvider
    DataSet = MasterDataSet
    Options = [poNoReset]
    Left = 156
    Top = 24
  end
  object ParamQuery: TosSQLQuery
    MaxBlobSize = 32
    Params = <>
    SQLConnection = MainData.SQLConnection
    Left = 44
    Top = 108
  end
  object MasterClientDataset: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    DataProvider = MasterProvider
    Left = 268
    Top = 24
  end
end
