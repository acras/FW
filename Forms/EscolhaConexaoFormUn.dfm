object EscolhaConexaoForm: TEscolhaConexaoForm
  Left = 349
  Top = 241
  Width = 359
  Height = 228
  Caption = 'Escolha a conex'#227'o com o Banco de Dados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox: TListBox
    Left = 0
    Top = 0
    Width = 351
    Height = 164
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = ListBoxDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 164
    Width = 351
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOK: TButton
      Left = 272
      Top = 4
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 194
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
