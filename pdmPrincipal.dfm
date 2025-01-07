object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Height = 251
  Width = 335
  object FDConn: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Database=C:\Sistemas\Delphi\SetSistema\BD\DADOS-SET.FDB'
      'Server=localhost'
      'User_Name=sysdba'
      'Password=masterkey')
    FetchOptions.AssignedValues = [evMode]
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvDataSnapCompatibility]
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object ADGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 152
    Top = 16
  end
  object ADManager1: TFDManager
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvDataSnapCompatibility, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtBCD
        TargetDataType = dtFmtBCD
      end
      item
        SourceDataType = dtCurrency
        TargetDataType = dtFmtBCD
      end
      item
        SourceDataType = dtWideString
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.DataSnapCompatibility = True
    ActiveStoredUsage = []
    Left = 56
    Top = 104
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'fbclient.dll'
    Left = 152
    Top = 88
  end
end
