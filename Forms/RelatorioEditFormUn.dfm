inherited RelatorioEditForm: TRelatorioEditForm
  Left = 437
  Top = 191
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  BorderWidth = 4
  Caption = 'Cadastro de Relat'#243'rios'
  ClientHeight = 246
  ClientWidth = 422
  ExplicitWidth = 436
  ExplicitHeight = 302
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainControlBar: TControlBar
    Width = 422
    ExplicitWidth = 422
    inherited ControlBarPanel: TPanel
      Width = 385
      ExplicitWidth = 385
      inherited ImprimirButton: TSpeedButton
        Left = 195
        ExplicitLeft = 195
      end
      inherited ExcluirButton: TSpeedButton
        Left = 261
        ExplicitLeft = 261
      end
      inherited FecharButton: TSpeedButton
        Left = 326
        ExplicitLeft = 326
      end
    end
  end
  object PageControl: TPageControl [1]
    Left = 0
    Top = 30
    Width = 422
    Height = 216
    ActivePage = PrincipalTabSheet
    Align = alClient
    TabOrder = 1
    object PrincipalTabSheet: TTabSheet
      Caption = 'Principal'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label3: TLabel
        Left = 8
        Top = 20
        Width = 24
        Height = 13
        Caption = '&Tipo:'
        FocusControl = TipoRelatorioCombo
      end
      object Label1: TLabel
        Left = 8
        Top = 70
        Width = 31
        Height = 13
        Caption = '&Nome:'
        FocusControl = TituloEdit
      end
      object Label4: TLabel
        Left = 8
        Top = 104
        Width = 51
        Height = 13
        Caption = '&Descri'#231#227'o:'
        FocusControl = DescricaoMemo
      end
      object Label7: TLabel
        Left = 8
        Top = 44
        Width = 34
        Height = 13
        Caption = 'Classe:'
      end
      object TipoRelatorioCombo: TDBLookupComboBox
        Left = 80
        Top = 18
        Width = 330
        Height = 21
        DataField = 'IDTIPORELATORIO'
        DataSource = MasterDataSource
        KeyField = 'IDTIPORELATORIO'
        ListField = 'NOME'
        ListSource = TipoRelatorioLookupDataSource
        TabOrder = 0
      end
      object TituloEdit: TDBEdit
        Left = 80
        Top = 68
        Width = 330
        Height = 21
        DataField = 'TITULO'
        DataSource = MasterDataSource
        TabOrder = 1
      end
      object DescricaoMemo: TDBMemo
        Left = 80
        Top = 96
        Width = 330
        Height = 87
        DataField = 'DESCRICAO'
        DataSource = MasterDataSource
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object ClasseCombo: TwwDBComboBox
        Left = 80
        Top = 42
        Width = 329
        Height = 21
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'CLASSERELATORIO'
        DataSource = MasterDataSource
        DropDownCount = 8
        HistoryList.FileName = 'LabMaster.ini.ini'
        ItemHeight = 0
        Items.Strings = (
          'Presta'#231#227'o de Contas'#9'TPrestacaoContas')
        Sorted = False
        TabOrder = 3
        UnboundDataType = wwDefault
      end
    end
    object ConfiguracoesTabSheet: TTabSheet
      Caption = 'Configura'#231#245'es'
      ImageIndex = 1
      object Label5: TLabel
        Left = 8
        Top = 49
        Width = 25
        Height = 13
        Caption = '&Filtro:'
      end
      object Label2: TLabel
        Left = 8
        Top = 22
        Width = 47
        Height = 13
        Caption = '&Template:'
      end
      object NomeRelatorioCombo: TosComboSearch
        Left = 80
        Top = 18
        Width = 330
        Height = 21
        ShowButton = True
        Style = csDropDown
        DataField = 'Template'
        DataSource = MasterDataSource
        TabOrder = 0
        WordWrap = False
        UnboundDataType = wwDefault
        FilterDataProvider = MainData.prvFilter
        FilterDefName = 'Relatorio_RB'
        ReturnField = 'ITEM_ID'
        AllowClearKey = False
      end
      object osComboSearch1: TosComboSearch
        Left = 80
        Top = 44
        Width = 329
        Height = 21
        ShowButton = True
        Style = csDropDown
        DataField = 'NomeFiltro'
        DataSource = MasterDataSource
        TabOrder = 1
        WordWrap = False
        UnboundDataType = wwDefault
        FilterDataProvider = MainData.prvFilter
        FilterDefName = 'FilterDef'
        ReturnField = 'IDXFilterDef'
        ReturnLookupField = 'ID'
        AllowClearKey = False
      end
      object ComboFilter: TosComboFilter
        Left = 80
        Top = 72
        Width = 121
        Height = 21
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        DropDownCount = 8
        HistoryList.FileName = 'LabMaster.ini.ini'
        ItemHeight = 0
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
        Visible = False
        ClientDS = FilterDataset
        Params = <>
        ViewDefault = 0
      end
    end
    object VersaoTabSheet: TTabSheet
      Caption = 'Controle de Vers'#227'o'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 5
        Top = 4
        Width = 405
        Height = 81
        Caption = ' Compatibilidade '
        TabOrder = 0
        object Label6: TLabel
          Left = 12
          Top = 24
          Width = 54
          Height = 13
          Caption = '&Impressora:'
        end
        object Label8: TLabel
          Left = 12
          Top = 50
          Width = 52
          Height = 13
          Caption = 'Da &vers'#227'o:'
          FocusControl = CompativelAPartirDaVersaoEdit
        end
        object Label9: TLabel
          Left = 232
          Top = 52
          Width = 62
          Height = 13
          Caption = 'at'#233' a vers'#227'o:'
          FocusControl = CompativelAteVersaoEdit
        end
        object ImpressoraCombo: TwwDBComboBox
          Left = 72
          Top = 20
          Width = 321
          Height = 21
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          ShowMatchText = True
          DataField = 'CLASSEIMPRESSORA'
          DataSource = MasterDataSource
          DropDownCount = 8
          HistoryList.FileName = 'LabMaster.ini.ini'
          ItemHeight = 0
          Items.Strings = (
            'Laser'
            'Jato de Tinta'
            'Matricial'
            'Termica'
            'Cupom')
          Sorted = False
          TabOrder = 0
          UnboundDataType = wwDefault
        end
        object CompativelAPartirDaVersaoEdit: TDBEdit
          Left = 72
          Top = 48
          Width = 102
          Height = 21
          Color = clBtnHighlight
          DataField = 'COMPATIVELAPARTIRDAVERSAO'
          DataSource = MasterDataSource
          TabOrder = 1
        end
        object CompativelAteVersaoEdit: TDBEdit
          Left = 300
          Top = 48
          Width = 93
          Height = 21
          Color = clBtnHighlight
          DataField = 'COMPATIVELATEVERSAO'
          DataSource = MasterDataSource
          TabOrder = 2
        end
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 92
        Width = 406
        Height = 89
        Caption = ' Importa'#231#227'o '
        TabOrder = 1
        object Label11: TLabel
          Left = 12
          Top = 24
          Width = 26
          Height = 13
          Caption = '&Data:'
        end
        object Label12: TLabel
          Left = 252
          Top = 24
          Width = 39
          Height = 13
          Caption = '&Usu'#225'rio:'
          FocusControl = UsuarioAlteracaoEdit
        end
        object Label13: TLabel
          Left = 12
          Top = 52
          Width = 39
          Height = 13
          Caption = '&Arquivo:'
          FocusControl = ArquivoOrigemEdit
        end
        object DataAlteracaoTimePicker: TwwDBDateTimePicker
          Left = 72
          Top = 20
          Width = 102
          Height = 21
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          Color = clBtnFace
          DataField = 'DATAIMPORTACAO'
          DataSource = MasterDataSource
          Epoch = 1950
          ReadOnly = True
          ShowButton = True
          TabOrder = 0
        end
        object UsuarioAlteracaoEdit: TDBEdit
          Left = 300
          Top = 20
          Width = 93
          Height = 21
          Color = clBtnFace
          DataField = 'NomeUsuario'
          DataSource = MasterDataSource
          ReadOnly = True
          TabOrder = 1
        end
        object ArquivoOrigemEdit: TDBEdit
          Left = 72
          Top = 48
          Width = 321
          Height = 21
          Color = clBtnFace
          DataField = 'ARQUIVOORIGEM'
          DataSource = MasterDataSource
          ReadOnly = True
          TabOrder = 2
        end
      end
    end
  end
  inherited ActionList: TosActionList
    Left = 316
    Top = 76
    inherited ImprimirAction: TAction
      OnExecute = ImprimirActionExecute
    end
  end
  inherited MasterDataSource: TDataSource
    DataSet = RelatorioClientDataSet
    Left = 264
    Top = 36
  end
  inherited ImageList: TImageList
    Left = 224
    Bitmap = {
      494C010101000400180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6BD00BDB5AD009C9C94008C84
      84008C8484008C8484008C8484008C8484008C8484008C8484008C8484008C84
      84008C84840094948C00B5ADA500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063312900633129006331
      2900633129006331290063312900633129006331290063312900633129006331
      2900633129007B73730094948C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00AD847300DEB5A500DEB5
      A500D6ADA500D6AD9C00CEA59C00CE9C9400CE9C8C00C6948C00C6948400C694
      84008C524200633129008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00B58C7B00FFF7F700FFF7
      F700F7EFEF00F7EFE700EFDED600DEC6B500DEBDAD00D6B5A500D6B5A500DEB5
      A5008C524200633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00B58C7B00FFF7F700DEDE
      D600DED6CE00DECEC600DECEBD00D6BDAD00CEB5A500CEAD9C00C6A59400DEBD
      AD008C524200633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00BD948400FFF7F700FFF7
      F700F7F7EF00F7EFEF00F7EFE700EFE7DE00E7D6CE00DEBDAD00D6BDAD00DEBD
      B5008C524200633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00BD9C8400FFF7F700FFF7
      F700FFF7F700F7F7EF00F7EFEF00F7EFE700EFE7DE00DEC6BD00DEC6B500E7CE
      BD008C5A4200633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00C69C8C00FFFFF700FFFF
      F700FFF7F700FFF7F700F7F7EF00F7EFE700F7EFE700EFD6CE00EFD6C600E7D6
      C600945A4200633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00C6A59400C6A59400C69C
      8C00BD948400BD948400BD947B00B58C7B00B5847300AD7B6B009C634A00945A
      4A00945A4A00633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00CEAD9C00C6A59400C6A5
      9400BD9C8C00BD9C8400BD948400B58C7B00B58C7B00AD8473009C6352009C63
      4A00945A4A00633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C635A00CEAD9C00CEAD9C00C6A5
      9400C6A58C00BD9C8C00BD9C8400BD947B00B58C7B00B5847300AD7B6B009C63
      5200945A4A00633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C6B5A00D6B5A500FFFFFF009C63
      4A00D6BDAD00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFEFEF00F7EFE700F7E7
      DE009C635200633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000946B5A00D6BDAD00FFFFFF009C63
      4A00D6BDAD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7EF00FFEF
      EF00A56B5A00633121008C848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000946B5A00D6BDB500FFFFFF009C63
      4A009C634A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      F700B58473006331290094948C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000946B5A00946B5A008C6B
      5A008C635A008C635A008C635A008C6352008C6352008C6352008C6352008C5A
      5200845A5200BDBDB500CEC6BD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF0000000000000001000000000000
      8001000000000000000100000000000000010000000000000001000000000000
      0001000000000000000100000000000000010000000000000001000000000000
      0001000000000000000100000000000000010000000000000001000000000000
      0001000000000000800100000000000000000000000000000000000000000000
      000000000000}
  end
  inherited MainMenu: TMainMenu
    Left = 268
    Top = 68
  end
  object RelatorioClientDataSet: TosClientDataset
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IDRELATORIO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TITULO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRICAO'
        DataType = ftMemo
        Size = 1
      end
      item
        Name = 'COMPATIVELAPARTIRDAVERSAO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'COMPATIVELATEVERSAO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DATAIMPORTACAO'
        DataType = ftTimeStamp
      end
      item
        Name = 'ARQUIVOORIGEM'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'IDUSUARIOIMPORTACAO'
        DataType = ftInteger
      end
      item
        Name = 'ITEM_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'IDXFILTERDEF'
        DataType = ftInteger
      end
      item
        Name = 'CLASSEIMPRESSORA'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'IDTIPORELATORIO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CLASSERELATORIO'
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <>
    FetchOnDemand = False
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = '-1'
      end>
    StoreDefs = True
    BeforePost = RelatorioClientDataSetBeforePost
    OnNewRecord = RelatorioClientDataSetNewRecord
    BizDatamoduleName = 'BizFilterDef'
    Left = 292
    Top = 36
    object RelatorioClientDataSetTemplate: TStringField
      DisplayLabel = 'Template do Relat'#243'rio'
      FieldKind = fkLookup
      FieldName = 'Template'
      LookupDataSet = RelatorioLookupData.TemplateClientDataset
      LookupKeyFields = 'ITEM_ID'
      LookupResultField = 'NOME'
      KeyFields = 'ITEM_ID'
      Size = 50
      Lookup = True
    end
    object RelatorioClientDataSetNomeUsuario: TStringField
      DisplayLabel = 'Nome do Usu'#225'rio'
      FieldKind = fkInternalCalc
      FieldName = 'NomeUsuario'
      Size = 50
    end
    object RelatorioClientDataSetIDRELATORIO: TIntegerField
      FieldName = 'IDRELATORIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object RelatorioClientDataSetTITULO: TStringField
      FieldName = 'TITULO'
      Size = 50
    end
    object RelatorioClientDataSetDESCRICAO: TMemoField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      BlobType = ftMemo
      Size = 1
    end
    object RelatorioClientDataSetCLASSEIMPRESSORA: TStringField
      FieldName = 'CLASSEIMPRESSORA'
      FixedChar = True
      Size = 30
    end
    object RelatorioClientDataSetCOMPATIVELAPARTIRDAVERSAO: TStringField
      DisplayLabel = 'Vers'#227'o Inicial'
      FieldName = 'COMPATIVELAPARTIRDAVERSAO'
      FixedChar = True
      Size = 10
    end
    object RelatorioClientDataSetCOMPATIVELATEVERSAO: TStringField
      DisplayLabel = 'Vers'#227'o Final'
      FieldName = 'COMPATIVELATEVERSAO'
      FixedChar = True
      Size = 10
    end
    object RelatorioClientDataSetDATAIMPORTACAO: TSQLTimeStampField
      FieldName = 'DATAIMPORTACAO'
    end
    object RelatorioClientDataSetARQUIVOORIGEM: TStringField
      FieldName = 'ARQUIVOORIGEM'
      Size = 40
    end
    object RelatorioClientDataSetIDUSUARIOIMPORTACAO: TIntegerField
      FieldName = 'IDUSUARIOIMPORTACAO'
    end
    object RelatorioClientDataSetITEM_ID: TIntegerField
      FieldName = 'ITEM_ID'
      Required = True
    end
    object RelatorioClientDataSetIDXFILTERDEF: TIntegerField
      FieldName = 'IDXFILTERDEF'
    end
    object RelatorioClientDataSetNomeFiltro: TStringField
      FieldKind = fkLookup
      FieldName = 'NomeFiltro'
      LookupDataSet = RelatorioLookupData.FilterDefClientDataSet
      LookupKeyFields = 'IDXFILTERDEF'
      LookupResultField = 'NAME'
      KeyFields = 'IDXFILTERDEF'
      Size = 50
      Lookup = True
    end
    object RelatorioClientDataSetIDTIPORELATORIO: TIntegerField
      FieldName = 'IDTIPORELATORIO'
      Required = True
    end
    object RelatorioClientDataSetCLASSERELATORIO: TStringField
      FieldName = 'CLASSERELATORIO'
      Size = 30
    end
    object RelatorioClientDataSetNomeTipoRelatorio: TStringField
      FieldKind = fkLookup
      FieldName = 'NomeTipoRelatorio'
      LookupDataSet = RelatorioLookupData.TipoRelatorioClientDataSet
      LookupKeyFields = 'IDTIPORELATORIO'
      LookupResultField = 'NOME'
      KeyFields = 'IDTIPORELATORIO'
      Size = 40
      Lookup = True
    end
  end
  object TipoRelatorioLookupDataSource: TDataSource
    DataSet = RelatorioLookupData.TipoRelatorioClientDataSet
    Left = 320
    Top = 36
  end
  object Report: TppReport
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    OnPreviewFormCreate = ReportPreviewFormCreate
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<Texto a localizar>'
    TextSearchSettings.Enabled = False
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 356
    Top = 68
    Version = '15.01'
    mmColumnWidth = 0
    object ppParameterList1: TppParameterList
    end
  end
  object FilterDataset: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    ReadOnly = True
    DataProvider = MainData.prvFilter
    Left = 88
    Top = 152
  end
  object FilterDatasource: TDataSource
    DataSet = FilterDataset
    Left = 116
    Top = 152
  end
end
