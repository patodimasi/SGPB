unit UManualSuperarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UManuales, UMotorSql, DB, ADODB,UPantallaFrm;

type
  TManualSuperarFrm = class(TPantallaFrm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblNroRev: TLabel;
    edtNroRev: TEdit;
    lblNroEdic: TLabel;
    edtNroEdic: TEdit;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblFechaAlta: TLabel;
    edtFechaAlta: TEdit;
    lblUAlta: TLabel;
    edtUAlta: TEdit;
    GroupBox1: TGroupBox;
    lblNroRev2: TLabel;
    edtNroRev2: TEdit;
    lblFechaSup2: TLabel;
    edtFechaSup2: TEdit;
    lblDescripcion2: TLabel;
    edtDescripcion2: TEdit;
    stbManual: TStatusBar;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    lblFechaApr: TLabel;
    edtFechaApr: TEdit;
    lblUApr: TLabel;
    edtUApr: TEdit;
    ADODataSet1: TADODataSet;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure edtDescripcion2Enter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
  //  procedure FormShow(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);


  private
    FManuales: TManuales;
    procedure Limpiar;
    procedure LockScreen;
    procedure UnLockScreen;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManualSuperarFrm: TManualSuperarFrm;

implementation
uses
  USistema, UManualDB;

{$R *.dfm}
procedure TmanualSuperarFrm.LockScreen;
begin
  self.lblCodigo.Enabled:= False;
  self.edtCodigo.Enabled:= False;
  self.lblDescripcion.Enabled:= False;
  self.lblDescripcion2.Enabled:= False;
  self.lblNroRev.Enabled:= False;
  self.lblNroRev2.Enabled:= False;
  self.lblNroEdic.Enabled:= False;
  self.lblFechaAlta.Enabled:= False;
  self.lblFechaApr.Enabled:= False;
  self.lblUAlta.Enabled:= False;
  self.lblUApr.Enabled:= False;
  self.GroupBox1.Enabled:= False;
  self.btnBuscar.Visible:= False;
  self.btnConfirmar.Visible:= False;
  self.btnLimpiar.Visible:= False;
  self.btnVolver.SetFocus;
end;
procedure TmanualSuperarFrm.UnLockScreen;
begin
  self.lblCodigo.Enabled:= True;
  self.edtCodigo.Enabled:= True;
  self.lblDescripcion.Enabled:= True;
  self.lblDescripcion2.Enabled:= True;
  self.edtDescripcion2.Enabled:= True;
  self.lblNroRev.Enabled:= True;
  self.lblNroRev2.Enabled:= True;
  self.lblNroEdic.Enabled:= True;
  self.lblFechaAlta.Enabled:= True;
  self.lblFechaApr.Enabled:= True;
  self.lblUAlta.Enabled:= True;
  self.lblUApr.Enabled:= True;
  self.GroupBox1.Enabled:= True;
  self.lblFechaSup2.Enabled:= True;
  self.btnConfirmar.Visible:= True;
  self.btnLimpiar.Visible:= True;

end;

procedure TManualSuperarFrm.btnVolverClick(Sender: TObject);
begin
  if not FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_MANUALES_RECIBIR);
    TSistema.GetInstance.UnLockScreen(SCR_MANUALES_SUPERAR);
    TSistema.GetInstance.UnLockScreen(SCR_MANUALES_BAJA);
    TSistema.GetInstance.UnLockScreen(SCR_MANUALES_MODIFICAR);
  end
  else
  begin
    UnLockScreen;
    FLocked:= False;
  end;
  if Assigned(FManuales) then
  begin
    FManuales.Free;
    FManuales:= nil;
  end;
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TManualSuperarFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TManualSuperarFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    btnVolver.Click;
end;

procedure TManualSuperarFrm.btnLimpiarClick(Sender: TObject);
begin
 Limpiar;

end;

procedure TManualSuperarFrm.Limpiar;
begin
  if Assigned(FManuales) then
  begin
    FManuales.Free;
    FManuales:= nil;
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
  self.Edit1.Text:= '';
  self.Edit2.Text:= '';
  edtDescripcion2.Enabled:= False;

  btnBuscar.Enabled:= True;
  btnConfirmar.Enabled:= False;
  edtCodigo.SetFocus;

end;

