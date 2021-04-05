object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmMain'
  ClientHeight = 533
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object header: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Color = clHotLight
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ParentBackground = False
    TabOrder = 0
    object btExit: TPngSpeedButton
      Left = 265
      Top = 5
      Width = 50
      Height = 40
      Align = alRight
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Days One'
      Font.Style = []
      ParentFont = False
      OnClick = btExitClick
      PngImage.Data = {
        89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
        87000000017352474200AECE1CE900000006624B4744000000000000F943BB7F
        000000097048597300000048000000480046C96B3E000001834944415478DAED
        D9BF4A03411006F0DDCEC63F79006B2D03366A696319C1C207496104913D04D1
        C2174911D325A0BDEF606D2B62F200E777DC5A78DE5E9CECDECD0EECC030E492
        E5BE5F7207CB452BE1A5B9032400778004E00ED02A20CFF37D8C7BF4097AB3E3
        6C4BF40B7AA4B57E23036CF857F44EC7C1ABF5893E74219A00538C0173F89F9A
        00704E052C54F7978DAB16006C5301F9AF0FA2BA4CFCDFF3274002C40AC07283
        B181652371002CCD306EECCB8775106C002CBBC6B8AD1CCEB0DC48011C603CA3
        7B95B748BF8437C0A7422058012110EC005F4414001F44F09BB8A57222A4009C
        084900836C9954406DF8208050D570133BC347034086238C397A8B123E0A804F
        787600CE7D8C315B377C1080C766CE3B3C37E00AE3AE7258CE76DAAEBD54E513
        BDA248DF7C1400BBDED875861A3E0A806F254002440088E9E1EE17F2D73EE66F
        023C619C7127B73506E0820AD853E51F1C3DC55B1FE83E00EF248045EC623CA2
        4FD5DFAD41DB555CC2C56670E80ABF1220A11280BB1280BBC403BE0137C04040
        A63907A50000002574455874646174653A63726561746500323032302D30332D
        31315431383A30353A31332B30303A30305A6359D50000002574455874646174
        653A6D6F6469667900323032302D30332D31315431383A30353A31332B30303A
        30302B3EE16900000028744558747376673A626173652D7572690066696C653A
        2F2F2F746D702F6D616769636B2D4A504E4D65474A6F895A80CB000000004945
        4E44AE426082}
      ExplicitLeft = 271
    end
    object btMinimized: TPngSpeedButton
      Left = 215
      Top = 5
      Width = 50
      Height = 40
      Align = alRight
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Days One'
      Font.Style = []
      ParentFont = False
      PngImage.Data = {
        89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
        8700000006624B4744000000000000F943BB7F000000097048597300000EC400
        000EC401952B0E1B000000594944415478DAEDCF810D001000C030FE3F1A4FC8
        48BA0BD6393E6FD60300F500403D00500F00D40300F500403D00500F00D40300
        F5C075C03AA5832700000000800EF07A00750075007500750075007500750075
        0075DF03366D5A2031E575C2EF0000002574455874646174653A637265617465
        00323032302D30352D32325431353A35353A34332B30303A3030C3767FE80000
        002574455874646174653A6D6F6469667900323032302D30352D32325431353A
        35353A34332B30303A3030B22BC7540000001974455874536F66747761726500
        7777772E696E6B73636170652E6F72679BEE3C1A0000000049454E44AE426082}
      ExplicitLeft = 172
    end
    object lblTitle: TLabel
      Left = 5
      Top = 5
      Width = 150
      Height = 40
      Align = alLeft
      Alignment = taCenter
      Caption = 'Replicador Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 23
    end
  end
  object footer: TPanel
    Left = 0
    Top = 483
    Width = 320
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    Color = clHotLight
    ParentBackground = False
    TabOrder = 1
  end
  object mmLog: TMemo
    Left = 0
    Top = 394
    Width = 320
    Height = 89
    Align = alBottom
    TabOrder = 2
  end
  object body: TPanel
    Left = 0
    Top = 50
    Width = 320
    Height = 344
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Top = 15
    Padding.Right = 10
    Padding.Bottom = 15
    TabOrder = 3
    object edtContext: TEdit
      AlignWithMargins = True
      Left = 13
      Top = 45
      Width = 294
      Height = 21
      Align = alTop
      TabOrder = 0
      TextHint = 'Contexto do servi'#231'o'
    end
    object edtPort: TEdit
      AlignWithMargins = True
      Left = 13
      Top = 18
      Width = 294
      Height = 21
      Align = alTop
      TabOrder = 1
      TextHint = 'Porta do servi'#231'o'
    end
    object btSaveConfig: TButton
      AlignWithMargins = True
      Left = 13
      Top = 234
      Width = 294
      Height = 25
      Align = alTop
      Caption = 'Salvar configura'#231#245'es'
      TabOrder = 2
      OnClick = btSaveConfigClick
    end
    object cbDatabaseType: TComboBox
      AlignWithMargins = True
      Left = 13
      Top = 72
      Width = 294
      Height = 21
      Align = alTop
      ItemIndex = 0
      TabOrder = 3
      Text = 'Firebird'
      Items.Strings = (
        'Firebird')
    end
    object edtDBPath: TEdit
      AlignWithMargins = True
      Left = 13
      Top = 99
      Width = 294
      Height = 21
      Align = alTop
      TabOrder = 4
      TextHint = 'Caminho da base de dados'
    end
    object edtDBName: TEdit
      AlignWithMargins = True
      Left = 13
      Top = 126
      Width = 294
      Height = 21
      Align = alTop
      TabOrder = 5
      TextHint = 'Nome da base de dados'
      Visible = False
    end
    object edtDBPort: TEdit
      AlignWithMargins = True
      Left = 13
      Top = 153
      Width = 294
      Height = 21
      Align = alTop
      TabOrder = 6
      TextHint = 'Porta do banco de dados'
    end
    object edtDBUser: TEdit
      AlignWithMargins = True
      Left = 13
      Top = 180
      Width = 294
      Height = 21
      Align = alTop
      TabOrder = 7
      TextHint = 'Nome do usu'#225'rio'
    end
    object edtDBPass: TEdit
      AlignWithMargins = True
      Left = 13
      Top = 207
      Width = 294
      Height = 21
      Align = alTop
      TabOrder = 8
      TextHint = 'Senha do banco'
    end
    object btStart: TButton
      AlignWithMargins = True
      Left = 13
      Top = 301
      Width = 294
      Height = 25
      Align = alBottom
      Caption = 'Iniciar'
      TabOrder = 9
      OnClick = btStartClick
    end
  end
  object tmSync: TTimer
    Enabled = False
    OnTimer = tmSyncTimer
    Left = 16
    Top = 496
  end
  object jediINI: TJvAppIniFileStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    AutoFlush = True
    AutoReload = True
    FileName = 'config.ini'
    SubStorages = <>
    Left = 61
    Top = 496
  end
  object jediForm: TJvFormStorage
    AppStorage = jediINI
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredProps.Strings = (
      'edtContext.Text'
      'edtDBName.Text'
      'edtDBPass.Text'
      'edtDBPath.Text'
      'edtDBPort.Text'
      'edtDBUser.Text'
      'edtPort.Text'
      'cbDatabaseType.ItemIndex')
    StoredValues = <>
    Left = 104
    Top = 496
  end
end
