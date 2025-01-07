unit pFuncoes;

interface

uses
  pClasses,
  Winapi.Windows, SysUtils, StrUtils, IniFiles, Forms, Json, Generics.Collections;

type
  TVersaoInfo = (viMaJorVersion, viMinorVersion, viRelease, viBuild);

{$REGION 'Funções INI'}
function LerIni(arquivo_endereco, arquivo_nome, tabela_ini, campo_ini: String): String;
procedure GravarIni(arquivo_endereco, arquivo_nome, tabela_ini, campo_ini, valor_ini: String);
{$ENDREGION}

{$REGION 'Funções Sistema'}
procedure Loggar(EMessage : String);
{$ENDREGION}

{$REGION 'Funções EXE'}
function GetEXEVersionData(const fileName: string): TEXEVersionData;
function VersaoExe(const ipFileName: string; const ipVersaoAte: TVersaoInfo): String;
{$ENDREGION}

{$REGION 'Funções JSON'}
function SetJSon(ipNomeCampo: String; ipJSON: TJSONObject): Variant; // função que recebe um JSON e sua codificação e retorna o valor;
function fpuObterJsonValue(ipJsonObject: TJSONObject; ipNomeCampo: string): TJSONValue;
function fpuObterValorStringJson(ipJsonObject: TJSONObject; ipNomeCampo: string): string;
{$ENDREGION}

implementation

function LerIni(arquivo_endereco, arquivo_nome, tabela_ini, campo_ini: String): String;
var
  ServerIni: TIniFile;
begin
  ServerIni := TIniFile.Create(arquivo_endereco + arquivo_nome);
  Result := ServerIni.ReadString(tabela_ini, campo_ini, '');
  ServerIni.Free;
end;

procedure GravarIni(arquivo_endereco, arquivo_nome, tabela_ini, campo_ini, valor_ini: String);
var
  ServerIni: TIniFile;
begin
  ServerIni := TIniFile.Create(arquivo_endereco + arquivo_nome);
  ServerIni.WriteString(tabela_ini, campo_ini, valor_ini);
  ServerIni.Free;
end;

procedure Loggar(EMessage : String);
var
  Arquivo : TextFile;
  NomeDoLog : String;
  DataHora : String;
begin
  //Gerando ou abrindo o arquivo de log
  NomeDoLog := ChangeFileExt(Application.Exename, '.log');
  AssignFile(Arquivo, NomeDoLog);
  if FileExists(NomeDoLog) then
    Append(Arquivo)
  else
    ReWrite(Arquivo);
    try
      //Pegando data e hora do log
      DataHora := DateTimeToStr(Now);
      DataHora := StringReplace(DataHora, '/', ' ', [rfReplaceAll, rfIgnoreCase]);
      DataHora := StringReplace(DataHora, ':', ' ', [rfReplaceAll, rfIgnoreCase]);
      //Escrevendo o log no arquivo
      WriteLn(Arquivo, '****************** '+DateTimeToStr(Now)+ ' ****************** ');
      Writeln(Arquivo, 'Erro Exception: ');
      Writeln(Arquivo,EMessage);
      WriteLn(Arquivo, '----------------------------------------------------------------------');
    finally
      CloseFile(arquivo)
    end;
end;

function GetEXEVersionData(const fileName: string): TEXEVersionData;
type
  PLandCodepage = ^TLandCodepage;

  TLandCodepage = record
    wLanguage,
      wCodePage: Word;
  end;
var
  dummy,
    len: Cardinal;
  Buf, pntr: Pointer;
  lang: string;
