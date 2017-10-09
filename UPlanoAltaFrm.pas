unit UPlanoAltaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UPantallaFrm,UMotorSQL;

type
  TPlanoAltaFrm = class(TPantallaFrm)
    edtCodigo: TEdit;
    lblCodigo: TLabel;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbPlano: TStatusBar;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    procedure GenerarCodigo;
    procedure LockScreen;
    procedure UnLockScreen;
  end;

var
  PlanoAltaFrm: TPlanoAltaFrm;

implementation

{$R *.dfm}

uses
  UPlano, USistema, UPlanoDB, UUtiles, shlobj;

procedure TPlanoAltaFrm.LockScreen;
begin
  lblCodigo.Enabled:= False;
  edtCodigo.Enabled:= False;
  edtCodigo.Text:= '';
  lblDescripcion.Enabled:= False;
  edtDescripcion.Enabled:= False;
  lblUbicacion.Enabled:= False;
  edtUbicacion.Enabled:= False;
  btnDir.Enabled:= False;
  btnConfirmar.Visible:= False;
  btnLimpiar.Visible:= False;
  btnVolver.SetFocus;
end;

procedure TPlanoAltaFrm.UnLockScreen;
begin
  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
  lblDescripcion.Enabled:= True;
  edtDescripcion.Enabled:= True;
  lblUbicacion.Enabled:= True;
  edtUbicacion.Enabled:= True;
  btnDir.Enabled:= True;
  btnConfirmar.Visible:= True;
  btnLimpiar.Visible:= True;
end;

procedure TPlanoAltaFrm.btnLimpiarClick(Sender: TObject);
begin
  edtDescripcion.Text:= '';
  edtUbicacion.Text:= '';
  edtDescripcion.SetFocus;
end;

procedure TPlanoAltaFrm.btnVolverClick(Sender: TObject);
begin
  if not FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_ALTA);
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

procedure TPlanoAltaFrm.btnConfirmarClick(Sender: TObject);
var
  Plano: TPlano;
  CodRet: Integer;

begin
  if MessageDlg('¿ Esta seguro que desea dar de alta el plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    Plano:= TPlano.Create;

    with Plano do
    begin
      Codigo:= edtCodigo.Text;
      Descripcion:= edtDescripcion.Text;
      Revision:= 0;
      Edicion:= 0;
      Fecha:= DateToStr(Date);
      Estado:= PLN_EST_PEND_APR;
      UsuarioAlta:= TSistema.GetInstance.GetUsuario.Logon;
      UsuarioAprobacion:= '';
      FechaAprobacion:= '';
      UsuarioRecepcion:= '';
      FechaRecepcion:= '';
      Ubicacion:= edtUbicacion.Text;
      Superado:= 'NS';
      UsuarioCreacion:= TSistema.GetInstance.GetUsuario.Logon;
      FechaCreacion:= DateToStr(Date);
      UsuarioModif:= '';
      FechaModif:= '';

    end;

    CodRet:= TSistema.GetInstance.PlanoDB.Alta(Plano, TAB_PLANO,'NS');
    if CodRet = PLN_ALTA_OK then
    begin
      ShowMessage('El plano ' + Plano.Codigo + ' se dió de alta satisfactoriamente');
      Plano.Free;
      btnLimpiar.Click;

      if MessageDlg('¿ Desea dar de alta otro plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then
        GenerarCodigo
      else
        btnVolver.Click;
    end
    else
      ShowMessage('El plano ' + Plano.Codigo + ' no se pudo dar de alta');
  end;
end;

procedure TPlanoAltaFrm.FormShow(Sender: TObject);
begin
 if PantallaLockeada(SCR_PLANO_ALTA) then
  begin
    LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_PLANO_ALTA, SCR_PLANO_ALTA);
    FLocked:= False;
    GenerarCodigo;
  end;
 // GenerarCodigo;
end;

procedure TPlanoAltaFrm.GenerarCodigo;
var
  P: TPlano;
begin
  P:= TPlano.Create;
  if TSistema.GetInstance.PlanoDB.GenerarPlano(P) then
  begin
    lblCodigo.Enabled:= True;
    lblDescripcion.Enabled:= True;
    lblUbicacion.Enabled:= True;
    edtCodigo.Enabled:= True;
    edtDescripcion.Enabled:= True;
    edtUbicacion.Enabled:= True;
    btnDir.Enabled:= True;
    btnConfirmar.Enabled:= True;
    btnLimpiar.Enabled:= True;

    edtCodigo.Text:= P.Codigo;
    edtDescripcion.Text:= '';
    edtUbicacion.Text:= '';
    edtDescripcion.SetFocus;
  end
  else
  begin
    ShowMessage('Se detectó un problema, por favor vuelva a intentar de dar de alta el nuevo plano ingresando nuevamente a la pantalla');
    btnVolver.Click;
  end;

  P.Free;
end;

procedure TPlanoAltaFrm.btnConfirmarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Da de alta el plano en la base de datos'
end;

procedure TPlanoAltaFrm.btnLimpiarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TPlanoAltaFrm.btnVolverEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TPlanoAltaFrm.edtDescripcionEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese una breve descripción del plano';
end;

procedure TPlanoAltaFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TPlanoAltaFrm.edtUbicacionEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese la ubicación del archivo con el plano';
end;

procedure TPlanoAltaFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el plano:',
      CSIDL_NETWORK, edtUbicacion.Text);
  if sDir <> '' then
    edtUbicacion.Text:= sDir;

end;

procedure TPlanoAltaFrm.btnDirEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione la carpeta donde se encuentra el plano';

end;
procedure TPlanoAltaFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
   self.btnVolverClick(Sender);
  end;
end;
end.
