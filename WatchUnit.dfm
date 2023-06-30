object WatchForm: TWatchForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1084
  ClientHeight = 305
  ClientWidth = 583
  Color = clInfoBk
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Trebuchet MS'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object StaticText1: TStaticText
    Left = 8
    Top = 8
    Width = 172
    Height = 17
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1077
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object DocInfo: TMemo
    Left = 8
    Top = 31
    Width = 337
    Height = 250
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object ChooseAgent: TComboBox
    Left = 374
    Top = 135
    Width = 186
    Height = 24
    Style = csDropDownList
    TabOrder = 2
  end
  object StaticText2: TStaticText
    Left = 366
    Top = 112
    Width = 228
    Height = 17
    Caption = #1054#1079#1085#1072#1082#1086#1084#1080#1090#1100#1089#1103' '#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1084' '#1082#1072#1082':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object GoAgree: TButton
    Left = 411
    Top = 192
    Width = 114
    Height = 40
    Caption = #1054#1079#1085#1072#1082#1086#1084#1083#1077#1085
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = GoAgreeClick
  end
  object GoWord: TButton
    Left = 387
    Top = 31
    Width = 166
    Height = 50
    Caption = #1057#1084#1086#1090#1088#1077#1090#1100' '#1092#1072#1081#1083' '#1074' Word'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Emoji'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = GoWordClick
  end
end
