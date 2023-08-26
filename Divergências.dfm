object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Diverg'#234'ncias'
  ClientHeight = 483
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 423
    Width = 492
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitWidth = 436
    object Button1: TButton
      Left = 1
      Top = 1
      Width = 490
      Height = 39
      Align = alClient
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = Button1Click
      ExplicitWidth = 434
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 464
    Width = 492
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitWidth = 436
  end
  object GridRetorno: TDBGrid
    Left = 0
    Top = 0
    Width = 492
    Height = 423
    Align = alClient
    DataSource = DSRetorno
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DSRetorno: TDataSource
    DataSet = CDS_Retorno
    Left = 176
    Top = 184
  end
  object CDS_Retorno: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 184
    object CDS_RetornoEMISSAO: TDateField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'EMISSAO'
    end
    object CDS_RetornoINDICE: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'INDICE'
    end
    object CDS_RetornoSTATUSPREFEITURA: TStringField
      DisplayLabel = 'Status Prefeitura'
      FieldName = 'STATUSPREFEITURA'
    end
    object CDS_RetornoSTATUSDESBRAVADOR: TStringField
      DisplayLabel = 'Status Desbravador'
      FieldName = 'STATUSDESBRAVADOR'
    end
    object CDS_RetornoVALOR: TCurrencyField
      FieldName = 'VALOR'
    end
  end
end
