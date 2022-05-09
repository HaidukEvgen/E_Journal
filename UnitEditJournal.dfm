object FormEditJournal: TFormEditJournal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1078#1091#1088#1085#1072#1083#1072
  ClientHeight = 473
  ClientWidth = 1017
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CaptionLabel: TLabel
    Left = 368
    Top = 8
    Width = 280
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1078#1091#1088#1085#1072#1083#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
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
  object JournalSG: TStringGrid
    Left = 8
    Top = 121
    Width = 999
    Height = 350
    DefaultColWidth = 65
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs, goFixedRowClick, goFixedColDefAlign, goFixedRowDefAlign]
    ParentFont = False
    TabOrder = 0
    OnDrawCell = JournalSGDrawCell
    OnFixedCellClick = JournalSGFixedCellClick
    OnKeyPress = JournalSGKeyPress
    OnSetEditText = JournalSGSetEditText
  end
  object MainMenu: TMainMenu
    Left = 688
    Top = 56
    object InformationMenuItem: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      ShortCut = 112
      OnClick = InformationMenuItemClick
    end
    object AddLessonMenuItem: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1088#1086#1082
      ShortCut = 113
      OnClick = AddLessonMenuItemClick
    end
    object SaveMenuItem: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ShortCut = 16467
      OnClick = SaveMenuItemClick
    end
  end
end
