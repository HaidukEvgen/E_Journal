object FormViewJournal: TFormViewJournal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1078#1091#1088#1085#1072#1083#1072
  ClientHeight = 400
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 112
    Top = 8
    Width = 209
    Height = 25
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1078#1091#1088#1085#1072#1083#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Century Gothic'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RecordSG: TStringGrid
    Left = 8
    Top = 39
    Width = 422
    Height = 300
    ColCount = 4
    DefaultColWidth = 100
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs, goRowSelect, goFixedRowDefAlign]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object MainMenu: TMainMenu
    Left = 376
    Top = 344
    object InformationMenuItem: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      ShortCut = 112
    end
  end
end
