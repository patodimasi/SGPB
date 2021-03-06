unit UPlanoSuperarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UPlano, UPantallaFrm;

type
  TPlanoSuperarFrm = class(TPantallaFrm)
    stbPlano: TStatusBar;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    gbNueva: TGroupBox;
    lblCodigo: TLabel;
    lblDescripcion: TLabel;
    edtCodigo: TEdit;
    edtDescripcion: TEdit;
    btnBuscar: TButton;
    lblNroRev: TLabel;
    edtNroRev: TEdit;
    lblNroEdic: TLabel;
    edtNroEdic: TEdit;
    lblFechaAlta: TLabel;
    edtFechaAlta: TEdit;
    lblFechaApr: TLabel;
    edtFechaApr: TEdit;
    edtUAlta: TEdit;
    edtUApr: TEdit;
    lblNroRev2: TLabel;
    edtNroRev2: TEdit;
    lblDescripcion2: TLabel;
    edtDescripcion2: TEdit;
    lblUAlta: TLabel;
    lblUApr: TLabel;
    lblFechaSup2: TLabel;
    edtFechaSup2: TEdit;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure btnVolverClick(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtDescripcion2Enter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
 

  private
    FPlano: TPlano;
    procedure Limpiar;
    procedure LockScreen;
    procedure UnLockScreen;
  end;

var
  PlanoSuperarFrm: TPlanoSuperarFrm;

implementation
uses
  USistema, UPlanoDB;

{$R *.dfm}

procedure TPlanoSuperarFrm.LockScreen;
begin
  lblCodigo.Enabled:= False;
  edtCodigo.Enabled:= False;
  lblDescripcion.Enabled:= False;
  lblDescripcion2.Enabled:= False;
  edtDescripcion2.Enabled:= False;
  lblNroRev.Enabled:= False;
  lblNroRev2.Enabled:= False;
  lblNroEdic.Enabled:= False;
  lblFechaAlta.Enabled:= False;
  lblFechaApr.Enabled:= False;
 // lblFechaSup.Enabled:= False;
  lblUAlta.Enabled:= False;
  lblUApr.Enabled:= False;
 //lblUSup.Enabled:= False;
  gbNueva.Enabled:= False;
  lblFechaSup2.Enabled:= False;
  btnBuscar.Visible:= False;
  btnConfirmar.Visible:= False;
  btnLimpiar.Visible:= False;
  btnVolver.SetFocus;
end;

procedure TPlanoSuperarFrm.UnLockScreen;
begin
  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
  lblDescripcion.Enabled:= True;
  lblDescripcion2.Enabled:= True;
  edtDescripcion2.Enabled:= True;
  lblNroRev.Enabled:= True;
  lblNroRev2.Enabled:= True;
  lblNroEdic.Enabled:= True;
  lblFechaAlta.Enabled:= True;
  lblFechaApr.Enabled:= True;
  //lblFechaSup.Enabled:= True;
  lblUAlta.Enabled:= True;
  lblUApr.Enabled:= True;
 // lblUSup.Enabled:= True;
  gbNueva.Enabled:= True;
  lblFechaSup2.Enabled:= True;
  btnBuscar.Visible:= True;
  btnConfirmar.Visible:= True;
  btnLimpiar.Visible:= True;
end;

procedure TPlanoSuperarFrm.btnVolverClick(Sender: TObject);
begin
  if not FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_RECIBIR);
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_SUPERAR);
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_BAJA);
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_MODIFICAR);
  end
  else
  begin
    UnLockScreen;
    FLocked:= False;
  end;
  if Assigned(FPlano) then
  begin
    FPlano.Free;
    FPlano:= nil;
  end;
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TPlanoSuperarFrm.btnVolverEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TPlanoSuperarFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TPlanoSuperarFrm.btnLimpiarClick(Sender: TObject);
begin
  Limpiar;
end;

procedure TPlanoSuperarFrm.Limpiar;
begin
  if Assigned(FPlano) then
  begin
    FPlano.Free;
    FPlano:= nil;
  end;

  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
  edtCodigo.Text:= '';
  edtNroRev.Text:= '';
  edtNroEdic.Text:= '';
  edtDescripcion.Text:= '';
  edtFechaAlta.Text:= '';
  edtFechaApr.Text:= '';
 // edtFechaSup.Text:= '';
  edtUAlta.Text:= '';
  edtUApr.Text:= '';
 // edtUSup.Text:= '';
  edtNroRev2.Text:= '';
  edtDescripcion2.Text:= '';
  self.edtFechaSup2.Text:= '';
  edtDescripcion2.Enabled:= False;
  self.Edit1.Text:= '';
  self.Edit2.Text:= '';

  btnBuscar.Enabled:= True;
  btnConfirmar.Enabled:= False;
  edtCodigo.SetFocus;

end;

