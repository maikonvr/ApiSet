unit pZero;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls;

type
  TfrmZero = class(TForm)
    pnSistemaTop: TPanel;
    ImageListZero: TImageList;
    btnFecharFormulario: TSpeedButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharFormularioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmZero: TfrmZero;

implementation

uses
  pPrincipal;

{$R *.dfm}

procedure TfrmZero.btnFecharFormularioClick(Sender: TObject);
begin
  FTDI.Fechar(False);
end;

procedure TfrmZero.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0);
    end;
end;

end.
