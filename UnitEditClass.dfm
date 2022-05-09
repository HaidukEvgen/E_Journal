object FormEditClass: TFormEditClass
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1083#1072#1089#1089#1072
  ClientHeight = 442
  ClientWidth = 712
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CaptionLabel: TLabel
    Left = 224
    Top = 8
    Width = 261
    Height = 25
    Alignment = taCenter
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1083#1072#1089#1089#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Century Gothic'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object InfoLabel: TLabel
    Left = 239
    Top = 39
    Width = 224
    Height = 22
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1083#1072#1089#1089#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object ClassLabel: TLabel
    Left = 312
    Top = 67
    Width = 63
    Height = 22
    Alignment = taCenter
    Caption = #1050#1083#1072#1089#1089':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object SubjectsLabel: TLabel
    Left = 77
    Top = 95
    Width = 211
    Height = 22
    Caption = #1048#1079#1091#1095#1072#1077#1084#1099#1077' '#1087#1088#1077#1076#1084#1077#1090#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object StudentsLabel: TLabel
    Left = 472
    Top = 95
    Width = 78
    Height = 22
    Caption = #1059#1095#1077#1085#1080#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object SubjectsCheckListBox: TCheckListBox
    Left = 25
    Top = 123
    Width = 298
    Height = 250
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Century Gothic'
    Font.Style = []
    ItemHeight = 20
    Items.Strings = (
      #1041#1077#1083#1086#1088#1091#1089#1089#1082#1080#1081' '#1103#1079#1099#1082
      #1041#1077#1083#1086#1088#1091#1089#1089#1082#1072#1103' '#1083#1080#1090#1077#1088#1072#1090#1091#1088#1072
      #1056#1091#1089#1089#1082#1080#1081' '#1103#1079#1099#1082
      #1056#1091#1089#1089#1082#1072#1103' '#1083#1080#1090#1077#1088#1072#1090#1091#1088#1072
      #1048#1085#1086#1089#1090#1088#1072#1085#1085#1099#1081' '#1103#1079#1099#1082
      #1052#1072#1090#1077#1084#1072#1090#1080#1082#1072
      #1048#1085#1092#1086#1088#1084#1072#1090#1080#1082#1072
      #1063#1077#1083#1086#1074#1077#1082' '#1080' '#1084#1080#1088
      #1042#1089#1077#1084#1080#1088#1085#1072#1103' '#1080#1089#1090#1086#1088#1080#1103
      #1048#1089#1090#1086#1088#1080#1103' '#1041#1077#1083#1072#1088#1091#1089#1080
      #1054#1073#1097#1077#1089#1090#1074#1086#1074#1077#1076#1077#1085#1080#1077
      #1043#1077#1086#1075#1088#1072#1092#1080#1103
      #1041#1080#1086#1083#1086#1075#1080#1103
      #1060#1080#1079#1080#1082#1072
      #1040#1089#1090#1088#1086#1085#1086#1084#1080#1103
      #1061#1080#1084#1080#1103
      #1048#1079#1086#1073#1088#1072#1079#1080#1090#1077#1083#1100#1085#1086#1077' '#1080#1089#1082#1091#1089#1089#1090#1074#1086
      #1052#1091#1079#1099#1082#1072
      #1058#1088#1091#1076#1086#1074#1086#1077' '#1086#1073#1091#1095#1077#1085#1080#1077
      #1063#1077#1088#1095#1077#1085#1080#1077
      #1060#1080#1079#1080#1095#1077#1089#1082#1072#1103' '#1082#1091#1083#1100#1090#1091#1088#1072' '#1080' '#1079#1076#1086#1088#1086#1074#1100#1077
      #1044#1086#1087#1088#1080#1079#1099#1074#1085#1072#1103' '#1080' '#1084#1077#1076' '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1072
      #1054#1041#1046)
    ParentFont = False
    TabOrder = 0
    OnClick = SubjectsCheckListBoxClick
  end
  object SaveButton: TButton
    Left = 239
    Top = 394
    Width = 233
    Height = 40
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = SaveButtonClick
  end
  object StudentsSG: TStringGrid
    Left = 347
    Top = 122
    Width = 335
    Height = 201
    ColCount = 3
    DefaultColWidth = 146
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goFixedRowDefAlign]
    ScrollBars = ssVertical
    TabOrder = 2
    OnKeyPress = StudentsSGKeyPress
    RowHeights = (
      24
      24)
  end
  object AddButton: TButton
    Left = 363
    Top = 329
    Width = 145
    Height = 43
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = AddButtonClick
  end
  object DeleteButton: TButton
    Left = 519
    Top = 329
    Width = 147
    Height = 43
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object MainMenu: TMainMenu
    Left = 640
    Top = 32
    object InformationMenuItem: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      ShortCut = 112
    end
    object DeleteMenuItem: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1072#1089#1089
      OnClick = DeleteMenuItemClick
    end
  end
end
