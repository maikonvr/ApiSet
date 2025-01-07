unit pConfig;

interface

uses
  pClasses, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, pZero,
  System.ImageList, Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TfrmConfig = class(TfrmZero)
    grpConfigCliente: TGroupBox;
    lb1: TLabel;
    edIdClient: TEdit;
    Label1: TLabel;
    btnShowHide: TSpeedButton;
    edSenha: TEdit;
    grpConfigApi: TGroupBox;
    Label2: TLabel;
    edUrlPref: TEdit;
    Label3: TLabel;
    edUrlAlt: TEdit;
    pgPrincipal: TPageControl;
    tabConfigSistema: TTabSheet;
    tabConfigApi: TTabSheet;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    btnShowHideSenhaBanco: TSpeedButton;
    edServidor: TEdit;
    edSenhaBanco: TEdit;
    Label6: TLabel;
    edBanco: TEdit;
    btnSelecionarBanco: TSpeedButton;
    lb2: TLabel;
    edUsuarioBanco: TEdit;
    bttTestarConexao: TButton;
    grpApiTest: TGroupBox;
    pnTopTest: TPanel;
    btnTestApi: TBitBtn;
    edTestApi: TMemo;
    procedure btnShowHideClick(Sender: TObject);
    procedure SalvarIniOnExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnShowHideSenhaBancoClick(Sender: TObject);
    procedure bttTestarConexaoClick(Sender: TObject);
    procedure btnTestApiClick(Sender: TObject);
  private
    procedure ppvMostrarOcultarChars(Sender: TObject; Btn: TSpeedButton);
    procedure ppvCarregarConfiguracao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

uses
  pPrincipal, pFuncoes, pdmPrincipal, pApiGateway;

{$R *.dfm}

procedure TfrmConfig.btnShowHideClick(Sender: TObject);
begin
  inherited;
  ppvMostrarOcultarChars(edSenha, btnShowHide);
end;

procedure TfrmConfig.bttTestarConexaoClick(Sender: TObject);
begin
  inherited;
  try
    try
      with dmPrincipal do
      begin
        if edServidor.Text <> ''then
          FDConn.Params.Database := edServidor.Text +':'+ edBanco.Text
        else
          FDConn.Params.Database := edBanco.Text;
        FDConn.Params.UserName := edUsuarioBanco.Text;
        FDConn.Params.Password := edSenhaBanco.Text;
        FDConn.Connected := True;
      end;
        ShowMessage('Conexão efetuada com sucesso!');
        frmPrincipal.fpuConectarServidor;
    except
      on E: Exception do
      begin
        dmPrincipal.FDConn.Connected := False;
        ShowMessage('Não foi possível conectar no B.D. Detalhes: ' + sLineBreak + E.Message);
        Exit;
      end;
    end;
  finally
    dmPrincipal.FDConn.Connected := False;
  end;
end;

procedure TfrmConfig.FormCreate(Sender: TObject);
begin
  inherited;
  ppvCarregarConfiguracao;
end;

procedure TfrmConfig.ppvCarregarConfiguracao;
var
  I: Integer;
  Comp: TComponent;
begin
  for I := 0 to Pred(Self.ComponentCount) do
  begin
    Comp := Self.Components[I];
    if Comp is TEdit then
      TEdit(Comp).Text := LerIni(ExtractFilePath(Application.ExeName), coConfigIni, coConfigSistema, TEdit(Comp).Name);
  end;
end;

procedure TfrmConfig.ppvMostrarOcultarChars(Sender: TObject; Btn: TSpeedButton);
begin
  if TEdit(Sender).PasswordChar = #0 then
  begin
    TSpeedButton(Sender).Hint := 'Ocultar senha.';
    TEdit(Sender).PasswordChar := '*'
  end
  else
  begin
    TSpeedButton(Sender).Hint := 'Mostrar senha.';
    TEdit(Sender).PasswordChar := #0;
  end;
end;

procedure TfrmConfig.SalvarIniOnExit(Sender: TObject);
begin
  if Sender is TEdit then
    GravarIni(ExtractFilePath(Application.ExeName), coConfigIni, coConfigSistema, TEdit(Sender).Name, TEdit(Sender).Text);
end;

procedure TfrmConfig.btnShowHideSenhaBancoClick(Sender: TObject);
begin
  inherited;
  ppvMostrarOcultarChars(edSenhaBanco, btnShowHideSenhaBanco);
end;

procedure TfrmConfig.btnTestApiClick(Sender: TObject);
var
  Api: TApiGateway;
begin
  inherited;
  edTestApi.Lines.Clear;
  Api := TApiGateway.Create;
  try
	//Implementar log de teste de conexão com a API
    //Api.fpuExecutarPostRequest();
  finally
    FreeAndNil(Api);
  end;
end;

end.

