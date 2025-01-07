unit pBaseApi;

interface

uses
  System.Net.HttpClient, System.Net.HttpClientComponent, System.Net.URLClient,
  Soap.EncdDecd, System.NetEncoding, System.JSON, System.Classes,
  System.Generics.Collections, pClasses, System.SysUtils;

type
  THTTPMethod = (hmGet, hmPost, hmPut, hmDelete);

  IBaseApi = interface
    function GetOnLog: TProc<TLogMessage, Integer>;
    procedure SetOnLog(Value: TProc<TLogMessage, Integer>);

    property OnLog: TProc<TLogMessage, Integer> read GetOnLog write SetOnLog;
  end;

  TBaseApi = class(TInterfacedObject, IBaseApi)
  private
    FIgnoreServerCertificate: Boolean;
    FScopes: TArray<string>;
    procedure SetIgnoreServerCertificate(const Value: Boolean);
  protected
    FUltimaUrlUtilizada: String;
    FHttpClient: TNetHTTPClient;
    // FHeaders: TArray<TNameValuePair>;
    FOnLog: TProc<TLogMessage, Integer>;

    function GetOnLog: TProc<TLogMessage, Integer>; virtual;
    procedure SetOnLog(Value: TProc<TLogMessage, Integer>);

    procedure pprLogar(ipMsg: TLogMessage; ipStatus: Integer); virtual;
    procedure pprValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest; const Certificate: TCertificate; var Accepted: Boolean); virtual;
  public
    property OnLog: TProc<TLogMessage, Integer> read GetOnLog write SetOnLog;
    property IgnoreServerCertificate: Boolean read FIgnoreServerCertificate write SetIgnoreServerCertificate;
    property UltimaUrlUtilizada: String read FUltimaUrlUtilizada;

    constructor Create; virtual;
    destructor Destroy; override;

    procedure ppuConfigurarAutenticacaoBasica(ipUsuario, ipSenha: String);
    procedure ppuConfigurarAutenticacaoBearer(ipToken: String);
    procedure ppuAddHeader(ipChave, ipValor: String);
    function fpuGetScopes: TArray<string>;
    function fpuEfetuarRequisicao(ipMetodo: THTTPMethod; ipUrl: String; ipData: TJsonValue; ipQtdeRetry: Integer = 3): IHttpResponse; overload;
    function fpuEfetuarRequisicao(ipMetodo: THTTPMethod; ipUrl: String; ipData: TJsonValue; ipContentType: String; ipQtdeRetry: Integer = 3): IHttpResponse; overload;
    function fpuEfetuarRequisicao(ipMetodo: THTTPMethod; ipUrl: String; ipData: TStream; ipContentType: String; ipQtdeRetry: Integer = 3): IHttpResponse; overload;
  end;

implementation

{ TBaseApi }

constructor TBaseApi.Create;
begin
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpClient.ContentType := 'application/json; charset=utf-8';

  FHttpClient.OnValidateServerCertificate := pprValidateServerCertificate;
  FHttpClient.SecureProtocols := [THTTPSecureProtocol.TLS12];
  // FHttpClient.Accept := 'application/json';
end;

destructor TBaseApi.Destroy;
begin
  FHttpClient.Free;
  inherited;
end;

