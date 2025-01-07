unit pApiGateway;

interface

uses
  pProdutos, pBaseApi, pClasses, System.Generics.Collections, System.JSon,
  System.Net.HttpClient, System.SysUtils, System.Classes;

type
  IApiGateway = interface(IBaseAPi)
    ['{107BEEA5-5670-4021-ABFB-A93D5FAE3F6B}']
    function fpuExecutarPostRequest(ipRota: string; ipDados: TJsonValue): IHttpResponse; overload;
    function fpuExecutarPostRequest(ipRota: string; ipDados: TJsonValue; ipContentType: string): IHttpResponse; overload;
    function fpuExecutarPostRequest(ipRota: string; ipDados: TStream; ipContentType: string): IHttpResponse; overload;
    function fpuExecutarGetRequest(ipRota: string): IHttpResponse;
  end;

  TApiGateway = class(TBaseApi, IApiGateway)
  protected
    FAcessToken: string;
    FTokenType: string;
    FScopes: string;
    FUserId: string;
    FBaseUrl: string;
    FProdutos: TObjectList<TProdutos>;

    function fprEncapsularRequest(ipRequest: TFunc<IHttpResponse>): IHttpResponse; virtual;
    function fprObterToken: boolean; virtual;
    procedure ppvSalvarLog(ipMsg: string);
  public
    constructor Create; override;
    destructor Destroy; override;
    function fpuResponseToJson(ipContent: string): TJSONObject;
    function fpuExecutarPostRequest(ipRota: string; ipDados: TJsonValue): IHttpResponse; overload;
    function fpuExecutarPostRequest(ipRota: string; ipDados: TJsonValue; ipContentType: string): IHttpResponse; overload;
    function fpuExecutarPostRequest(ipRota: string; ipDados: TStream; ipContentType: string): IHttpResponse; overload;
    function fpuExecutarGetRequest(ipRota: string): IHttpResponse;

    const
      coUsuarioAutenticacao = '11710';
      coSenhaAutenticacao = '5fdb34c7afb04fc4deb3523c950a900fb1c03f0a830c61d3';
      coAutorizacao = 'authorization_code';
      coRecursoAutenticacao = 'https://www.tiendanube.com/apps/authorize/token';
      coRecursoProdutos = '';
  end;

  TFuncoesApi = class
  private
    FUrlRecursoAutenticar: string;
    FUrlRecursoProdutos: string;
    FEndPoint: string;
    FApiGateway: TApiGateway;

    function fpvJsonToProdutos(ipJson: TJSONObject): TObjectList<TProdutos>;
    function fpvProdutosToJson(ipListaProdutos: TObjectList<TProdutos>): TJSONObject;

  public
    constructor Create;
    destructor Destroy; override;

    function fpuSolicitarProdutos: TObjectList<TProdutos>;

    property EndPoint: string read FEndPoint;
  end;

implementation

uses
  pFuncoes;

{ TApiGateway }

constructor TApiGateway.Create;
begin
  inherited;
  IgnoreServerCertificate := True;
  FHttpClient.ConnectionTimeout := 10000;
  FHttpClient.ResponseTimeout := 10000;
end;

destructor TApiGateway.Destroy;
begin
  inherited;
end;

function TApiGateway.fprObterToken: boolean;
var
  vaPostData: TJSONObject;
  vaResponse: IHttpResponse;
begin
  inherited;
  Result := False;
  vaPostData := TJSONObject.Create;
  try
    vaPostData.AddPair('client_id', coUsuarioAutenticacao);
    vaPostData.AddPair('client_secret', coSenhaAutenticacao);
    vaPostData.AddPair('grant_type', coAutorizacao);

    vaResponse := fpuEfetuarRequisicao(hmPost, FBaseUrl + coRecursoAutenticacao, vaPostData, 1);
    if Assigned(vaResponse) then
    begin
      if vaResponse.StatusCode = 200 then
      begin
        if vaResponse.ContainsHeader('access_token') then
        begin
          FAcessToken := vaResponse.HeaderValue['access_token'];
          FTokenType := vaResponse.HeaderValue['token_type'];
          FScopes := vaResponse.HeaderValue['scope'];
          FUserId := vaResponse.HeaderValue['user_id'];
          TBaseApi(Self).ppuAddHeader('access_token', FAcessToken);
          Result := True;
        end;
      end
      else
        raise TLogException.Create(TLogMessage.Create('O Host retornou um StatusCode diferente do esperado na função de retornar o Access-Token.', vaResponse.StatusText + ' - ' + vaResponse.ContentAsString()));
    end;
  finally
    vaPostData.Free;
  end;
end;

function TApiGateway.fpuResponseToJson(ipContent: string): TJSONObject;
var
  vaJsonResponse: TJSONObject;
begin
  Result := nil;
  vaJsonResponse := TJSONObject.ParseJSONValue(ipContent) as TJSONObject;
  try
    if Assigned(vaJsonResponse) and (vaJsonResponse is TJSONObject) then
    begin
      Result := vaJsonResponse;
    end
  finally
    vaJsonResponse.Free;
  end;
end;

procedure TApiGateway.ppvSalvarLog(ipMsg: string);
begin
  Loggar(ipMsg);
end;

function TApiGateway.fprEncapsularRequest(ipRequest: TFunc<IHttpResponse>): IHttpResponse;
var
  vaSucesso: boolean;
  vaQtdeTentativas: integer;
