inherited EstruturaContabilEditForm: TEstruturaContabilEditForm
  Left = 433
  Top = 165
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  BorderWidth = 4
  Caption = 'Cadastro dos Parametros do Sistema'
  ClientHeight = 346
  ClientWidth = 470
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainControlBar: TControlBar
    Width = 470
  end
  inherited ActionList: TosActionList
    Left = 368
    object TestarAction: TAction
      Caption = 'TestarAction'
    end
  end
  inherited MasterDataSource: TDataSource
    DataSet = MasterClientDataSet
    Left = 428
  end
  inherited ImageList: TImageList
    Left = 340
  end
  inherited MainMenu: TMainMenu
    Left = 308
  end
  object MasterClientDataSet: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    DataProvider = ParametroSistemaData.MasterProvider
    BizDatamoduleName = 'BizFilterDef'
    Left = 408
    object MasterClientDataSetIDEMPRESA: TIntegerField
      DisplayLabel = 'Empresa'
      FieldName = 'IDEMPRESA'
    end
    object MasterClientDataSetLOGO: TBlobField
      DisplayLabel = 'Logotipo'
      FieldName = 'LOGO'
      ProviderFlags = [pfInUpdate]
      BlobType = ftGraphic
      Size = 1
    end
    object MasterClientDataSetNOMEFANTASIA: TStringField
      DisplayLabel = 'Nome Fantasia'
      FieldName = 'NOMEFANTASIA'
      ProviderFlags = []
      Size = 40
    end
    object MasterClientDataSetENDERECO: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'ENDERECO'
      ProviderFlags = []
      Size = 40
    end
    object MasterClientDataSetBAIRRO: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      ProviderFlags = []
      Size = 40
    end
    object MasterClientDataSetCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      ProviderFlags = []
      Size = 40
    end
    object MasterClientDataSetUF: TStringField
      FieldName = 'UF'
      ProviderFlags = []
      FixedChar = True
      Size = 2
    end
    object MasterClientDataSetTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
      ProviderFlags = []
    end
    object MasterClientDataSetNomeEmpresa: TStringField
      FieldKind = fkLookup
      FieldName = 'NomeEmpresa'
      LookupKeyFields = 'IDEMPRESA'
      LookupResultField = 'NOMEFANTASIA'
      KeyFields = 'IDEMPRESA'
      Size = 40
      Lookup = True
    end
    object MasterClientDataSetMENSAGEMORCAMENTO: TStringField
      FieldName = 'MENSAGEMORCAMENTO'
      ProviderFlags = [pfInUpdate]
      Size = 512
    end
    object MasterClientDataSetMENSAGEMLOCACAO: TStringField
      FieldName = 'MENSAGEMLOCACAO'
      ProviderFlags = [pfInUpdate]
      Size = 512
    end
    object MasterClientDataSetNOMELOCATARIO: TStringField
      FieldName = 'NOMELOCATARIO'
      ProviderFlags = [pfInUpdate]
      Size = 40
    end
  end
  object OpenDialog: TOpenPictureDialog
    OptionsEx = [ofExNoPlacesBar]
    Left = 432
  end
end