begin
  len := GetFileVersionInfoSize(PChar(fileName), dummy);
  if len = 0 then
    RaiseLastOSError;

  GetMem(Buf, len);
  try
    if not GetFileVersionInfo(PChar(fileName), 0, len, Buf) then
      RaiseLastOSError;

    if not VerQueryValue(Buf, '\VarFileInfo\Translation\', pntr, len) then
      RaiseLastOSError;

    lang := Format('%.4x%.4x', [PLandCodepage(pntr)^.wLanguage, PLandCodepage(pntr)^.wCodePage]);

    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\CompanyName'), pntr, len) { and (@len <> nil) } then
      Result.CompanyName := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\FileDescription'), pntr, len) { and (@len <> nil) } then
      Result.FileDescription := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\FileVersion'), pntr, len) { and (@len <> nil) } then
      Result.FileVersion := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\InternalName'), pntr, len) { and (@len <> nil) } then
      Result.InternalName := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\LegalCopyright'), pntr, len) { and (@len <> nil) } then
      Result.LegalCopyright := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\LegalTrademarks'), pntr, len) { and (@len <> nil) } then
      Result.LegalTrademarks := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\OriginalFileName'), pntr, len) { and (@len <> nil) } then
      Result.OriginalFileName := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\ProductName'), pntr, len) { and (@len <> nil) } then
      Result.ProductName := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\ProductVersion'), pntr, len) { and (@len <> nil) } then
      Result.ProductVersion := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\Comments'), pntr, len) { and (@len <> nil) } then
      Result.Comments := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\PrivateBuild'), pntr, len) { and (@len <> nil) } then
      Result.PrivateBuild := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\SpecialBuild'), pntr, len) { and (@len <> nil) } then
      Result.SpecialBuild := PChar(pntr);
    if VerQueryValue(Buf, PChar('\StringFileInfo\' + lang + '\LastCompiledTime'), pntr, len) { and (@len <> nil) } then
      Result.BuildData := PChar(pntr);
  finally
    FreeMem(Buf);
  end;
end;

function VersaoExe(const ipFileName: string; const ipVersaoAte: TVersaoInfo): String;
var
  VerInfoSize, VerValueSize, dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
  V1, V2, V3, V4: Word;
begin
  try
    VerInfoSize := GetFileVersionInfoSize(PChar(ipFileName), dummy);
    GetMem(VerInfo, VerInfoSize);
    GetFileVersionInfo(PChar(ipFileName), 0, VerInfoSize, VerInfo);
    VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);
    with VerValue^ do
      begin
        V1 := dwFileVersionMS shr 16;
        V2 := dwFileVersionMS and $FFFF;
        V3 := dwFileVersionLS shr 16;
        V4 := dwFileVersionLS and $FFFF;

      end;
    FreeMem(VerInfo, VerInfoSize);
  except
    V1 := 0;
    V2 := 0;
    V3 := 0;
    V4 := 0;
  end;
  case ipVersaoAte of
    viMaJorVersion:
      VersaoExe := IntToStr(V1);
    viMinorVersion:
      VersaoExe := IntToStr(V1) + '.' + IntToStr(V2);
    viRelease:
      VersaoExe := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3);
    viBuild:
      VersaoExe := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) + '.' + IntToStr(V4);
  end;
end;

function SetJSon(ipNomeCampo: String; ipJSON: TJSONObject): Variant;
var
  I: Integer;
begin
  Result := '';
  I := 0;
  while ((I <= ipJSON.Count - 1) and (Result = '')) do
    begin
      if AnsiCompareText(ipJSON.Pairs[I].JsonString.Value, ipNomeCampo) = 0 then // quer dizer que os dois campos sao iguais
        Result := (ipJSON.Pairs[I].JsonValue.Value);
      Inc(I);
    end;
end;

function fpuObterJsonValue(ipJsonObject: TJSONObject; ipNomeCampo: string): TJSONValue;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ipJsonObject.Count - 1 do
    begin
      if UpperCase(ipJsonObject.Pairs[I].JsonString.Value) = UpperCase(ipNomeCampo) then // colocar Upper pra não importar identação
        begin
          Result := ipJsonObject.Pairs[I].JsonValue;
          Break;
        end;
    end;
  if Assigned(Result) and (UpperCase(Result.ToJSON) = 'NULL') then
    Result := nil;
end;

function fpuObterValorStringJson(ipJsonObject: TJSONObject; ipNomeCampo: string): string;
var
  vaJsonValue: TJSONValue;
begin
  Result := '';
  vaJsonValue := fpuObterJsonValue(ipJsonObject, ipNomeCampo);
  if Assigned(vaJsonValue) then
    Result := vaJsonValue.Value;
end;

end.
