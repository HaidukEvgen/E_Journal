object FormChooseJournal: TFormChooseJournal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1078#1091#1088#1085#1072#1083#1072
  ClientHeight = 165
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object InfoLabel: TLabel
    Left = 50
    Top = 8
    Width = 154
    Height = 23
    Caption = #1042#1099#1073#1086#1088' '#1078#1091#1088#1085#1072#1083#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ClassLabel: TLabel
    Left = 8
    Top = 37
    Width = 63
    Height = 22
    Caption = #1050#1083#1072#1089#1089':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object QuaterLabel: TLabel
    Left = 8
    Top = 65
    Width = 84
    Height = 22
    Caption = #1063#1077#1090#1074#1077#1088#1090#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object LessonLabel: TLabel
    Left = 8
    Top = 93
    Width = 91
    Height = 22
    Caption = #1055#1088#1077#1076#1084#1077#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object ConfirmButton: TButton
    Left = 8
    Top = 124
    Width = 233
    Height = 34
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1078#1091#1088#1085#1072#1083
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = ConfirmButtonClick
  end
  object ClassComboBox: TComboBox
    Left = 112
    Top = 37
    Width = 121
    Height = 21
    PopupMenu = PopupMenu
    TabOrder = 1
    OnChange = ClassComboBoxChange
  end
  object QuaterComboBox: TComboBox
    Left = 112
    Top = 67
    Width = 121
    Height = 21
    PopupMenu = PopupMenu
    TabOrder = 2
    OnChange = QuaterComboBoxChange
  end
  object LessonComboBox: TComboBox
    Left = 112
    Top = 94
    Width = 121
    Height = 21
    PopupMenu = PopupMenu
    TabOrder = 3
    OnChange = LessonComboBoxChange
  end
  object MainMenu: TMainMenu
    Left = 8
    object InformationMenuItem: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      ShortCut = 112
      OnClick = InformationMenuItemClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 224
    Top = 65529
  end
end
