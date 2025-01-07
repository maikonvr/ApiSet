program ApiSet;

uses
  Vcl.Forms,
  pPrincipal in 'pPrincipal.pas' {frmPrincipal},
  pdmPrincipal in 'pdmPrincipal.pas' {dmPrincipal: TDataModule},
  pBaseApi in 'Interfaces\pBaseApi.pas',
  pClasses in 'Utils\pClasses.pas',
  pSplash in 'pSplash.pas' {frmSplash},
  pFuncoes in 'Utils\pFuncoes.pas',
  TDI in 'TDI.pas',
  pZero in 'pZero.pas' {frmZero},
  pConfig in 'pConfig.pas' {frmConfig},
  pApiGateway in 'WebHooks\pApiGateway.pas',
  pProdutos in 'Classes\pProdutos.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

