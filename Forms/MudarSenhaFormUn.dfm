object MudarSenhaForm: TMudarSenhaForm
  Left = 436
  Top = 274
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  BorderWidth = 4
  Caption = 'Mudar Senha'
  ClientHeight = 185
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    303
    185)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 14
    Width = 72
    Height = 13
    Caption = 'Senha &anterior:'
    FocusControl = SenhaAteriorEdit
  end
  object Label2: TLabel
    Left = 8
    Top = 46
    Width = 61
    Height = 13
    Caption = '&Nova senha:'
    FocusControl = NovaSenhaEdit
  end
  object Label3: TLabel
    Left = 8
    Top = 78
    Width = 62
    Height = 13
    Caption = '&Confirma'#231#227'o:'
    FocusControl = ConfirmarButton
  end
  object Bevel: TBevel
    Left = 0
    Top = 148
    Width = 303
    Height = 37
    Align = alBottom
    Shape = bsTopLine
  end
  object SenhaAteriorEdit: TEdit
    Left = 88
    Top = 12
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object NovaSenhaEdit: TEdit
    Left = 88
    Top = 44
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object ConfirmacaoEdit: TEdit
    Left = 88
    Top = 76
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object ConfirmarButton: TButton
    Left = 141
    Top = 156
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Confirmar'
    Default = True
    TabOrder = 3
    OnClick = ConfirmarButtonClick
  end
  object CancelarButton: TButton
    Left = 229
    Top = 156
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = CancelarButtonClick
  end
end
