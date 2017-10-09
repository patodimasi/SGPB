unit UAcercaDeFrm;

interface

uses
	Windows, Forms, Controls, StdCtrls, ExtCtrls, Graphics, Classes;

type
  TAcercaDeFrm = class(TForm)
    btnAceptar: TButton;
    lblNombre: TLabel;
    lblDescripcion: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAceptarClick(Sender: TObject);
    procedure lblNombreClick(Sender: TObject);
    procedure lblNombreMouseEnter(Sender: TObject);
    procedure lblNombreMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AcercaDeFrm: TAcercaDeFrm;

implementation

uses
  UPrincipalFrm, ShellAPI;

{$R *.dfm}

procedure TAcercaDeFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  btnAceptar.Click;
end;

procedure TAcercaDeFrm.btnAceptarClick(Sender: TObject);
begin
  PrincipalFrm.Enabled:= True;
  PrincipalFrm.Show;
  Hide;
end;

procedure TAcercaDeFrm.lblNombreClick(Sender: TObject);
begin
  ShellExecute(Handle, nil, 'mailto:pdimasi@hotmail.com?subject=SGPB', nil, nil, sw_ShowNormal);
end;

procedure TAcercaDeFrm.lblNombreMouseEnter(Sender: TObject);
begin
  lblNombre.Font.Color:= clYellow;
end;

procedure TAcercaDeFrm.lblNombreMouseLeave(Sender: TObject);
begin
  lblNombre.Font.Color:= clBlack;
end;


end.