begin
  Result := nil;

  FBaseUrl := '';
  vaSucesso := False;
  vaQtdeTentativas := 1;
  repeat
    if FAcessToken = '' then
      fprObterToken;

    if FAcessToken <> '' then
    begin
      Result := ipRequest;
      vaSucesso := (Assigned(Result)) and (Result.StatusCode = 200);
    end;

    // Limpando o token anterior e pegando um novo, tentativas 2x
    if (FAcessToken <> '') and Assigned(Result) and ((Result.StatusCode = 401) or (Result.StatusCode = 400)) then
    begin
      FAcessToken := '';
      if fprObterToken then
      begin
        Result := ipRequest;
        vaSucesso := (Assigned(Result)) and (Result.StatusCode = 200);
      end;
    end;
    Inc(vaQtdeTentativas);
  until (vaSucesso or (vaQtdeTentativas > 2));

end;

function TApiGateway.fpuExecutarGetRequest(ipRota: string): IHttpResponse;
begin
  Result := fprEncapsularRequest(
    function: IHttpResponse
    begin
      Exit(fpuEfetuarRequisicao(hmGet, FBaseUrl + ipRota, nil, 1));
    end);
end;

function TApiGateway.fpuExecutarPostRequest(ipRota: string; ipDados: TJsonValue): IHttpResponse;
begin
  Result := fpuExecutarPostRequest(ipRota, ipDados, 'application/json');
end;

function TApiGateway.fpuExecutarPostRequest(ipRota: string; ipDados: TJsonValue; ipContentType: string): IHttpResponse;
var
  vaDataStream: TStringStream;
begin
  vaDataStream := nil;
  try
    if Assigned(ipDados) and (not (ipDados is TJSONObject)) then
    begin
      vaDataStream := TStringStream.Create;
      if ipDados <> nil then
        vaDataStream.WriteString(ipDados.ToJSON());
      vaDataStream.Position := 0;
    end;

    Result := fprEncapsularRequest(
      function: IHttpResponse
      begin
        if Assigned(vaDataStream) then
          Exit(fpuEfetuarRequisicao(hmPost, FBaseUrl + ipRota, vaDataStream, ipContentType, 1))
        else
          Exit(fpuEfetuarRequisicao(hmPost, FBaseUrl + ipRota, ipDados, ipContentType, 1));
      end);
  finally
    if Assigned(vaDataStream) then
      vaDataStream.Free;
  end;
end;

function TApiGateway.fpuExecutarPostRequest(ipRota: string; ipDados: TStream; ipContentType: string): IHttpResponse;
begin
  Result := fprEncapsularRequest(
    function: IHttpResponse
    begin
      Exit(fpuEfetuarRequisicao(hmPost, FBaseUrl + ipRota, ipDados, ipContentType, 1));
    end);
end;

{ TFuncoesApi }

constructor TFuncoesApi.Create;
var
  vaEndPoint: string;
begin
  FEndPoint := vaEndPoint;
  if (not vaEndPoint.StartsWith('http://', True)) and (not vaEndPoint.StartsWith('https://', True)) then
    FEndPoint := 'http://' + vaEndPoint;

  FApiGateway := TApiGateway.Create;
  FApiGateway.FBaseUrl := FEndPoint;
  FUrlRecursoAutenticar := FApiGateway.coRecursoAutenticacao;
  FUrlRecursoProdutos := FApiGateway.coRecursoProdutos;
end;

destructor TFuncoesApi.Destroy;
begin
  FApiGateway.Free;
end;

function TFuncoesApi.fpuSolicitarProdutos: TObjectList<TProdutos>;
var
  vaJsonResposta: TJSONArray;
  vaJsonObject: TJSONObject;
  vaResponse: IHttpResponse;
  vaResposta: string;
  I: integer;
begin
  Result := nil;
  vaResposta := '';
  try
    vaResponse := FApiGateway.fpuExecutarGetRequest(FUrlRecursoProdutos);
    if Assigned(vaResponse) then
    begin
      vaResposta := vaResponse.ContentAsString();
      if (vaResponse.StatusCode = 200) then
      begin
        Result := TObjectList<TProdutos>.Create;
        vaJsonResposta := TJSONObject.ParseJSONValue(vaResposta, False, True) as TJSONArray;
        try
          if vaJsonResposta.Count > 0 then
          begin
            for I := 0 to Pred(vaJsonResposta.Count) do
            begin
              vaJsonObject := vaJsonResposta.Items[I] as TJSONObject;
//                      Result.Add(fpvJsonToProdutos(vaJsonObject));
            end;
          end;
        finally
          vaJsonResposta.Free;
        end;
      end
      else
        raise Exception.Create(vaResposta);
    end
    else
      raise Exception.Create('Não foi possível obter resposta do servidor.');
  except
    on E: TLogException do
    begin
      raise TLogException.Create(TLogMessage.Create('Houve um erro ao buscar os Produtos.' + slineBreak + 'JSON retornado: ' + vaResposta, E.LogMessage.ToString));
    end;
    on E: Exception do
    begin
      raise TLogException.Create(TLogMessage.Create('Houve um erro ao buscar os Produtos.' + slineBreak + 'JSON retornado: ' + vaResposta, E.message));
    end;
  end;
end;

function TFuncoesApi.fpvJsonToProdutos(ipJson: TJSONObject): TObjectList<TProdutos>;
begin
  Result := TObjectList<TProdutos>.Create;
//  Result.Id := StrToInt(fpuObterValorStringJson(ipJson, 'IDPRODUTO'));
//  Result.Nome := fpuObterValorStringJson(ipJson, 'DESCRICAO');
end;

function TFuncoesApi.fpvProdutosToJson(ipListaProdutos: TObjectList<TProdutos>): TJSONObject;
begin
  Result := TJSONObject.Create;
  //
end;

end.

