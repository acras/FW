object osErrorHandlerForm: TosErrorHandlerForm
  Left = 511
  Top = 244
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Erros/Avisos'
  ClientHeight = 325
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    225
    325)
  PixelsPerInch = 96
  TextHeight = 13
  object lbErros: TListBox
    Left = 8
    Top = 8
    Width = 209
    Height = 283
    Style = lbOwnerDrawVariable
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 15
    TabOrder = 0
    OnDrawItem = lbErrosDrawItem
    OnMeasureItem = lbErrosMeasureItem
  end
  object btnFechar: TButton
    Left = 144
    Top = 297
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Fechar'
    Default = True
    ModalResult = 6
    TabOrder = 1
  end
  object btnContinua: TButton
    Left = 64
    Top = 297
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Continua'
    Default = True
    ModalResult = 7
    TabOrder = 2
  end
  object btnCancela: TButton
    Left = 144
    Top = 297
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancela'
    ModalResult = 6
    TabOrder = 3
  end
end
