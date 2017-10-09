unit UPurgarPlanosFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, UPantallaFrm;

type
  TPurgarPlanosFrm = class(TPantallaFrm)
    Image1: TImage;
    Image2: TImage;
    lblTitulo: TLabel;
    lblAdvertencia3: TLabel;
    lblAdvertencia2: TLabel;
    ListView: TListView;
    stbPlano: TStatusBar;
    btnConfirmar: TButton;
    btnVolver: TButton;
    lblAdvertencia1: TLabel;

    procedure btnVolverEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure ListViewEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LockScreen;
    procedure UnLockScreen;

  end;

var
  PurgarPlanosFrm: TPurgarPlanosFrm;

implementation
uses
  UPlano, USistema, UPlanoDB;

{$R *.dfm}
procedure TPurgarPlanosFrm.LockScreen;
begin
  lblTitulo.Enabled:= False;
  ListView.Enabled:= False;
  lblAdvertencia1.Enabled:= False;
  lblAdvertencia2.Enabled:= False;
  lblAdvertencia3.Enabled:= False;
  btnConfirmar.Visible:= False;
  btnVolver.SetFocus;
end;

procedure TPurgarPlanosFrm.UnLockScreen;
begin
  lblTitulo.Enabled:= True;
  ListView.Enabled:= True;
  lblAdvertencia1.Enabled:= True;
  lblAdvertencia2.Enabled:= True;
  lblAdvertencia3.Enabled:= True;
  btnConfirmar.Visible:= True;
end;


procedure TPurgarPlanosFrm.btnVolverEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TPurgarPlanosFrm.btnConfirmarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Purga los planos';
end;

procedure TPurgarPlanosFrm.btnVolverClick(Sender: TObject);
begin
  if not FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_BAJA);
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_PURGAR);
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_RECUPERAR);
  end
  else
  begin
    UnLockScreen;
    FLocked:= False;
  end;

  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TPurgarPlanosFrm.FormShow(Sender: TObject);
var
  L: Boolean;
begin
  L:= False;
  if PantallaLockeada(SCR_PLANO_BAJA) then
    L:= True
  else if PantallaLockeada(SCR_PLANO_PURGAR) then
    L:= True
  else if PantallaLockeada(SCR_PLANO_RECUPERAR) then
    L:= True;

  if L then
    LockScreen
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_PLANO_BAJA, SCR_PLANO_PURGAR);
    TSistema.GetInstance.LockScreen(SCR_PLANO_PURGAR, SCR_PLANO_PURGAR);
    TSistema.GetInstance.LockScreen(SCR_PLANO_RECUPERAR, SCR_PLANO_PURGAR);

    ListView.Clear;
    if not TSistema.GetInstance.PlanoDB.ConsultaPurgar(ListView) then
    begin
      ShowMessage('No hay planos dados de baja en la base de datos');
      btnConfirmar.Enabled:= False;
      ListView.Enabled:= False;
    end
    else
    begin
      btnConfirmar.Enabled:= True;
      ListView.Enabled:= True;
    end;

    btnVolver.SetFocus;
  end;
end;

procedure TPurgarPlanosFrm.btnConfirmarClick(Sender: TObject);
var
  CodRet: Integer;

begin
  if MessageDlg('¿ Esta seguro que desea purgar los planos ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    CodRet:= TSistema.GetInstance.PlanoDB.BajaMasiva(TAB_BAJA);

    if CodRet = PLN_BAJA_OK then
    begin

      ShowMessage('Los planos fueron eliminados satisfactoriamente');
      btnVolver.Click;
    end
    else
      ShowMessage('Los planos no se pudieron eliminar');
  end;
end;

procedure TPurgarPlanosFrm.ListViewEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Listado de planos a purgar';
end;

procedure TPurgarPlanosFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

end.