function TBaseApi.fpuEfetuarRequisicao(ipMetodo: THTTPMethod; ipUrl: String; ipData: TStream; ipContentType: String; ipQtdeRetry: Integer): IHttpResponse;
var
  vaSucesso: Boolean;
  vaQtdeTentativas: Integer;
{$IFDEF DEBUG}
  vaEscoposConcatenados: String;
  i:Integer;
{$ENDIF}
begin
  Result := nil;
  vaSucesso := false;
  vaQtdeTentativas := 1;
  repeat
    try
      FHttpClient.ContentType := ipContentType;
{$IFDEF DEBUG}
      // Verificar sobre os escopos, se serão necessários
      if (ipUrl.Contains('8080')) or (ipUrl.Contains('localhost')) then
        begin
          FHttpClient.CustomHeaders['X-Authenticated-UserId'] := 'UserId'; //Usuário
          vaEscoposConcatenados := FScopes[0];
          for I := 1 to High(FScopes) do
            vaEscoposConcatenados := vaEscoposConcatenados + ' ' + FScopes[I];
          FHttpClient.CustomHeaders['X-Authenticated-Scope'] := vaEscoposConcatenados;
        end;
{$ENDIF}
      if Assigned(ipData) then
        ipData.Position := 0;
      case ipMetodo of
        hmGet:
          Result := FHttpClient.Get(ipUrl);
        hmPost:
          Result := FHttpClient.Post(ipUrl, ipData);
        hmPut:
          Result := FHttpClient.Put(ipUrl, ipData);
        hmDelete:
          Result := FHttpClient.Delete(ipUrl);
      end;
      vaSucesso := true;
    except
      on E: Exception do
        begin
          Inc(vaQtdeTentativas);
          pprLogar(TLogMessage.Create('Erro ao realizar uma solicitação no endpoint: ' + FUltimaUrlUtilizada, E.message), 1); // 1 = erro
          sleep(1000);
        end;
    end;
  until (vaSucesso or (vaQtdeTentativas > ipQtdeRetry));
end;

function TBaseApi.fpuGetScopes: TArray<string>;
begin
  //
end;

function TBaseApi.fpuEfetuarRequisicao(ipMetodo: THTTPMethod; ipUrl: String; ipData: TJsonValue; ipContentType: String; ipQtdeRetry: Integer): IHttpResponse;
var
  vaDataStream: TStringStream;
begin
  FUltimaUrlUtilizada := ipUrl;
  vaDataStream := nil;
  try
    if Assigned(ipData) and (ipMetodo in [hmPost, hmPut]) then
      begin
        vaDataStream := TStringStream.Create;
        vaDataStream.WriteString(ipData.ToJSON());
        vaDataStream.Position := 0;
      end;

    Result := fpuEfetuarRequisicao(ipMetodo, ipUrl, vaDataStream, ipContentType, ipQtdeRetry);
  finally
    if Assigned(vaDataStream) then
      vaDataStream.Free;
  end;
end;

function TBaseApi.fpuEfetuarRequisicao(ipMetodo: THTTPMethod; ipUrl: String; ipData: TJsonValue; ipQtdeRetry: Integer = 3): IHttpResponse;
begin
  Result := fpuEfetuarRequisicao(ipMetodo, ipUrl, ipData, 'application/json', ipQtdeRetry);
end;

function TBaseApi.GetOnLog: TProc<TLogMessage, Integer>;
begin
  Result := FOnLog;
end;

procedure TBaseApi.pprLogar(ipMsg: TLogMessage; ipStatus: Integer);
begin
  if Assigned(FOnLog) then
    FOnLog(ipMsg, ipStatus);
end;

procedure TBaseApi.pprValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest; const Certificate: TCertificate;
  var Accepted: Boolean);
begin
  if FIgnoreServerCertificate then
    Accepted := true;
end;

procedure TBaseApi.SetIgnoreServerCertificate(const Value: Boolean);
begin
  FIgnoreServerCertificate := Value;
end;

procedure TBaseApi.SetOnLog(Value: TProc<TLogMessage, Integer>);
begin
  FOnLog := Value;
end;

procedure TBaseApi.ppuAddHeader(ipChave, ipValor: String);
begin
  FHttpClient.CustomHeaders[ipChave] := ipValor;
end;

procedure TBaseApi.ppuConfigurarAutenticacaoBasica(ipUsuario, ipSenha: String);
var
  vaAutenticacao: String;
begin
  // converte para base64
  vaAutenticacao := EncodeString(ipUsuario + ':' + ipSenha);
  FHttpClient.CustomHeaders['Authorization'] := 'Basic ' + vaAutenticacao;
// SetLength(FHeaders, Length(FHeaders) + 1);
// FHeaders[High(FHeaders)] := TNameValuePair.Create('Authorization', 'Basic ' + vaAutenticacao);
end;

procedure TBaseApi.ppuConfigurarAutenticacaoBearer(ipToken: String);
begin
  FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + ipToken;
// SetLength(FHeaders, Length(FHeaders) + 1);
// FHeaders[High(FHeaders)] := TNameValuePair.Create('Authorization', 'Bearer ' + ipToken);
end;

end.
