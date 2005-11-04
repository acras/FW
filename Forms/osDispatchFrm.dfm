inherited osDispatchForm: TosDispatchForm
  Left = 471
  Top = 321
  Width = 427
  Height = 315
  Caption = 'osDispatchForm'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object MainControlBar: TControlBar [0]
    Left = 0
    Top = 0
    Width = 419
    Height = 30
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object ControlBarPanel: TPanel
      Left = 11
      Top = 2
      Width = 86
      Height = 22
      BevelOuter = bvNone
      TabOrder = 0
      object ConfirmButton: TSpeedButton
        Left = 0
        Top = 0
        Width = 85
        Height = 22
        Action = ConfirmAction
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
      end
      object tbrFilter: TToolBar
        Left = 325
        Top = 0
        Width = 23
        Height = 22
        Align = alNone
        AutoSize = True
        Caption = 'tbrFilter'
        EdgeBorders = []
        Flat = True
        Images = ImageList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object btnFilter: TToolButton
          Left = 0
          Top = 0
          Hint = 'Executa o filtro selecionado'
        end
      end
    end
  end
  inherited ActionList: TosActionList
    Left = 4
    Top = 28
    object OnExecute: TAction
      Caption = 'OnExecute'
    end
    object ConfirmAction: TAction
      Caption = 'Confirmar'
      OnExecute = ConfirmActionExecute
    end
    object OnConfirm: TAction
      Caption = 'OnConfirm'
    end
  end
  inherited ImageList: TImageList
    Top = 28
  end
end
