unit pSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Samples.Gauges,
  Vcl.Imaging.pngimage, dxGDIPlusClasses;

type
  TfrmSplash = class(TForm)
    Gauge1: TGauge;
    pnStatus: TPanel;
  private
    { Private declarations }
  public
    procedure ppuUpdateStatus(ipStatus: String);
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

{ TfrmSplash }

procedure TfrmSplash.ppuUpdateStatus(ipStatus: String);
begin
  pnStatus.Caption := ipStatus;
  Gauge1.Progress := Gauge1.Progress + 1;
  Application.ProcessMessages;
end;

end.
