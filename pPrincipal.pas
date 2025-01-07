unit pPrincipal;

interface

uses
  pClasses, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, pSplash, Vcl.AppEvnts,
  System.ImageList, Vcl.ImgList, Vcl.WinXCtrls, TDI, Vcl.Buttons;

type
  TInfoConexao = record
    Servidor, BancoDados, Usuario, Senha: string;
  end;

  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    bttMinimizar: TButton;
    TrayIcon1: TTrayIcon;
    pnTopInfoSistema: TPanel;
    ApplicationEvents1: TApplicationEvents;
    ImageList32: TImageList;
    bttFecharSistema: TButton;
    btnConfig: TButton;
    pnStatusServidor: TPanel;
    pnMensagem: TPanel;
    pnBotoesPrincipal: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure bttMinimizarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure bttFecharSistemaClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
  private
    { Private declarations }
    FStatusServidor: TStatusServidor;
    FSplash: TfrmSplash;
    FInfoSistema: TExeVersionData;
    FInfoConexao: TInfoConexao;

    procedure ppvCarregarInfoConexao;
    procedure ppvCarregarTray;
    procedure ppvCarregarInfoSistema;

  public
    { Public declarations }
    function fpuConectarServidor: Boolean;
    property InfoSistema: TExeVersionData read FInfoSistema;
  end;

const
  coConfigIni = 'ApiSet.ini';

var
  frmPrincipal: TfrmPrincipal;
  FTDI: TTDI;

implementation

uses
  pConfig, pFuncoes, pdmPrincipal;

{$R *.dfm}

procedure TfrmPrincipal.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;

  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TfrmPrincipal.btnConfigClick(Sender: TObject);
begin
  FTDI.MostrarFormulario(TfrmConfig, false, 3);
end;

procedure TfrmPrincipal.bttFecharSistemaClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Tem certeza que deseja finalizar o sistema?'), 'Atenção!', MB_DEFBUTTON1 + MB_YESNO) = ID_YES then
    Application.Terminate;
end;

procedure TfrmPrincipal.bttMinimizarClick(Sender: TObject);
begin
  ApplicationEvents1Minimize(Self);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FStatusServidor := tssDesconectado;
  FSplash := TfrmSplash.Create(nil);
  try
    FSplash.Show;
    FSplash.ppuUpdateStatus('Iniciando Sistema...');

    StatusBar1.Panels[0].Text := 'Iniciado em ' + FormatDateTime('dd/mm/yy hh:mm:ss', now);

    ppvCarregarTray;

    ppvCarregarInfoSistema;

    FSplash.ppuUpdateStatus('Conectando ao servidor...');

    fpuConectarServidor;

    FSplash.ppuUpdateStatus('Iniciando serviços...');
  finally
    FSplash.Close;
    FreeAndNil(FSplash);
  end;

  FTDI := TTDI.Create(Self, nil, ImageList32);
  FTDI.MostrarMenuPopup := True;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FTDI);
  Application.Terminate;
end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

function TfrmPrincipal.fpuConectarServidor: Boolean;
begin
  Result := False;
  try
    ppvCarregarInfoConexao;

    try
      with dmPrincipal do
      begin
        if FInfoConexao.Servidor <> '' then
          FDConn.Params.Database := FInfoConexao.Servidor + ':' + FInfoConexao.BancoDados
        else
          FDConn.Params.Database := FInfoConexao.BancoDados;

        FDConn.Params.UserName := FInfoConexao.Usuario;
        FDConn.Params.Password := FInfoConexao.Senha;
        FDConn.Connected := True;
      end;

      FStatusServidor := tssConectado;
      pnStatusServidor.Caption := coStatusConectado;
      pnMensagem.Caption := '';
    except
      on E: Exception do
      begin
        dmPrincipal.FDConn.Connected := False;
        Loggar(E.Message);
        pnStatusServidor.Caption := coStatusDesconectado;
        pnMensagem.Caption := 'Verifique as configurações do servidor.';
      end;
    end;
  finally
    //
  end;
end;

procedure TfrmPrincipal.ppvCarregarInfoConexao;
begin
  FInfoConexao.Servidor := LerIni(ExtractFilePath(Application.ExeName), coConfigIni, coConfigSistema, 'edServidor');
  FInfoConexao.BancoDados := LerIni(ExtractFilePath(Application.ExeName), coConfigIni, coConfigSistema, 'edBanco');
  FInfoConexao.Usuario := LerIni(ExtractFilePath(Application.ExeName), coConfigIni, coConfigSistema, 'edUsuarioBanco');
  FInfoConexao.Senha := LerIni(ExtractFilePath(Application.ExeName), coConfigIni, coConfigSistema, 'edSenhaBanco');
end;

procedure TfrmPrincipal.ppvCarregarInfoSistema;
begin
  FInfoSistema := GetEXEVersionData(ExtractFilePath(Application.ExeName) + '\ApiSet.exe');
  FInfoSistema.Release := VersaoExe(ExtractFilePath(Application.ExeName) + '\ApiSet.exe', viRelease);
  FInfoSistema.Build := VersaoExe(ExtractFilePath(Application.ExeName) + '\ApiSet.exe', viBuild);

  pnTopInfoSistema.Caption := 'Api - Set Sistemas : Versão ' + FInfoSistema.Build;
end;

procedure TfrmPrincipal.ppvCarregarTray;
var
  Icone: TIcon;
begin
  Icone := TIcon.Create;
  try
    ImageList32.GetIcon(1, Icone);
    TrayIcon1.Icon.Assign(Icone);

    TrayIcon1.Hint := 'Api - Set Sistemas';
    TrayIcon1.AnimateInterval := 200;

    TrayIcon1.BalloonTitle := 'Aplicativo ainda em execução.';
    TrayIcon1.BalloonHint := 'Clique 2x no ícone para restaurar.';
    TrayIcon1.BalloonFlags := bfInfo;
  finally
    FreeAndNil(Icone);
  end;
end;

procedure TfrmPrincipal.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.