procedure TPlanoSuperarFrm.btnBuscarClick(Sender: TObject);
begin

  if edtCodigo.Text = '' then
  begin
    edtCodigo.Color:= clYellow;
    ShowMessage('Debe ingresar el c�digo correspondiente al plano que desea superar');
    edtCodigo.Color:= clWindow;
    edtCodigo.SetFocus;
  end
  else
  begin
    edtCodigo.Text:= UpperCase(edtCodigo.Text);

    FPlano:= TPlano.Create;
    FPlano.Codigo:= edtCodigo.Text;

    if TSistema.GetInstance.PlanoDB.GetPlano(FPlano, PLN_EST_SUPERABLE) then
    begin
      edtDescripcion.Text:= FPlano.Descripcion;
      edtNroRev.Text:= IntToStr(FPlano.Revision);
      edtNroEdic.Text:= IntToStr(FPlano.Edicion);
      edtFechaAlta.Text:= FPlano.Fecha;
      edtUAlta.Text:= FPlano.UsuarioAlta;
      edtFechaApr.Text:= FPlano.FechaAprobacion;
      edtUApr.Text:= FPlano.UsuarioAprobacion;
      //edtFechaSup.Text:= FPlano.FechaCreacion;
      //edtUSup.Text:= FPlano.UsuarioCreacion;
      edtNroRev2.Text:= IntToStr(FPlano.Revision + 1);
      edtFechaSup2.Text:= DateToStr(Date);
      btnConfirmar.Enabled:= True;
      edtCodigo.Enabled:= False;
      btnBuscar.Enabled:= False;
      edtDescripcion2.Enabled:= True;
      edtDescripcion2.TabStop:= True;
      edtDescripcion2.Text:= edtDescripcion.Text;
      edtDescripcion2.SetFocus;
      self.Edit1.Text:= FPlano.FechaRecepcion;
      self.Edit2.Text:= FPlano.UsuarioRecepcion;
      self.Edit1.Enabled:= False;
      self.Edit2.Enabled:= False;
      
    end
    else
    begin
      edtCodigo.Color:= clYellow;
      ShowMessage('El c�digo que ingres� no corresponde a un plano en condiciones de ser superado');
      edtCodigo.Color:= clWindow;
      edtCodigo.SetFocus;
    end;
  end;

end;

procedure TPlanoSuperarFrm.FormDestroy(Sender: TObject);
begin
  if Assigned(FPlano) then
  begin
    FPlano.Free;
    FPlano:= nil;
  end;
end;

procedure TPlanoSuperarFrm.btnLimpiarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TPlanoSuperarFrm.btnConfirmarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Superar el plano';
end;

procedure TPlanoSuperarFrm.FormShow(Sender: TObject);
var
  L: Boolean;
begin
  L:= False;
  if PantallaLockeada(SCR_PLANO_RECIBIR) then
    L:= True
  else if PantallaLockeada(SCR_PLANO_SUPERAR) then
    L:= True
  else if PantallaLockeada(SCR_PLANO_BAJA) then
    L:= True
  else if PantallaLockeada(SCR_PLANO_MODIFICAR) then
    L:= True;

  if L then
    LockScreen
  else
  begin
    FLocked:= False;
    Limpiar;
  end;
end;

procedure TPlanoSuperarFrm.btnConfirmarClick(Sender: TObject);
var
  PlanoNuevo: TPlano;
  CodRet: Integer;
  usuarionuevo: string;
begin
  if MessageDlg('� Esta seguro que desea superar el plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    FPlano.UsuarioCreacion:= TSistema.GetInstance.GetUsuario.Logon;
    FPlano.FechaCreacion:= DateToStr(Date);
    FPlano.UsuarioModif:= '';
    FPlano.FechaModif:= '';
    usuarionuevo:= TSistema.getInstance.getUsuario.Logon;

    PlanoNuevo:= TPlano.Create;
    PlanoNuevo.Copiar(FPlano);
    with PlanoNuevo do
    begin
      Descripcion:= edtDescripcion2.Text;
      Revision:= StrToInt(edtNroRev2.Text);
      Fecha:= DateToStr(Date);
      Estado:= PLN_EST_PEND_APR;
      UsuarioAprobacion:= '';
      FechaAprobacion:= '';
      UsuarioRecepcion:= '';
      FechaRecepcion:= '';
      UsuarioAlta:= usuarionuevo;
    end;

    CodRet:= TSistema.GetInstance.PlanoDB.Superar(FPlano, PlanoNuevo);
    if CodRet = PLN_SUPERAR_OK then
    begin
      ShowMessage('El plano ' + FPlano.Codigo + ' se super� satisfactoriamente');
      PlanoNuevo.Free;

      if MessageDlg('� Desea superar otro plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then
        btnLimpiar.Click
      else
        btnVolver.Click;
    end
    else
      ShowMessage('El plano ' + FPlano.Codigo + ' no se pudo superar');
  end;
end;

procedure TPlanoSuperarFrm.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
    btnBuscar.Click;
end;

procedure TPlanoSuperarFrm.edtCodigoEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el c�digo de plano a superar';
end;

procedure TPlanoSuperarFrm.edtDescripcion2Enter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese la descripci�n de la nueva revisi�n del plano';
end;

procedure TPlanoSuperarFrm.btnBuscarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Busca el c�digo del plano a superar';

end;

end.
