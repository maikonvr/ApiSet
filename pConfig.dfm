inherited frmConfig: TfrmConfig
  Caption = 'Configura'#231#245'es'
  ClientHeight = 509
  ClientWidth = 612
  OnCreate = FormCreate
  ExplicitWidth = 628
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnSistemaTop: TPanel
    Width = 612
    ExplicitWidth = 612
    inherited btnFecharFormulario: TSpeedButton
      Left = 594
      ExplicitLeft = 594
    end
  end
  object pgPrincipal: TPageControl [1]
    Left = 0
    Top = 17
    Width = 612
    Height = 492
    ActivePage = tabConfigApi
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 419
    object tabConfigSistema: TTabSheet
      Caption = 'Configura'#231#245'es do Sistema'
      ExplicitHeight = 391
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 598
        Height = 150
        Align = alTop
        Caption = ' Configura'#231#245'es do Servidor'
        TabOrder = 0
        object Label4: TLabel
          Left = 12
          Top = 24
          Width = 89
          Height = 13
          Caption = 'Nome do Servidor:'
        end
        object Label5: TLabel
          Left = 296
          Top = 75
          Width = 81
          Height = 13
          Caption = 'Senha do Banco:'
        end
        object btnShowHideSenhaBanco: TSpeedButton
          Left = 440
          Top = 94
          Width = 23
          Height = 21
          Hint = 'Mostrar senha.'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003C3C3C003C3C
            3C003C3C3C003C3C3C003C3C3C463C3C3C8D3C3C3CC73C3C3CF03C3C3CF03C3C
            3CC73C3C3C8D3C3C3C463C3C3C003C3C3C003C3C3C003C3C3C003C3C3C003C3C
            3C003C3C3C203C3C3C8C3C3C3CF33C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CF33C3C3C8C3C3C3C203C3C3C003C3C3C003C3C3C003C3C
            3C203C3C3CA33C3C3CFF3C3C3CA23C3C3C533C3C3C883C3C3CD53C3C3CD53C3C
            3C883C3C3C533C3C3CA23C3C3CFF3C3C3CA33C3C3C203C3C3C003C3C3C003C3C
            3C8C3C3C3CFF3C3C3C5B3C3C3C073C3C3C803C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3C803C3C3C073C3C3C5B3C3C3CFF3C3C3C8C3C3C3C003C3C3C463C3C
            3CF33C3C3C983C3C3C01FFFFFF003C3C3CD53C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CD5FFFFFF003C3C3C013C3C3C983C3C3CF33C3C3C463C3C3CCC3C3C
            3CFF3C3C3CA9FFFFFF00FFFFFF003C3C3CD53C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CD5FFFFFF00FFFFFF003C3C3CA93C3C3CFF3C3C3CCC3C3C3C463C3C
            3CF33C3C3CFF3C3C3C983C3C3C2A3C3C3C803C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3C803C3C3C2A3C3C3C983C3C3CFF3C3C3CF33C3C3C463C3C3C003C3C
            3C8C3C3C3CFF3C3C3CFF3C3C3CCB3C3C3C8C3C3C3C9F3C3C3CD83C3C3CD83C3C
            3C9F3C3C3C8C3C3C3CCB3C3C3CFF3C3C3CFF3C3C3C8C3C3C3C003C3C3C003C3C
            3C203C3C3CA33C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CA33C3C3C203C3C3C003C3C3C003C3C
            3C003C3C3C203C3C3C8C3C3C3CF33C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CF33C3C3C8C3C3C3C203C3C3C003C3C3C003C3C3C003C3C
            3C003C3C3C003C3C3C003C3C3C463C3C3C8D3C3C3CC73C3C3CF03C3C3CF03C3C
            3CC73C3C3C8D3C3C3C463C3C3C003C3C3C003C3C3C003C3C3C00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          Layout = blGlyphTop
          ParentShowHint = False
          ShowHint = True
          Spacing = 0
          OnClick = btnShowHideSenhaBancoClick
        end
        object Label6: TLabel
          Left = 12
          Top = 51
          Width = 81
          Height = 13
          Caption = 'Banco de Dados:'
        end
        object btnSelecionarBanco: TSpeedButton
          AlignWithMargins = True
          Left = 440
          Top = 48
          Width = 23
          Height = 21
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000090000
            000E000000100000001000000010000000100000001000000011000000110000
            001100000011000000100000000B000000031F4F9F001F4F9F001F539ACA245A
            A5FF255CA7FF255BA7FF245AA6FF2459A6FF2358A5FF2358A4FF2356A4FF2256
            A4FF2255A3FF2154A3FF2153A1FF204F9BE313305E2900000002255DA5FF316B
            AEFF6DA6D5FF86CAF0FF46A6E4FF44A3E4FF41A1E3FF3FA0E2FF3C9EE2FF3B9C
            E1FF389BE0FF369AE0FF3498DFFF2C77C1FF1D4A8D8B000000082B68AEFF4984
            BEFF4B8BC5FFB2E3F8FF68BBECFF55B0E8FF52AEE8FF4EACE7FF4CA9E6FF49A8
            E5FF47A6E4FF44A4E4FF41A2E3FF3A92D6FF22569FD50000000D2F6FB4FF6CA7
            D2FF3F87C4FFAED9F0FF9AD8F5FF66BDEEFF63BBEDFF60B9EBFF5DB6EBFF5BB5
            EAFF57B2EAFF55B0E9FF51AEE7FF4FABE7FF2D69B1FF183C6C2F3276B9FF8FC7
            E6FF509FD4FF86BCE0FFC5EFFCFF78CAF2FF74C8F1FF72C5F0FF6FC4F0FF6DC2
            EFFF69C0EEFF66BDEEFF63BBEDFF60B9EBFF448BC9FF24589981357CBCFFAFE3
            F5FF75C8EDFF59A2D4FFDDF7FDFFDFF8FEFFDDF7FEFFDBF7FEFFD8F5FEFFD4F4
            FDFFD0F2FDFFCCEFFCFFC7EDFBFFC1EBFBFF9ACBE9FF2966A9CB3882C1FFC7F5
            FEFF97E5FCFF64BAE5FF4D9FD3FF4D9DD2FF4B9BD1FF4A99CFFF4998CFFF4896
            CEFF4694CCFF4592CBFF3073B7FF3072B6FF2F71B5FF2E6EB3EA3A88C5FFCDF7
            FEFFA6ECFEFF9CE8FDFF93E4FBFF8EE1FBFF89DFFBFF86DEFAFF81DAFAFF7ED8
            F9FF7BD7F9FF79D6F9FF2A6BB0FF000000140000000A000000073D8EC8FFD0F8
            FEFFAEF0FEFFAAEEFEFFA6EDFEFFA5EBFDFFBBF2FDFFD4F9FEFFD5F9FEFFD3F8
            FEFFD1F8FEFFCEF7FDFF3680BFFF00000008FFFFFF00FFFFFF003F92CBFFD3F9
            FEFFB6F3FEFFB3F1FDFFB0F1FEFFB8EDFAFF4895CBFF3B8CC6FF3B8AC6FF3A89
            C5FF3A88C5FF3A87C3FF3782BEC200000005FFFFFF00FFFFFF004197CEFFE2FC
            FEFFE2FCFEFFE1FCFEFFD4F3FAFF4B9ACEEC2961871B00000006000000060000
            000600000006000000060000000400000001FFFFFF00FFFFFF004299CEBF429A
            D0FF4299D0FF4299D0FF4297CFFF3D8FC359000000024195CD004095CC003F94
            CC003F93CC003F92CB003E90CA0000000000FFFFFF00FFFFFF00000000020000
            0003000000030000000400000003000000020000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        end
        object lb2: TLabel
          Left = 107
          Top = 75
          Width = 36
          Height = 13
          Caption = 'Usu'#225'rio'
        end
        object edServidor: TEdit
          Left = 107
          Top = 21
          Width = 145
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TextHint = 'localhost'
          OnExit = SalvarIniOnExit
        end
        object edSenhaBanco: TEdit
          Left = 296
          Top = 94
          Width = 145
          Height = 21
          ParentShowHint = False
          PasswordChar = '*'
          ShowHint = True
          TabOrder = 3
          OnExit = SalvarIniOnExit
        end
        object edBanco: TEdit
          Left = 107
          Top = 48
          Width = 334
          Height = 21
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
          OnExit = SalvarIniOnExit
        end
        object edUsuarioBanco: TEdit
          Left = 107
          Top = 94
          Width = 145
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          TextHint = 'sysdba'
          OnExit = SalvarIniOnExit
        end
        object bttTestarConexao: TButton
          Left = 485
          Top = 114
          Width = 100
          Height = 25
          Caption = 'Testar Conex'#227'o'
          TabOrder = 4
          OnClick = bttTestarConexaoClick
        end
      end
    end
    object tabConfigApi: TTabSheet
      Caption = 'Configura'#231#245'es da Api'
      ImageIndex = 1
      ExplicitHeight = 391
      object grpConfigApi: TGroupBox
        Left = 0
        Top = 0
        Width = 604
        Height = 101
        Align = alTop
        Caption = ' Configura'#231#245'es do Uso da API '
        TabOrder = 0
        object Label2: TLabel
          Left = 19
          Top = 32
          Width = 83
          Height = 13
          Caption = 'URL Preferencial:'
        end
        object Label3: TLabel
          Left = 19
          Top = 59
          Width = 79
          Height = 13
          Caption = 'URL Alternativa:'
        end
        object edUrlPref: TEdit
          Left = 110
          Top = 29
          Width = 450
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = 'https://api.tiendanube.com/v1/'
          TextHint = 'https://api.tiendanube.com/v1/'
          OnExit = SalvarIniOnExit
        end
        object edUrlAlt: TEdit
          Left = 110
          Top = 56
          Width = 450
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Text = 'https://api.nuvemshop.com.br/v1/'
          TextHint = 'https://api.nuvemshop.com.br/v1/'
          OnExit = SalvarIniOnExit
        end
      end
      object grpConfigCliente: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 104
        Width = 598
        Height = 85
        Align = alTop
        Caption = ' Configura'#231#245'es do Cliente '
        TabOrder = 1
        object lb1: TLabel
          Left = 16
          Top = 24
          Width = 70
          Height = 13
          Caption = 'ID. do Cliente:'
        end
        object Label1: TLabel
          Left = 16
          Top = 51
          Width = 85
          Height = 13
          Caption = 'Senha do Cliente:'
        end
        object btnShowHide: TSpeedButton
          Left = 563
          Top = 48
          Width = 23
          Height = 21
          Hint = 'Mostrar senha.'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003C3C3C003C3C
            3C003C3C3C003C3C3C003C3C3C463C3C3C8D3C3C3CC73C3C3CF03C3C3CF03C3C
            3CC73C3C3C8D3C3C3C463C3C3C003C3C3C003C3C3C003C3C3C003C3C3C003C3C
            3C003C3C3C203C3C3C8C3C3C3CF33C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CF33C3C3C8C3C3C3C203C3C3C003C3C3C003C3C3C003C3C
            3C203C3C3CA33C3C3CFF3C3C3CA23C3C3C533C3C3C883C3C3CD53C3C3CD53C3C
            3C883C3C3C533C3C3CA23C3C3CFF3C3C3CA33C3C3C203C3C3C003C3C3C003C3C
            3C8C3C3C3CFF3C3C3C5B3C3C3C073C3C3C803C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3C803C3C3C073C3C3C5B3C3C3CFF3C3C3C8C3C3C3C003C3C3C463C3C
            3CF33C3C3C983C3C3C01FFFFFF003C3C3CD53C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CD5FFFFFF003C3C3C013C3C3C983C3C3CF33C3C3C463C3C3CCC3C3C
            3CFF3C3C3CA9FFFFFF00FFFFFF003C3C3CD53C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CD5FFFFFF00FFFFFF003C3C3CA93C3C3CFF3C3C3CCC3C3C3C463C3C
            3CF33C3C3CFF3C3C3C983C3C3C2A3C3C3C803C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3C803C3C3C2A3C3C3C983C3C3CFF3C3C3CF33C3C3C463C3C3C003C3C
            3C8C3C3C3CFF3C3C3CFF3C3C3CCB3C3C3C8C3C3C3C9F3C3C3CD83C3C3CD83C3C
            3C9F3C3C3C8C3C3C3CCB3C3C3CFF3C3C3CFF3C3C3C8C3C3C3C003C3C3C003C3C
            3C203C3C3CA33C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CA33C3C3C203C3C3C003C3C3C003C3C
            3C003C3C3C203C3C3C8C3C3C3CF33C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CF33C3C3C8C3C3C3C203C3C3C003C3C3C003C3C3C003C3C
            3C003C3C3C003C3C3C003C3C3C463C3C3C8D3C3C3CC73C3C3CF03C3C3CF03C3C
            3CC73C3C3C8D3C3C3C463C3C3C003C3C3C003C3C3C003C3C3C00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          Layout = blGlyphTop
          ParentShowHint = False
          ShowHint = True
          Spacing = 0
          OnClick = btnShowHideClick
        end
        object edIdClient: TEdit
          Left = 107
          Top = 21
          Width = 145
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TextHint = 'client_id'
          OnExit = SalvarIniOnExit
        end
        object edSenha: TEdit
          Left = 107
          Top = 48
          Width = 450
          Height = 21
          ParentShowHint = False
          PasswordChar = '*'
          ShowHint = True
          TabOrder = 1
          TextHint = 'cliente_secret'
          OnExit = SalvarIniOnExit
        end
      end
      object grpApiTest: TGroupBox
        Left = 0
        Top = 192
        Width = 604
        Height = 272
        Align = alClient
        Caption = ' Teste da API '
        TabOrder = 2
        ExplicitLeft = 64
        ExplicitTop = 232
        ExplicitWidth = 185
        ExplicitHeight = 105
        object pnTopTest: TPanel
          Left = 2
          Top = 15
          Width = 600
          Height = 42
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object btnTestApi: TBitBtn
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 84
            Height = 36
            Align = alLeft
            Caption = 'Testar Cliente'
            TabOrder = 0
            OnClick = btnTestApiClick
          end
        end
        object edTestApi: TMemo
          Left = 2
          Top = 57
          Width = 600
          Height = 213
          Align = alClient
          TabOrder = 1
          ExplicitLeft = 128
          ExplicitTop = 128
          ExplicitWidth = 185
          ExplicitHeight = 89
        end
      end
    end
  end
end
