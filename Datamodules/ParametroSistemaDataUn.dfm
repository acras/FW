object ParametroSistemaData: TParametroSistemaData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 532
  Top = 268
  Height = 326
  Width = 383
  object MasterDataSet: TosSQLDataSet
    SQLConnection = MainData.SQLConnection
    CommandText = 
      'SELECT'#13#10'  E.NomeFantasia,'#13#10'  E.Endereco,'#13#10'  E.Bairro,'#13#10'  E.Cidad' +
      'e,'#13#10'  E.UF,'#13#10'  E.Telefone,'#13#10'  P.IDEmpresa,'#13#10'  P.Logo,'#13#10'  P.Mensa' +
      'gemOrcamento,'#13#10'  P.MensagemLocacao,'#13#10'  P.NomeLocatario'#13#10'FROM'#13#10'  ' +
      'ParametroSistema P'#13#10'  INNER JOIN Empresa E'#13#10'    ON P.IDEmpresa =' +
      ' E.IDEmpresa'#13#10#13#10
    MaxBlobSize = 32
    Params = <>
    Left = 40
    Top = 24
    object MasterDataSetIDEMPRESA2: TIntegerField
      FieldName = 'IDEMPRESA'
    end
    object MasterDataSetLOGO: TBlobField
      FieldName = 'LOGO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object MasterDataSetNOMEFANTASIA: TStringField
      FieldName = 'NOMEFANTASIA'
      ProviderFlags = []
      Size = 40
    end
    object MasterDataSetENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = []
      Size = 40
    end
    object MasterDataSetBAIRRO: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = []
      Size = 40
    end
    object MasterDataSetCIDADE: TStringField
      FieldName = 'CIDADE'
      ProviderFlags = []
      Size = 40
    end
    object MasterDataSetUF: TStringField
      FieldName = 'UF'
      ProviderFlags = []
      FixedChar = True
      Size = 2
    end
    object MasterDataSetTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = []
    end
    object MasterDataSetMENSAGEMORCAMENTO: TStringField
      FieldName = 'MENSAGEMORCAMENTO'
      ProviderFlags = [pfInUpdate]
      Size = 512
    end
    object MasterDataSetMENSAGEMLOCACAO: TStringField
      FieldName = 'MENSAGEMLOCACAO'
      ProviderFlags = [pfInUpdate]
      Size = 512
    end
    object MasterDataSetNOMELOCATARIO: TStringField
      FieldName = 'NOMELOCATARIO'
      ProviderFlags = [pfInUpdate]
      Size = 40
    end
  end
  object MasterProvider: TosSQLDataSetProvider
    DataSet = MasterDataSet
    Constraints = True
    Options = [poNoReset]
    Left = 156
    Top = 24
  end
  object ParamQuery: TosSQLQuery
    NoMetadata = True
    SQLConnection = MainData.SQLConnection
    MaxBlobSize = 32
    Params = <>
    Left = 44
    Top = 108
  end
  object FeriadoClientDataset: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    ProviderName = 'FeriadoProvider'
    Left = 296
    Top = 204
    object FeriadoClientDatasetDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
  end
  object FeriadoDataSet: TSQLDataSet
    SQLConnection = MainData.SQLConnection
    CommandText = 'select DATA from FERIADO'#13#10'where Data >:now'
    MaxBlobSize = 32
    Params = <
      item
        DataType = ftTimeStamp
        Name = 'now'
        ParamType = ptInput
      end>
    Left = 44
    Top = 204
    object FeriadoDataSetDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
  end
  object FeriadoProvider: TosSQLDataSetProvider
    DataSet = FeriadoDataSet
    Constraints = True
    Options = [poNoReset]
    Left = 172
    Top = 204
  end
  object MasterClientDataset: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    OnCalcFields = MasterClientDatasetCalcFields
    DataProvider = MasterProvider
    Left = 268
    Top = 24
    object MasterClientDatasetIDEMPRESA: TIntegerField
      FieldName = 'IDEMPRESA'
    end
    object MasterClientDatasetLOGO: TBlobField
      FieldName = 'LOGO'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object MasterClientDatasetNOMEFANTASIA: TStringField
      FieldName = 'NOMEFANTASIA'
      ProviderFlags = []
      Size = 40
    end
    object MasterClientDatasetENDERECO: TStringField
      FieldName = 'ENDERECO'
      ProviderFlags = []
      Size = 40
    end
    object MasterClientDatasetBAIRRO: TStringField
      FieldName = 'BAIRRO'
      ProviderFlags = []
      Size = 40
    end
    object MasterClientDatasetCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      ProviderFlags = []
      Size = 40
    end
    object MasterClientDatasetUF: TStringField
      FieldName = 'UF'
      ProviderFlags = []
      FixedChar = True
      Size = 2
    end
    object MasterClientDatasetTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = []
    end
    object MasterClientDatasetBairroCidadeUF: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'BairroCidadeUF'
      Size = 40
    end
    object MasterClientDatasetMENSAGEMORCAMENTO: TStringField
      FieldName = 'MENSAGEMORCAMENTO'
      ProviderFlags = [pfInUpdate]
      Size = 512
    end
    object MasterClientDatasetMENSAGEMLOCACAO: TStringField
      FieldName = 'MENSAGEMLOCACAO'
      ProviderFlags = [pfInUpdate]
      Size = 512
    end
    object MasterClientDatasetNOMELOCATARIO: TStringField
      FieldName = 'NOMELOCATARIO'
      ProviderFlags = [pfInUpdate]
      Size = 40
    end
  end
end
