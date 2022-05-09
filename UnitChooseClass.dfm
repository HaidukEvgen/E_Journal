object FormChooseClass: TFormChooseClass
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1083#1072#1089#1089#1072
  ClientHeight = 120
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object InfoLabel: TLabel
    Left = 32
    Top = 8
    Width = 236
    Height = 23
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1083#1072#1089#1089#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ClassLabel: TLabel
    Left = 8
    Top = 35
    Width = 146
    Height = 22
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1082#1083#1072#1089#1089':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object ConfirmButton: TButton
    Left = 32
    Top = 70
    Width = 233
    Height = 34
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1083#1072#1089#1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = ConfirmButtonClick
  end
  object ComboBox: TComboBox
    Left = 160
    Top = 37
    Width = 110
    Height = 21
    PopupMenu = PopupMenu
    TabOrder = 1
  end
  object MainMenu: TMainMenu
    Top = 72
    object InformationMenuItem: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      ShortCut = 112
      OnClick = InformationMenuItemClick
    end
  end
  object PopupMenu: TPopupMenu
    Top = 65532
  end
end
