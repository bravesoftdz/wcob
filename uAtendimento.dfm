object frmAtendimento: TfrmAtendimento
  Left = 192
  Top = 149
  Caption = 'Atendimento'
  ClientHeight = 510
  ClientWidth = 810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 810
    Height = 39
    Align = alTop
    Color = clWhite
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    ExplicitWidth = 818
    object lblTop: TLabel
      Left = 8
      Top = 7
      Width = 123
      Height = 23
      Caption = 'Atendimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnRodape: TPanel
    Left = 0
    Top = 467
    Width = 810
    Height = 43
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 472
    ExplicitWidth = 818
    DesignSize = (
      810
      43)
    object btnSair: TBitBtn
      Left = 696
      Top = 4
      Width = 120
      Height = 35
      Cursor = crHandPoint
      Hint = 'Sai da tela'
      Anchors = [akRight, akBottom]
      Caption = '&Sair'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnSairClick
      Glyph.Data = {
        8E0B0000424D8E0B00000000000036000000280000002C000000160000000100
        180000000000580B0000CE0E0000D80E00000000000000000000FFFFFFF2F2F2
        F2F2F2D3D3D3E8E8E8F5F5F5DBDBDBDDDDDDECECECEEEEEED3D3D3EBEBEBF7F7
        F723230F4F4F00B2B2A8E9E9E9D6D6D6EBEBEBFAFAFAFFFFFFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBF7F7F7F7F7F7FB2B2A8BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFFFFF
        FFF0F0F0D8D8D8EDEDEDEAEAEADFDFDFDCDCDCF4F4F4E6E6E6D7D7D7F2F2F2E7
        E7E7DDDDDD4C4C0CFFFF006868119B9B9BF4F4F4E7E7E7DBDBDBE6E6E6BFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBF7F7F7F7F7F7F7F7F7F7F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFD3D3D3E4E4E4EFEFEFE4E4E4D8D8D8EDEDEDF3F3F3D3D3D3E7E7E7F1F1F1
        DFDFDFDBDBDBECECEC4D4D0DFFFF008D8D00515105878781DFDFDFEDEDEDECEC
        ECBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBF7F7F7FFFFF00BFBFBF7F7F7F7F7F7FBFBFBFBFBFBF
        BFBFBFBFBFBFE6E6E6EDEDEDE1E1E1DBDBDBF5F5F5E3E3E3DCDCDCEAEAEAEAEA
        EAE0E0E0DBDBDBF6F6F6E3E3E34D4D0DFFFF008F8F007F7F0056560DA1A1A1E2
        E2E2DBDBDBBFBFBFBFBFBFFFFFAFFFFFAFFFFFAFFFFFAFFFFFAFFFFFAFFFFFAF
        FFFFAFFFFFAFBFBFBFBFBFBFBFBFBF7F7F7FFFFF00BFBFBFBFBFBF7F7F7FBFBF
        BFFFFFAFFFFFAFFFFFAF4B4B4B5050504E4E4E4848484F4F4F5050504A4A4A4C
        4C4C444444F0F0F0F3F3F3D3D3D3E7E7E74E4E0EFFFF008F8F007F7F007D7D00
        4C4C0D323232484848BFBFBF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
        7F7F7F7F7F7F7FFFFFAFBFBFBFBFBFBFBFBFBF7F7F7FFFFF00BFBFBFBFBFBFBF
        BFBF7F7F7F7F7F7F7F7F7F7F7F7FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBF4A4A4ADFDFDFDFDFDFE9E9E9EBEBEB4D4D0DFFFF008F8F007F7F
        007F7F00474700636363BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFBFBFBF7F7F7FFFFF00BFBFBF
        BFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFB0B0B0BFBFBF4040403F3F3F3737373737373F3F3F434303FFFF008F
        8F007F7F007F7F00474700636363BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFB0B0B0BFBFBF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7FFFFF
        00BFBFBFBFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBF3D3D3D8F8F8F3E3E3E7F7F7F7F7F7F7F7F7F7F7F7F474707
        FFFF008F8F007F7F007F7F00474700636363BFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBF7F7F7F7F7F7F7F7F7FFFFFAFBFBFBFBFBFBFBFBFBF7F
        7F7FFFFF00BFBFBFBFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBF3C3C304D4D141515137F7F7F7F7F7F7F7F7F7F7F
        7F474707FFFF008D8D007777007D7D00474700636363BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F7F7F7F7F7F7FFFFFAFBFBFBFBFBFBF
        BFBFBF7F7F7FFFFF00BFBFBFBFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF4646309A9A004545046161617F7F7F7F
        7F7F7F7F7F474707FFFF005F5F08171717676700474700636363BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7FFFFFAF7F7F7F7F7F7FBFBF
        BFBFBFBFBFBFBF7F7F7FFFFF00BFBFBF7F7F7F7F7F7F7F7F7FFFFFAFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF474727EDED0092920045450E
        6363637F7F7F7F7F7F474707FFFF004747276B6B6B676700474700636363BFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7FFFFFAFFFFFAF7F
        7F7F7F7F7FBFBFBFBFBFBF7F7F7FFFFF00BFBFBF7F7F7F7F7F7F7F7F7FFFFFAF
        BFBFBFBFBFBFAEAEAE57574531310A272700272700272700424200FFFF00F9F9
        009898004242006363637F7F7F474707FFFF007E7E002727006E6E0047470063
        6363BFBFBFBFBFBF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7FFFFFAF
        BFBFBFFFFFAF7F7F7F7F7F7FBFBFBF7F7F7FFFFF00BFBFBF7F7F7F7F7F7F7F7F
        7FFFFFAFBFBFBFBFBFBF8989898C8C13CFCF01CFCF00CFCF00CFCF00D5D500FF
        FF00FFFF00EDED0098980045450E616161474707FFFF008F8F007F7F007F7F00
        474700636363BFBFBFBFBFBF7F7F7FFFFFAFFFFFAFFFFFAFFFFFAFFFFFAFFFFF
        AFBFBFBFBFBFBFBFBFBFFFFFAF7F7F7F7F7F7F7F7F7FFFFF00BFBFBFBFBFBFBF
        BFBF7F7F7FFFFFAFBFBFBFBFBFBF898989A1A113FEFE2CFFFFAFFFFFAFFFFFAF
        FFFFAFFFFFAFFFFFDBFFFF6DE3E3004B4B095B5B5B474707FFFF008F8F007F7F
        007F7F00474700636363BFBFBFBFBFBF7F7F7F7F7F7FBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F7F7F7F7F7F7FFFFF00BFBFBF
        BFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFA7A7A76F6F4879790C7A7A0A7A7A
        0A7A7A0A8A8A09FFFF3EFFFF70E4E4005F5F005858587F7F7F474707FFFF008F
        8F007F7F007F7F00474700636363BFBFBFBFBFBFA7A7A77F7F7F7F7F7F7F7F7F
        7F7F7F7F7F7F7F7F7FBFBFBFBFBFBFBFBFBF7F7F7F7F7F7FBFBFBF7F7F7FFFFF
        00BFBFBFBFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFBFBFBFB1B1B1A9A9A9A9
        A9A9A9A9A9A9A9A94C4C2CFFFF0DE6E6075959085858537F7F7F7F7F7F474707
        FFFF008F8F007F7F007F7F00474700636363BFBFBFBFBFBFBFBFBFB1B1B1A9A9
        A9A9A9A9A9A9A9A9A9A97F7F7FBFBFBFBFBFBF7F7F7F7F7F7FBFBFBFBFBFBF7F
        7F7FFFFF00BFBFBFBFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBF505030E3E3005F5F035757577F7F7F7F7F7F7F7F
        7F474707FFFF008F8F007F7F007F7F00474700636363BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7FBFBFBF7F7F7F7F7F7FBFBFBFBFBFBF
        BFBFBF7F7F7FFFFF008F8F00BFBFBFBFBFBF7F7F7FFFFFAFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF4242356E6E2521211B7F7F7F7F7F7F7F
        7F7F7F7F7F5E5E52999906D5D5008787007F7F00474700636363BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F7F7F7F7F7F7FFFFFAFBFBF
        BFBFBFBFBFBFBF7F7F7F999906D5D500878700BFBFBF7F7F7FFFFFAFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7070708888884444447F7F7F
        7F7F7F7F7F7F7F7F7F7F7F7F565656999906DBDB00898900474700636363BFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F7F7F7F7F7F7FFF
        FFAFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F999906DBDB008989007F7F7FFFFFAF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF4444
        447F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F5E5E529B9B03D7D7004C4C0076
        7676BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        7F7F7FFFFFAFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF7F7F7F9B9B03D7D7007F7F
        7FFFFFAFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBF4141415656565656565656565656565656565656565656562E2E2E888807
        65650C888888BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F88
        88077F7F7FFFFFAFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBF9696968989898989898989898989898989898989898989898989
        89898989898989B1B1B1BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBF7F7F7FFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00BFBFBFBFBFBF}
      NumGlyphs = 2
    end
    object btnCarregar: TBitBtn
      Left = 591
      Top = 4
      Width = 103
      Height = 34
      Cursor = crHandPoint
      Hint = 'Carrega Dados'
      Anchors = [akRight, akBottom]
      Caption = '&Carregar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCarregarClick
      Glyph.Data = {
        7E030000424D7E030000000000003600000028000000120000000F0000000100
        1800000000004803000000000000000000000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BF3F3700BFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFCF6760CF67
        60CF6760CF6760000000BFBFBFBFBFBFBFBFBFBFBFBF000000000000BFBFBFBF
        BFBFBFBFBFBFBFBF0000BFBFBFBFBFBF007F00007F00007F00007F00007F0000
        0000BFBFBFBFBFBFBFBFBF000000A0983F000000BFBFBFBFBFBFBFBFBFBFBFBF
        0000BFBFBFA0983FA0983FA0983FA0983F007F00000000BFBFBFBFBFBFBFBFBF
        3F3700A0983F00FF007F7F003F37003F3700BFBFBFBFBFBF0000BFBFBFA0983F
        00FF00A0983F007F00000000BFBFBFBFBFBFBFBFBF3F3700A0983F00FF00A098
        3FA0983F007F003F3700007F00BFBFBF0000BFBFBFA0983F00FF00A0983F0000
        00BFBFBFBFBFBFBFBFBFA0983FA0983F00FF00A0983F00FF00A0983F007F0000
        7F003F3700BFBFBF0000BFBFBFA0983F90FF2FA0983F007F003F3700BFBFBFBF
        BFBF90FF2FFFFFFFA0983F90FF2FA0983FA0983F007F003F37003F3700BFBFBF
        0000BFBFBFA0983F90FF2FA0983FA0983F007F003F3700BFBFBFBFBFBF90FF2F
        FFFFFFA0983F90FF2FA0983F007F00007F003F3700BFBFBF0000BFBFBFA0983F
        90FF2FFFFFFF90FF2F90FF2F007F003F370000000000000090FF2FFFFFFFA098
        3FA0983F007F003F37003F3700BFBFBF0000BFBFBFA0983FFFFFFFA0983F0000
        0000000000000000000000000000000000000000FF00FFFFFF00000090FF2F00
        7F003F3700BFBFBF0000BFBFBFA0983F90FF2F0000000000003F37000000003F
        37000000003F370000000000000000FF0000000000000090FF2F3F3700BFBFBF
        0000BFBFBFA0983F90FF2FA0983F3F370000000060302F00000060302F000000
        000000000000000000000000000000A0983F007F00BFBFBF0000BFBFBFBFBFBF
        A0983F90FF2FCF67603F37003F37003F37000000003F37000000000000000000
        00000000007F00007F00BFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFA0983FA098
        3FA0983F007F00007F00007F00007F00007F00007F00007F00007F00007F00BF
        BFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        0000}
    end
  end
  object pnTela: TPanel
    Left = 0
    Top = 39
    Width = 810
    Height = 428
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 818
    ExplicitHeight = 433
    object gbOpcoes: TGroupBox
      Left = 1
      Top = 1
      Width = 816
      Height = 80
      Align = alTop
      Caption = 'Op'#231#245'es'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object gbCobrador: TGroupBox
        Left = 4
        Top = 13
        Width = 269
        Height = 38
        Caption = 'Cobrador'
        TabOrder = 0
        object pnDescCobrador: TPanel
          Left = 55
          Top = 15
          Width = 212
          Height = 21
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object lblDescCobrador: TLabel
            Left = 0
            Top = 0
            Width = 3
            Height = 13
            Align = alClient
            Alignment = taCenter
          end
        end
        object pnCobrador: TPanel
          Left = 2
          Top = 15
          Width = 53
          Height = 21
          Align = alLeft
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 1
        end
      end
      object gbCredor: TGroupBox
        Left = 274
        Top = 13
        Width = 269
        Height = 38
        Caption = 'Credor'
        TabOrder = 1
        object pnCredor: TPanel
          Left = 2
          Top = 15
          Width = 53
          Height = 21
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
        end
        object pnDescCredor: TPanel
          Left = 55
          Top = 15
          Width = 212
          Height = 21
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object lblDescCredor: TLabel
            Left = 0
            Top = 0
            Width = 3
            Height = 13
            Align = alClient
            Alignment = taCenter
          end
        end
      end
      object gbDevedor: TGroupBox
        Left = 544
        Top = 13
        Width = 269
        Height = 38
        Caption = 'Devedor'
        TabOrder = 2
        object pnDevedor: TPanel
          Left = 2
          Top = 15
          Width = 53
          Height = 21
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
        end
        object pnDescDevedor: TPanel
          Left = 55
          Top = 15
          Width = 212
          Height = 21
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object lblDescDevedor: TLabel
            Left = 0
            Top = 0
            Width = 3
            Height = 13
            Align = alClient
            Alignment = taCenter
          end
        end
      end
      object ckPendentes: TCheckBox
        Left = 8
        Top = 56
        Width = 193
        Height = 17
        Caption = 'Somente Pendentes'
        TabOrder = 3
      end
    end
  end
end
