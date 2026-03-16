unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Horse , Horse.Jhonson,
  Vcl.StdCtrls, Vcl.ComCtrls,ControllerConfiguracao,ControllerCadastros;

type
  TFMain = class(TForm)
    TrayIcon1: TTrayIcon;
    BalloonHint1: TBalloonHint;
    MainMenu1: TMainMenu;
    Servios1: TMenuItem;
    IniciarServidor1: TMenuItem;
    lbsistema: TLabel;
    lbservidor: TLabel;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    r1: TMenuItem;
    f1: TMenuItem;
    testarConexo1: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure r1Click(Sender: TObject);
    procedure f1Click(Sender: TObject);
    procedure IniciarServidor1Click(Sender: TObject);
    procedure testaConexao1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    fConfiguracao:TControllerConfiguracao;
    fcontrollercadastros:TControllerCadastros;
    procedure InicializaServidor;
  public
    { Public declarations }
    function ValidarInstancia:boolean;
    procedure Start;
    procedure Status;
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

procedure TFMain.f1Click(Sender: TObject);
begin
  Application.Terminate;

end;

procedure TFMain.FormActivate(Sender: TObject);
begin
  if Tag=0 then begin
    Tag:=1;
    TrayIcon1.Hint:='Servidor Sac';
    TrayIcon1.BalloonTitle:='Restaurar a janela principal.';
    TrayIcon1.BalloonHint:='Dê um duplo click no ícone para restaurar a janela principal do Servidor Sac';
    TrayIcon1.BalloonFlags:=bfInfo;
    InicializaServidor;
    WindowState:=wsMinimized;
    TrayIcon1.Visible:=True;
    TrayIcon1.Animate:=True;
    TrayIcon1.ShowBalloonHint;
    Status;
  end;
end;


procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=false;
  Hide();
  WindowState:=wsMinimized;
  TrayIcon1.Visible:=True;
  TrayIcon1.Animate:=True;
  TrayIcon1.ShowBalloonHint;

end;

procedure TFMain.InicializaServidor;
begin

  if not ValidarInstancia then exit;
  fConfiguracao:=TControllerConfiguracao.Create;
  fConfiguracao.LerConfiguracao('Config.json');
  fcontrollercadastros:=TControllerCadastros.Create(fConfiguracao);

  TrayIcon1.Hint:='Servidor de Dados Sac';
  TrayIcon1.AnimateInterval:=200;
  TrayIcon1.BalloonTitle:='Restaurar a janela.';
  TrayIcon1.BalloonHint:='Duplo click no ícone para restaurar a janela do Servidor do Sac';
  TrayIcon1.BalloonFlags:=bfInfo;
  Start;

end;

procedure TFMain.IniciarServidor1Click(Sender: TObject);
begin
  if IniciarServidor1.Checked then begin
    IniciarServidor1.Checked:=False;
    IniciarServidor1.Caption:='Iniciar Servidor';
    //Parar;
    THorse.StopListen;
    Status;
    Exit;
  end;
  if not IniciarServidor1.Checked then begin
    IniciarServidor1.Checked:=True;
    IniciarServidor1.Caption:='Para Servidor';
    Start;
  end;
end;

procedure TFMain.r1Click(Sender: TObject);
begin
  TrayIcon1DblClick(Self);

end;

procedure TFMain.Start;
begin
  IniciarServidor1.Checked:=True;
  IniciarServidor1.Caption:='Parar Servidor';
  THorse.Use(Jhonson);

  THorse.Get('',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    begin
      Res.Send('Escutando na porta: '+THorse.Port.ToString);
    end);

   THorse.Get('/ping',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    begin
      Res.Send('pong');
    end);
{
   THorse.Get('/portadores',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    begin
      Res.Send('aqui traria cadastro de portadores');
    end);
}
  fcontrollercadastros.AtivaListeners;

  THorse.Get('/mesasgetmvto/:empresa/:id',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    var cMensagem,cRetorno:String;
    begin
      try
//        Log.Add('Request mesasgetmvto empresa: '+Req.Params['empresa']+' ID: '+Req.Params['id']);
//        cRetorno:=fServidor.GetMvtoMesas(Funcoes.Inteiro(Req.Params['empresa']),Funcoes.Inteiro(Req.Params['id']),cMensagem);
        Res.Send(cRetorno);
//        Log.Add('Retorno mesasgetmvto mensagem '+cMensagem);
//        Log.Add('Retorno mesasgetmvto '+cRetorno);
      except
        on E: Exception do begin
//          Log.Add('Erro mesasgetmvto '+e.Message);
        end;
      end;
    end);

//  THorse.Listen(9000);
  THorse.Listen(9145);
  Status;

end;

procedure TFMain.Status;
begin
  lbSistema.Caption:='Sistema: Sac';
  if IniciarServidor1.Checked then
    lbServidor.Caption:='SERVIDOR INICIADO'
  else
    lbServidor.Caption:='SERVIDOR PARADO';
  if THorse.IsRunning then begin
    StatusBar1.Panels[0].Text:='Status: Online  ';
    StatusBar1.Panels[1].Text:='Escutando a porta: '+IntToStr(THorse.Port);
  end
  else begin
    StatusBar1.Panels[0].Text:='Status: Offline  ';
    StatusBar1.Panels[1].Text:='Não escutando a porta: '+IntToStr(THorse.Port);
  end;

end;

procedure TFMain.testaConexao1Click(Sender: TObject);
begin
 if Assigned(fcontrollercadastros) then begin
    if fcontrollercadastros.Conectar then
      ShowMessage('Conectado com sucesso ao servidor local')
    else
      ShowMessage('Não foi posssível conectar no servidor local');
  end else begin
    ShowMessage('Não configurado servidor para integração com Sac');
  end;
end;

procedure TFMain.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible:=false;
  Show();
  WindowState:=wsNormal;
  Application.BringToFront();

end;

function TFMain.ValidarInstancia: boolean;
var hSemaforo: THandle;
    NomeSistema:string;
begin
  Result := True;
//  if (DuplicidadeInstancia) and (NomeSistema <> '') then  begin
  NomeSistema:=ExtractFileName( Application.ExeName );
  if (NomeSistema <> '') then  begin
    hSemaforo := CreateSemaphore(Nil, 0, 1, PChar(NomeSistema));
//    Semaforo := hSemaforo;
    if (hSemaforo <> 0) and (GetLastError() = ERROR_ALREADY_EXISTS) then   begin
      Showmessage('O programa: ' + NomeSistema + ' Já esta sendo executado');
      Application.Terminate;
      Result := False;
    end;
  end;

end;

end.
