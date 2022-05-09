object FormAddLesson: TFormAddLesson
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1091#1088#1086#1082#1072
  ClientHeight = 247
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CaptionLabel: TLabel
    Left = 119
    Top = 8
    Width = 182
    Height = 22
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1091#1088#1086#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object NumberLabel: TLabel
    Left = 39
    Top = 36
    Width = 138
    Height = 22
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object HometaskLabel: TLabel
    Left = 39
    Top = 91
    Width = 200
    Height = 22
    Caption = #1044#1086#1084#1072#1096#1085#1077#1077' '#1079#1072#1076#1072#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object DateLabel: TLabel
    Left = 39
    Top = 146
    Width = 52
    Height = 22
    Caption = #1044#1072#1090#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object InformationEdit: TEdit
    Left = 39
    Top = 64
    Width = 306
    Height = 21
    MaxLength = 20
    TabOrder = 0
  end
  object HomeTaskEdit: TEdit
    Left = 39
    Top = 119
    Width = 306
    Height = 21
    MaxLength = 20
    TabOrder = 1
  end
  object DateTimePicker: TDateTimePicker
    Left = 39
    Top = 174
    Width = 306
    Height = 21
    Date = 44670.000000000000000000
    Time = 0.854818865744164200
    TabOrder = 2
  end
  object AddButton: TButton
    Left = 39
    Top = 208
    Width = 306
    Height = 31
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1088#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = AddButtonClick
  end
  object MainMenu: TMainMenu
    Left = 16
    Top = 8
    object InformationMenuItem: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      ShortCut = 112
      OnClick = InformationMenuItemClick
    end
  end
end
