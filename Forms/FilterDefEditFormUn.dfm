inherited FilterDefEditForm: TFilterDefEditForm
  Left = 413
  Top = 105
  VertScrollBar.Range = 0
  ActiveControl = DBEdit2
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  BorderWidth = 4
  Caption = 'Defini'#231#227'o de Filtros'
  ClientHeight = 489
  ClientWidth = 489
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 340
    Top = 40
    Width = 21
    Height = 13
    Caption = 'Tipo'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 40
    Width = 28
    Height = 13
    Caption = 'Nome'
    FocusControl = DBEdit2
  end
  object Label3: TLabel [2]
    Left = 8
    Top = 64
    Width = 27
    Height = 13
    Caption = 'Filtros'
  end
  object Label4: TLabel [3]
    Left = 8
    Top = 472
    Width = 27
    Height = 13
    Caption = 'Teste'
  end
  inherited MainControlBar: TControlBar
    Width = 489
    TabOrder = 4
  end
  object DBEdit2: TDBEdit [5]
    Left = 48
    Top = 36
    Width = 289
    Height = 21
    DataField = 'Name'
    DataSource = MasterDataSource
    TabOrder = 0
  end
  object DBGrid1: TDBGrid [6]
    Left = 8
    Top = 80
    Width = 475
    Height = 173
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsEditDetail
    PopupMenu = PopupMenu
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Number'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Width = 349
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AccessLevel'
        Visible = True
      end>
  end
  object cbTipo: TwwDBComboBox [7]
    Left = 368
    Top = 36
    Width = 121
    Height = 21
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    AutoDropDown = True
    ShowMatchText = True
    DataField = 'FILTERTYPE'
    DataSource = MasterDataSource
    DropDownCount = 8
    HistoryList.FileName = 'LabMaster.ini.ini'
    ItemHeight = 0
    Items.Strings = (
      'Edi'#231#227'o'#9'EDT'
      'Relat'#243'rio'#9'REP'
      'Lookup'#9'LOK')
    Sorted = False
    TabOrder = 1
    UnboundDataType = wwDefault
  end
  object PageControl1: TPageControl [8]
    Left = 8
    Top = 262
    Width = 475
    Height = 195
    ActivePage = TabSheet4
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Query'
      object edQuery: TDBMemo
        Left = 0
        Top = 0
        Width = 467
        Height = 167
        Align = alClient
        DataField = 'QueryText'
        DataSource = dsEditDetail
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Atributos'
      ImageIndex = 1
      object edAtributos: TDBMemo
        Left = 0
        Top = 0
        Width = 467
        Height = 167
        Hint = 'Nome=TituloColuna[;Tam]'
        Align = alClient
        DataField = 'AttributeList'
        DataSource = dsEditDetail
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Express'#245'es Default'
      ImageIndex = 2
      object edExpression: TDBMemo
        Left = 0
        Top = 0
        Width = 467
        Height = 167
        Hint = 'Express'#245'es que ser'#227'o adicionadas ao SQL (and)'
        Align = alClient
        DataField = 'ExpressionList'
        DataSource = dsEditDetail
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Restri'#231#245'es usu'#225'rio'
      ImageIndex = 3
      object edRestricoes: TDBMemo
        Left = 0
        Top = 0
        Width = 467
        Height = 167
        Hint = 
          'Nome;Expressao'#13#10'Nome;Express'#227'o;Date'#13#10'Nome;Express'#227'o;List;cod1,de' +
          'scr1,cod2,descr2,...'#13#10'Nome;Express'#227'o;Dategroup;expr1 | expr2'#13#10'No' +
          'me;;Group Nome;Expressao[;...] | Nome;Expressao[;...] | ...'
        Align = alClient
        DataField = 'ConstraintList'
        DataSource = dsEditDetail
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Ordena'#231#227'o'
      ImageIndex = 4
      object edOrdenacao: TDBMemo
        Left = 0
        Top = 0
        Width = 467
        Height = 167
        Hint = 'Nome=Express'#227'o'
        Align = alClient
        DataField = 'OrderList'
        DataSource = dsEditDetail
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
  end
  object csTeste: TosComboSearch [9]
    Left = 44
    Top = 468
    Width = 157
    Height = 21
    ShowButton = True
    Style = csDropDown
    DataField = 'Teste'
    DataSource = dsTeste
    TabOrder = 5
    WordWrap = False
    UnboundDataType = wwDefault
    OnEnter = csTesteEnter
    FilterDataProvider = MainData.prvFilter
    AllowClearKey = False
  end
  object ImportarButton: TButton [10]
    Left = 407
    Top = 4
    Width = 75
    Height = 22
    Caption = 'Importar'
    TabOrder = 6
    OnClick = ImportarButtonClick
  end
  object FiltroComboSearch: TosComboSearch [11]
    Left = 324
    Top = 4
    Width = 121
    Height = 21
    ShowButton = True
    Style = csDropDown
    TabOrder = 7
    WordWrap = False
    UnboundDataType = wwDefault
    Visible = False
    FilterDataProvider = MainData.prvFilter
    FilterDefName = 'FilterDef'
    AllowClearKey = False
    OnReturnSearch = FiltroComboSearchReturnSearch
  end
  object ImportarQueryButton: TButton [12]
    Left = 372
    Top = 464
    Width = 107
    Height = 25
    Caption = 'Importar Query'
    TabOrder = 8
    OnClick = ImportarQueryButtonClick
  end
  object RBComboSearch: TosComboSearch [13]
    Left = 300
    Top = 468
    Width = 121
    Height = 21
    ShowButton = True
    Style = csDropDown
    TabOrder = 9
    WordWrap = False
    UnboundDataType = wwDefault
    Visible = False
    FilterDataProvider = MainData.prvFilter
    FilterDefName = 'Relatorio_RB'
    AllowClearKey = False
    OnReturnSearch = RBComboSearchReturnSearch
  end
  inherited ActionList: TosActionList
    Left = 308
    Top = 4
    object TestarAction: TAction
      Caption = 'TestarAction'
      OnExecute = TestarActionExecute
    end
    object ApagarFiltroAction: TAction
      Category = 'Edit'
      Caption = 'Apagar Filtro'
      ShortCut = 16452
      OnExecute = ApagarFiltroActionExecute
    end
  end
  inherited MasterDataSource: TDataSource
    DataSet = cdsEdit
    Left = 28
    Top = 428
  end
  inherited ImageList: TImageList
    Left = 276
  end
  inherited MainMenu: TMainMenu
    Left = 240
    Top = 4
  end
  object cdsEdit: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = '-1'
      end>
    OnNewRecord = cdsEditNewRecord
    DataProvider = FilterDefData.MasterProvider
    BizDatamoduleName = 'BizFilterDef'
    Left = 60
    Top = 428
    object cdsEditIDXFILTERDEF: TIntegerField
      FieldName = 'IDXFILTERDEF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsEditName: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'Name'
      Origin = 'DB.XPFilterDef.Name'
      FixedChar = True
      Size = 50
    end
    object cdsEditFilterDefDetailDataset: TDataSetField
      FieldName = 'FilterDefDetailDataset'
    end
    object cdsEditFILTERTYPE: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'FILTERTYPE'
      FixedChar = True
      Size = 3
    end
  end
  object cdsEditDetail: TosClientDataset
    Aggregates = <>
    DataSetField = cdsEditFilterDefDetailDataset
    FetchOnDemand = False
    Params = <>
    Left = 148
    Top = 432
    object cdsEditDetailIDXFILTERDEFDETAIL: TIntegerField
      FieldName = 'IDXFILTERDEFDETAIL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsEditDetailIDXFILTERDEF: TIntegerField
      FieldName = 'IDXFILTERDEF'
    end
    object cdsEditDetailNumber: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'Number'
    end
    object cdsEditDetailDescription: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Description'
      FixedChar = True
      Size = 200
    end
    object cdsEditDetailQueryText: TMemoField
      DisplayLabel = 'Query'
      FieldName = 'QueryText'
      BlobType = ftMemo
      Size = 1
    end
    object cdsEditDetailAttributeList: TMemoField
      DisplayLabel = 'Attributos'
      FieldName = 'AttributeList'
      BlobType = ftMemo
      Size = 1
    end
    object cdsEditDetailExpressionList: TMemoField
      DisplayLabel = 'Express'#245'es Default'
      FieldName = 'ExpressionList'
      BlobType = ftMemo
      Size = 1
    end
    object cdsEditDetailConstraintList: TMemoField
      DisplayLabel = 'Restri'#231#245'es do Usu'#225'rio'
      FieldName = 'ConstraintList'
      BlobType = ftMemo
      Size = 1
    end
    object cdsEditDetailOrderList: TMemoField
      DisplayLabel = 'Ordena'#231#227'o'
      FieldName = 'OrderList'
      BlobType = ftMemo
      Size = 1
    end
    object cdsEditDetailAccessLevel: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'N'#237'vel'
      FieldName = 'AccessLevel'
    end
  end
  object dsEditDetail: TDataSource
    DataSet = cdsEditDetail
    Left = 108
    Top = 420
  end
  object PopupMenu: TPopupMenu
    Left = 352
    Top = 8
    object Delete1: TMenuItem
      Action = ApagarFiltroAction
    end
  end
  object cdsTeste: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    Left = 304
    Top = 432
    object cdsTesteTeste: TStringField
      FieldName = 'Teste'
      Size = 100
    end
    object cdsTesteResult: TStringField
      DisplayLabel = 'Resultado'
      FieldName = 'Result'
      Size = 100
    end
  end
  object dsTeste: TDataSource
    DataSet = cdsTeste
    Left = 336
    Top = 432
  end
  object report: TppReport
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    DeviceType = 'Screen'
    EmailSettings.ReportFormat = 'PDF'
    OnPreviewFormCreate = ReportPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 260
    Top = 464
    Version = '10.07'
    mmColumnWidth = 0
  end
end
