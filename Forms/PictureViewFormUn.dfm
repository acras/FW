object PictureViewForm: TPictureViewForm
  Left = 238
  Top = 126
  BorderStyle = bsToolWindow
  Caption = 'Visualiza'#231#227'o de Imagem'
  ClientHeight = 397
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Scroll: TScrollBox
    Left = 0
    Top = 0
    Width = 595
    Height = 397
    Align = alClient
    TabOrder = 0
    object Image: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 300
    end
  end
end
