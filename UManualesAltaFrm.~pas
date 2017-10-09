unit UManualesAltaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls , UMotorSql, ADODB, UPantallaFrm;


type
  TManualesAltaFrm = class(TPantallaFrm)
    lblCodigom: TLabel;
    edtCodigom: TEdit;
    lblDescripcionm: TLabel;
    edtDescripcionm: TEdit;
    lblUbicacionm: TLabel;
    edtUbicacionm: TEdit;
    btnDirm: TButton;
    btnConfirmarm: TButton;
    btnLimpiar: TButton;
    btnVolverm: TButton;
    StbManuales: TStatusBar;
    procedure btnVolvermEnter(Sender: TObject);
    procedure btnVolvermClick(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    //procedure FormShow(Sender: TObject);
    procedure btnConfirmarmEnter(Sender: TObject);
    procedure btnConfirmarmClick(Sender: TObject);
    procedure btnDirmEnter(Sender: TObject);
    procedure btnDirmClick(Sender: TObject);
    procedure edtDescripcionmEnter(Sender: TObject);
    procedure edtUbicacionmEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LockScreen;
    procedure UnLockScreen;
    procedure GenerarCodigo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManualesAltaFrm: TManualesAltaFrm;

implementation
uses
  UManuales, USistema, UManualDB, UUtiles, shlobj;

{$R *.dfm}
procedure TManualesAltaFrm.LockScreen;
begin
  self.lblCodigom.Enabled:= False;
  self.edtCodigom.Enabled:= False;
  self.edtCodigom.Text:= '';
  self.lblDescripcionm.Enabled:= False;
  self.edtDescripcionm.Enabled:= False;
  self.lblUbicacionm.Enabled:= False;
  self.edtUbicacionm.Enabled:= False;
  self.btnDirm.Enabled:= False;
  self.btnConfirmarm.Enabled:= False;
  self.btnLimpiar.Visible:= False;
  self.btnVolverm.SetFocus;
end;

procedure TmanualesAltaFrm.UnLockScreen;
begin
  self.lblCodigom.Enabled:= True;
  self.edtCodigom.Enabled:= True;
  self.lblDescripcionm.Enabled:= True;
  self.edtDescripcionm.Enabled:= True;
  self.lblUbicacionm.Enabled:= True;
  self.edtUbicacionm.Enabled:= True;
  self.btnDirm.Enabled:= True;
  self.btnConfirmarm.Visible:= True;
  self.btnLimpiar.Visible:= True;
end;

procedure TManualesAltaFrm.btnVolvermEnter(Sender: TObject);
begin
  self.StbManuales.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TManualesAltaFrm.btnVolvermClick(Sender: TObject);
begin
 // self.Close;
  if not FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_MANUALES_ALTA);
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

procedure TManualesAltaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StbManuales.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TManualesAltaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtDescripcionm.Text:= '';
  self.edtUbicacionm.Text:= '';
  self.edtDescripcionm.SetFocus; 
end;

procedure TManualesAltaFrm.GenerarCodigo;
var
  M: TManuales;
begin
  M:= TManuales.create;
   if TSistema.GetInstance.ManualDB.GenerarManual(M) then
  begin
    lblCodigom.Enabled:= True;
    lblDescripcionm.Enabled:= True;
    lblUbicacionm.Enabled:= True;
    edtCodigom.Enabled:= True;
    edtDescripcionm.Enabled:= True;
    edtUbicacionm.Enabled:= True;
    btnDirm.Enabled:= True;
    btnConfirmarm.Enabled:= True;
    btnLimpiar.Enabled:= True;

    edtCodigom.Text:= M.Codigom;
    edtDescripcionm.Text:= '';
    edtUbicacionm.Text:= '';
    edtDescripcionm.SetFocus;
  end
  else
  begin
    ShowMessage('Se detectó un problema, por favor vuelva a intentar de dar de alta el nuevo manual ingresando nuevamente a la pantalla');
    btnVolverm.Click;
  end;

  M.Free;
end;

procedure TManualesAltaFrm.btnConfirmarmEnter(Sender: TObject);
begin
  self.StbManuales.SimpleText:= 'Da de Alta el Manual en la base de datos';
end;

procedure TManualesAltaFrm.btnConfirmarmClick(Sender: TObject);
var
  Manual: TManuales;
  CodRet: Integer;

begin
  if MessageDlg('¿ Esta seguro que desea dar de alta el Manual ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    Manual:= TManuales.Create;

    with Manual do
    begin
      Codigom:= edtCodigom.Text;
      Descripcionm:= edtDescripcionm.Text;
      Revisionm:= 0;
      Edicionm:= 0;
      Fecham:= DateToStr(Date);
      Estadom:= PLN_EST_PEND_APR;
      UsuarioAltam:= TSistema.GetInstance.GetUsuario.Logon;
      UsuarioAprobacionm:= '';
      FechaAprobacionm:= '';
      UsuarioRecepcionm:= '';
      FechaRecepcionm:= '';
      Ubicacionm:= edtUbicacionm.Text;
      UsuarioCreacionm:= TSistema.GetInstance.GetUsuario.Logon;
      FechaCreacionm:= DateToStr(Date);
      UsuarioModifm:= '';
      FechaModifm:= '';

    end;
    CodRet:= TSistema.GetInstance.ManualDB.Alta(Manual,TAB_MANUAL);
    if CodRet = PLN_ALTA_OK then
    begin
      ShowMessage('El Manual ' + Manual.CodigoM + ' se dió de alta satisfactoriamente');
      Manual.Free;
      btnLimpiar.Click;

      if MessageDlg('¿ Desea dar de alta otro Manual ?', mtConfirmation, mbOKCancel, 0) = mrOK then
        GenerarCodigo
      else
        btnVolverm.Click;
    end
    else
      ShowMessage('El Manual ' + Manual.CodigoM + ' no se pudo dar de alta');
  end;

end;

procedure TManualesAltaFrm.btnDirmEnter(Sender: TObject);
begin
  self.StbManuales.SimpleText:= 'Seleccione la carpeta donde se encuentra el Manual';
end;

procedure TManualesAltaFrm.btnDirmClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Manual:',
      CSIDL_NETWORK, edtUbicacionm.Text);
  if sDir <> '' then
    edtUbicacionm.Text:= sDir;

end;

procedure TManualesAltaFrm.edtDescripcionmEnter(Sender: TObject);
begin
  self.StbManuales.SimpleText:= 'Ingrese una breve descripción del Manual';
end;

procedure TManualesAltaFrm.edtUbicacionmEnter(Sender: TObject);
begin
  self.StbManuales.SimpleText:= 'Ingrese la ubicación del archivo con el Manual';
end;

procedure TManualesAltaFrm.FormShow(Sender: TObject);
begin
 if PantallaLockeada(SCR_MANUALES_ALTA) then
  begin
    LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_MANUALES_ALTA, SCR_MANUALES_ALTA);
    FLocked:= False;
    GenerarCodigo;
  end;
  //self.GenerarCodigo;
 end;
procedure TManualesAltaFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    btnVolverm.Click;
end;

end.
