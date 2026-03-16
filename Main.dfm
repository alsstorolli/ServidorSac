object FMain: TFMain
  Left = 0
  Top = 0
  Caption = 'Vers'#227'o 2.5'
  ClientHeight = 438
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  TextHeight = 15
  object lbsistema: TLabel
    Left = 224
    Top = 144
    Width = 68
    Height = 28
    Caption = 'Sistema'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbservidor: TLabel
    Left = 224
    Top = 216
    Width = 74
    Height = 28
    Caption = 'Servidor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 419
    Width = 632
    Height = 19
    Panels = <
      item
        Text = 'Porta:'
        Width = 150
      end
      item
        Width = 200
      end>
    ExplicitTop = 415
    ExplicitWidth = 626
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    OnDblClick = TrayIcon1DblClick
    Left = 536
    Top = 56
  end
  object BalloonHint1: TBalloonHint
    Left = 472
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 360
    Top = 88
    object Servios1: TMenuItem
      Caption = 'Servi'#231'os'
      object IniciarServidor1: TMenuItem
        Caption = 'Iniciar Servidor'
        OnClick = IniciarServidor1Click
      end
      object testarConexo1: TMenuItem
        Caption = 'Testar Conex'#227'o'
        OnClick = testaConexao1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 480
    Top = 160
    object r1: TMenuItem
      Caption = 'Restaurar Janela'
      OnClick = r1Click
    end
    object f1: TMenuItem
      Caption = 'Fechar'
      OnClick = f1Click
    end
  end
end