procedure TManualSuperarFrm.btnBuscarClick(Sender: TObject);
begin

  if edtCodigo.Text = '' then
  begin
    edtCodigo.Color:= clYellow;
    ShowMessage('Debe ingresar el código correspondiente al manual que desea superar');
    edtCodigo.Color:= clWindow;
    edtCodigo.SetFocus;
  end
  else
  begin
    edtCodigo.Text:= UpperCase(edtCodigo.Text);

    FManuales:= TManuales.Create;
    FManuales.CodigoM:= edtCodigo.Text;

    if TSistema.GetInstance.ManualDB.GetManual(FManuales,PLN_EST_SUPERABLE) then
    begin
      edtDescripcion.Text:= FManuales.DescripcionM;
      edtNroRev.Text:= IntToStr(FManuales.RevisionM);
      edtNroEdic.Text:= IntToStr(FManuales.EdicionM);
      edtFechaAlta.Text:= FManuales.FechaM;
      edtUAlta.Text:= FManuales.UsuarioAltaM;
      edtFechaApr.Text:= FManuales.FechaAprobacionM;
      edtUApr.Text:= FManuales.UsuarioAprobacionM;
      edtNroRev2.Text:= IntToStr(FManuales.RevisionM + 1);
      edtFechaSup2.Text:= DateToStr(Date);
      btnConfirmar.Enabled:= True;
      edtCodigo.Enabled:= False;
      btnBuscar.Enabled:= False;
      /////////////////////
      self.edtNroRev.Enabled:= false;
      self.edtNroEdic.Enabled:= false;
      self.edtDescripcion.Enabled:= False;
      self.edtFechaAlta.Enabled:= false;
      self.edtUAlta.Enabled:= False;
      self.edtUApr.Enabled:= False;
      self.edtFechaApr.Enabled:= False;
      self.edtNroRev2.Enabled:= False;
      self.edtFechaSup2.Enabled:= False;
      self.Edit1.Enabled:= False;
      self.Edit2.Enabled:= False;

      /////////////////
      edtDescripcion2.Enabled:= True;
      edtDescripcion2.TabStop:= True;
      edtDescripcion2.Text:= edtDescripcion.Text;
      edtDescripcion2.SetFocus;
      self.Edit1.Text:= FManuales.FechaRecepcionM;
      self.Edit2.Text:= FManuales.UsuarioRecepcionM;
      self.Edit1.Enabled:= False;
      self.Edit2.Enabled:= False;
      
    end
    else
    begin
      edtCodigo.Color:= clYellow;
      ShowMessage('El código que ingresó no corresponde a un manual en condiciones de ser superado');
      edtCodigo.Color:= clWindow;
      edtCodigo.SetFocus;
    end;
  end;

end;

procedure TManualSuperarFrm.FormShow(Sender: TObject);
var
  L: Boolean;
begin
  L:= False;
  if PantallaLockeada(SCR_MANUALES_RECIBIR) then
    L:= True
  else if PantallaLockeada(SCR_MANUALES_SUPERAR) then
    L:= True
  else if PantallaLockeada(SCR_MANUALES_BAJA) then
    L:= True
  else if PantallaLockeada(SCR_MANUALES_MODIFICAR) then
    L:= True;

  if L then
    LockScreen
  else
  begin
    FLocked:= False;
    Limpiar;
  end;
end;

procedure TManualSuperarFrm.btnConfirmarClick(Sender: TObject);
var
  ManualNuevo: TManuales;
  CodRet: Integer;
  usuarionuevo: string;
begin
  if MessageDlg('¿ Esta seguro que desea superar el manual ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    FManuales.UsuarioCreacionM:= TSistema.GetInstance.GetUsuario.Logon;
    FManuales.FechaCreacionM:= DateToStr(Date);
    FManuales.UsuarioModifM:= '';
    FManuales.FechaModifM:= '';
    usuarionuevo:= TSistema.getInstance.getUsuario.Logon;

    ManualNuevo:= TManuales.Create;
    ManualNuevo.Copiar(FManuales);
    with ManualNuevo do
    begin
      DescripcionM:= edtDescripcion2.Text;
      RevisionM:= StrToInt(edtNroRev2.Text);
      FechaM:= DateToStr(Date);
      EstadoM:= PLN_EST_PEND_APR;
      UsuarioAprobacionM:= '';
      FechaAprobacionM:= '';
      UsuarioRecepcionM:= '';
      FechaRecepcionM:= '';
      UsuarioAltaM:= usuarionuevo;
    end;
     CodRet:= TSistema.GetInstance.ManualDB.Superar(FManuales, ManualNuevo);
    if CodRet = PLN_SUPERAR_OK then
    begin
      ShowMessage('El manual ' + FManuales.CodigoM + ' se superó satisfactoriamente');
      ManualNuevo.Free;

      if MessageDlg('¿ Desea superar otro manual ?', mtConfirmation, mbOKCancel, 0) = mrOK then
        btnLimpiar.Click
      else
        btnVolver.Click;
    end
    else
      ShowMessage('El manual ' + FManuales.CodigoM + ' no se pudo superar');
  end;
end;

procedure TManualSuperarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TManualSuperarFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Supera el Manual';
end;

procedure TManualSuperarFrm.edtDescripcion2Enter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Ingrese la descripción de la nueva revisión del Manual';
end;

procedure TManualSuperarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Busca el código del Manual a Superar';
end;

{procedure TManualSuperarFrm.FormShow(Sender: TObject);
begin
  if self.PantallaLockeada(SCR_MANUALES_SUPERAR) then
  begin
    self.LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_MANUALES_SUPERAR,SCR_MANUALES_SUPERAR);
    self.FLocked:= False;
  end;
   self.btnConfirmar.Enabled:= False;
end;}

procedure TManualSuperarFrm.edtCodigoEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Ingrese el código del Manual a superar';
end;

procedure TManualSuperarFrm.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
    btnBuscar.Click;
end;

end.
