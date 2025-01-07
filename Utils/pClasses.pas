unit pClasses;

interface

uses
  Classes, System.SysUtils, System.Json, System.Generics.Defaults,
  System.Generics.Collections, REST.Json, FireDAC.Comp.Client,
  FireDAC.Stan.Param;

type
  TExeVersionData = record
    CompanyName, FileDescription, FileVersion, InternalName, LegalCopyright, LegalTrademarks, OriginalFileName, ProductName, ProductVersion, comments, PrivateBuild, SpecialBuild, BuildData, Release, Build: string;
  end;

  TStatusServidor = (tssConectado, tssDesconectado);

{$REGION 'Classes LOG'}
  TLogMessage = record
  private
    FMsg: string;
    FCausa: string;
    FSolucao: string;
    FSql: string;
    FParametrosSql: string;
    FIdTipo: string;
    FTipoLog: string;
    procedure SetMsg(const Value: string);
    procedure SetCausa(const Value: string);
    procedure SetSolucao(const Value: string);
    procedure SetSql(const Value: string);
    procedure SetParametrosSql(const Value: string);
    procedure SetIdTipo(const Value: string);
    procedure SetTipoLog(const Value: string);
  public
    constructor Create(ipMsg: string); overload;
    constructor Create(ipMsg, ipCausa: string); overload;
    constructor Create(ipMsg, ipCausa, ipSolucao: string); overload;
    constructor Create(ipMsg, ipCausa, ipSolucao, ipTipo, ipCodigoTipo: string) overload;
    constructor Create(ipMsg, ipCausa, ipSolucao: string; ipDataSet: TFDQuery); overload;
    constructor Create(ipMsg, ipCausa, ipSolucao, ipTipo, ipCodigoTipo: string; ipDataSet: TFDQuery); overload;

    property Msg: string read FMsg write SetMsg;
    property Causa: string read FCausa write SetCausa;
    property Solucao: string read FSolucao write SetSolucao;
    property Sql: string read FSql write SetSql;
    property ParametrosSql: string read FParametrosSql write SetParametrosSql;
    property TipoLog: string read FTipoLog write SetTipoLog;
    property IdTipo: string read FIdTipo write SetIdTipo;

    const
      coMsg = 'MSG';
      coCausa = 'Causa';
      coSolucao = 'Solução';
      coSql = 'SQL';
      coParametrosSql = 'Parâmetros do SQL';
      coTipoLog = 'Tipo do Log';
      coIdTipo = 'ID do Tipo do Log';

    function ToString: string;
    function fpuMontarTexto: string;
  end;

  TLogException = class(Exception)
  private
    FLogMessage: TLogMessage;
    procedure SetLogMessage(const Value: TLogMessage);
  public
    constructor Create(ipLogMessage: TLogMessage);

    property LogMessage: TLogMessage read FLogMessage write SetLogMessage;
  end;
{$ENDREGION}

const
  coDelimitadorCampos = '|';
  coDelimitadorDiferente = 'þ';
  coConfigApi = 'ConfigApi';
  coConfigSistema = 'ConfigSistema';
  coStatusConectado: string = 'Servidor: Conectado';
  coStatusDesconectado: string = 'Servidor: Desconectado';

implementation

{ TLogMessage }

constructor TLogMessage.Create(ipMsg, ipCausa: string);
begin
  Create(ipMsg, ipCausa, '');
end;

constructor TLogMessage.Create(ipMsg, ipCausa, ipSolucao: string);
begin
  Create(ipMsg, ipCausa, ipSolucao, '0', '0', nil);
end;

constructor TLogMessage.Create(ipMsg: string);
begin
  Create(ipMsg, '', '');
end;

procedure TLogMessage.SetMsg(const Value: string);
begin
  FMsg := Value;
end;

procedure TLogMessage.SetParametrosSql(const Value: string);
begin
  FParametrosSql := Value;
end;

constructor TLogMessage.Create(ipMsg, ipCausa, ipSolucao, ipTipo, ipCodigoTipo: string; ipDataSet: TFDQuery);
var
  vaParam: TFDParam;
  i: Integer;
begin
  FMsg := ipMsg;
  FCausa := ipCausa;
  FSolucao := ipSolucao;
  FTipoLog := ipTipo;
  FIdTipo := ipCodigoTipo;
  FSql := '';
  FParametrosSql := '';
  if Assigned(ipDataSet) then
  begin
    FSql := ipDataSet.Sql.Text;
    try
      if ipDataSet.ParamCount > 0 then
      begin
        FParametrosSql := '';
        for i := 0 to ipDataSet.ParamCount - 1 do
        begin
          vaParam := ipDataSet.Params[i];
          if i > 0 then
            FParametrosSql := FParametrosSql + ';';

          FParametrosSql := FParametrosSql + vaParam.Name + ':' + vaParam.Text;
        end;
      end;
    except
      on E: Exception do
        FParametrosSql := FParametrosSql + 'Erro na hora de extrair os valores dos parâmetros. Detalhes: ' + E.message;
    end;
  end;
end;

constructor TLogMessage.Create(ipMsg, ipCausa, ipSolucao: string; ipDataSet: TFDQuery);
begin
  Create(ipMsg, ipCausa, ipSolucao, '0', '0', ipDataSet);
end;

procedure TLogMessage.SetCausa(const Value: string);
begin
  FCausa := Value;
end;

procedure TLogMessage.SetIdTipo(const Value: string);
begin
  FIdTipo := Value;
end;

procedure TLogMessage.SetSolucao(const Value: string);
begin
  FSolucao := Value;
end;

procedure TLogMessage.SetSql(const Value: string);
begin
  FSql := Value;
end;

procedure TLogMessage.SetTipoLog(const Value: string);
begin
  FTipoLog := Value;
end;

function TLogMessage.ToString: string;
begin
  Result := coMsg + '=' + FMsg;
  if FCausa <> '' then
    Result := Result + coDelimitadorCampos + coCausa + '=' + FCausa;
  if FSolucao <> '' then
    Result := Result + coDelimitadorCampos + coSolucao + '=' + FSolucao;
  if FSql <> '' then
    Result := Result + coDelimitadorCampos + coSql + '=' + FSql;
  if FParametrosSql <> '' then
    Result := Result + coDelimitadorCampos + coParametrosSql + '=' + FParametrosSql;
  if FTipoLog <> '' then
    Result := Result + coDelimitadorCampos + coTipoLog + '=' + FTipoLog;
  if FIdTipo <> '' then
    Result := Result + coDelimitadorCampos + coIdTipo + '=' + FIdTipo;
end;

function TLogMessage.fpuMontarTexto: string;
begin
  Result := FMsg;
  if FCausa <> '' then
    Result := Result + ' Causa do erro: ' + FCausa;
  if FSolucao <> '' then
    Result := Result + ' Possível solução: ' + FSolucao;
end;

constructor TLogMessage.Create(ipMsg, ipCausa, ipSolucao, ipTipo, ipCodigoTipo: string);
begin
  Create(ipMsg, ipCausa, ipSolucao, ipTipo, ipCodigoTipo, nil);
end;

{ TLogException }

constructor TLogException.Create(ipLogMessage: TLogMessage);
begin
  inherited Create('');
  FLogMessage := ipLogMessage;
end;

procedure TLogException.SetLogMessage(const Value: TLogMessage);
begin
  FLogMessage := Value;
end;

end.

