object logger: Tlogger
  OldCreateOrder = False
  Left = 380
  Top = 288
  Height = 150
  Width = 215
  object MasterDataSet: TosSQLDataSet
    CommandText = 
      'SELECT'#13#10'  IDLog,'#9#13#10'  IDRegistro,'#13#10'  IDUsuario,'#13#10'  DataHora,'#13#10'  C' +
      'lasse,'#13#10'  Tipo,'#13#10'  Descricao'#13#10'FROM '#13#10'  Log'#13#10'WHERE'#13#10'  IDLog= :ID'#13 +
      #10
    MaxBlobSize = 32
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end>
    SQLConnection = MainData.SQLConnection
    Left = 40
    Top = 24
    object MasterDataSetIDLOG: TIntegerField
      FieldName = 'IDLOG'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object MasterDataSetIDREGISTRO: TIntegerField
      FieldName = 'IDREGISTRO'
      ProviderFlags = [pfInUpdate]
    end
    object MasterDataSetIDUSUARIO: TIntegerField
      FieldName = 'IDUSUARIO'
      ProviderFlags = [pfInUpdate]
    end
    object MasterDataSetDATAHORA: TSQLTimeStampField
      FieldName = 'DATAHORA'
      ProviderFlags = [pfInUpdate]
    end
    object MasterDataSetCLASSE: TIntegerField
      FieldName = 'CLASSE'
      ProviderFlags = [pfInUpdate]
    end
    object MasterDataSetTIPO: TIntegerField
      FieldName = 'TIPO'
      ProviderFlags = [pfInUpdate]
    end
    object MasterDataSetDESCRICAO: TBlobField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
  end
  object MasterProvider: TosSQLDataSetProvider
    DataSet = MasterDataSet
    Options = [poIncFieldProps, poNoReset]
    Left = 136
    Top = 24
  end
  object cdsLogger: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    DataProvider = MasterProvider
    Left = 80
    Top = 72
    object cdsLoggerIDLOG: TIntegerField
      FieldName = 'IDLOG'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsLoggerIDREGISTRO: TIntegerField
      FieldName = 'IDREGISTRO'
      ProviderFlags = [pfInUpdate]
    end
    object cdsLoggerIDUSUARIO: TIntegerField
      FieldName = 'IDUSUARIO'
      ProviderFlags = [pfInUpdate]
    end
    object cdsLoggerDATAHORA: TSQLTimeStampField
      FieldName = 'DATAHORA'
      ProviderFlags = [pfInUpdate]
    end
    object cdsLoggerCLASSE: TIntegerField
      FieldName = 'CLASSE'
      ProviderFlags = [pfInUpdate]
    end
    object cdsLoggerTIPO: TIntegerField
      FieldName = 'TIPO'
      ProviderFlags = [pfInUpdate]
    end
    object cdsLoggerDESCRICAO: TBlobField
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
  end
end
