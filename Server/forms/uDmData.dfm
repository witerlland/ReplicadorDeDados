object dmData: TdmData
  OldCreateOrder = False
  Height = 179
  Width = 196
  object fdConn: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 32
    Top = 24
  end
  object fdTrans: TFDTransaction
    Connection = fdConn
    Left = 120
    Top = 24
  end
  object restDB: TRESTDWPoolerDB
    RESTDriver = restDriver
    Compression = True
    Encoding = esUtf8
    StrsTrim = False
    StrsEmpty2Null = False
    StrsTrim2Len = True
    Active = True
    PoolerOffMessage = 'RESTPooler not active.'
    ParamCreate = True
    Left = 120
    Top = 96
  end
  object restDriver: TRESTDWDriverFD
    CommitRecords = 100
    Connection = fdConn
    Left = 32
    Top = 96
  end
  object jediINI: TJvAppIniFileStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    ReadOnly = True
    AutoFlush = True
    AutoReload = True
    FileName = 'config.ini'
    SubStorages = <>
    Left = 77
    Top = 67
  end
end
