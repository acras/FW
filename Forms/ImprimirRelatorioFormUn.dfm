inherited ImprimirRelatorioForm: TImprimirRelatorioForm
  Left = 355
  Top = 219
  Caption = 'ImprimirRelatorioForm'
  PixelsPerInch = 96
  TextHeight = 13
  object ComboFilter: TosComboFilter [1]
    Left = 200
    Top = 112
    Width = 121
    Height = 21
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 1
    UnboundDataType = wwDefault
    Visible = False
    ClientDS = FilterDataSet
    Params = <>
    ViewDefault = 0
  end
  inherited MasterDataSource: TDataSource
    DataSet = osClientDataset1
  end
  object osClientDataset1: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    Left = 232
    Top = 104
  end
  object Report: TppReport
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
    Units = utMillimeters
    DeviceType = 'Screen'
    OnPreviewFormCreate = reportPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zsPageWidth
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 200
    Top = 104
    Version = '9.03'
    mmColumnWidth = 0
  end
  object FilterDataSet: TosClientDataset
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    DataProvider = MainData.prvFilter
    Left = 64
    Top = 104
  end
end
