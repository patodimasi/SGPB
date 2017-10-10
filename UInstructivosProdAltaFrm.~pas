unit UInstructivosProdAltaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UPantallaFrm,UMotorSQL;

type
  TInstructivosMaterialesAltaFrm = class(TPantallaFrm)
    lblCodigodv: TLabel;
    edtCodigodv: TEdit;
    lblDescripciondv: TLabel;
    edtDescripciondv: TEdit;
    lblUbicaciondv: TLabel;
    edtUbicaciondv: TEdit;
    btnDirdv: TButton;
    btnConfirmardv: TButton;
    btnLimpiardv: TButton;
    btnVolverdv: TButton;
    StatusBar1: TStatusBar;
    procedure btnVolverdvClick(Sender: TObject);
    procedure btnLimpiardvClick(Sender: TObject);
    procedure btnDirdvClick(Sender: TObject);
    procedure edtDescripciondvEnter(Sender: TObject);
    procedure edtUbicaciondvEnter(Sender: TObject);
    procedure btnDirdvEnter(Sender: TObject);
    procedure btnConfirmardvEnter(Sender: TObject);
    procedure btnLimpiardvEnter(Sender: TObject);
    procedure btnVolverdvEnter(Sender: TObject);
    procedure btnConfirmardvClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    procedure GenerarCodigo;
    procedure LockScreen;
    procedure UnLockScreen;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  InstructivosMaterialesAltaFrm: TInstructivosMaterialesAltaFrm;

implementation

uses
  UInstructivo, USistema, UInstructivoDB, UUtiles, shlobj;

{$R *.dfm}

procedure TInstructivosMaterialesAltaFrm.LockScreen;
begin
  self.lblCodigodv.Enabled:= False;
  self.edtCodigodv.Enabled:= False;
  self.edtCodigodv.Text:= '';
  self.lblDescripciondv.Enabled:= False;
  self.edtDescripciondv.Enabled:= False;
  self.lblUbicaciondv.Enabled:= False;
  self.edtUbicaciondv.Enabled:= False;
  self.btnDirdv.Enabled:= False;
  self.btnConfirmardv.Visible:= False;
  self.btnLimpiardv.Visible:= False;
  self.btnVolverdv.SetFocus;
end;

procedure TInstructivosMaterialesAltaFrm.UnLockScreen;
begin
  self.lblCodigodv.Enabled:= True;
  self.edtCodigodv.Enabled:= True;
  self.lblDescripciondv.Enabled:= True;
  self.edtDescripciondv.Enabled:= True;
  self.lblUbicaciondv.Enabled:= True;
  self.edtUbicaciondv.Enabled:= True;
  self.btnDirdv.Enabled:= True;
  self.btnConfirmardv.Visible:= True;
  self.btnLimpiardv.Visible:= True;

end;

procedure TInstructivosMaterialesAltaFrm.btnVolverdvClick(Sender: TObject);
begin
  if not self.FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_INSTRUCTIVOSPROD_ALTA);
  end
  else
  begin
    self.UnLockScreen;
    self.FLocked:= False;
  end;
    self.MainForm.Enabled:= True;
    self.MainForm.Enabled:= True;
    self.MainForm.Show;
    Hide;
    self.MainForm:= nil;
end;

procedure TInstructivosMaterialesAltaFrm.btnLimpiardvClick(Sender: TObject);
begin
  self.edtDescripciondv.Text:= '';
  self.edtUbicaciondv.Text:= '';
  self.edtDescripciondv.SetFocus;
end;

procedure TInstructivosMaterialesAltaFrm.btnDirdvClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, self.edtUbicaciondv.Text);
  if sDir <> '' then
     self.edtUbicaciondv.Text:= sDir;
end;

procedure TInstructivosMaterialesAltaFrm.GenerarCodigo;
var
  I: TInstructivo;
begin
  I:= TInstructivo.Create;
  if TSistema.GetInstance.InstructivoDB.GenerarInstructivo(I) then
  begin
    lblCodigodv.Enabled:= True;
    lblDescripciondv.Enabled:= True;
    lblUbicaciondv.Enabled:= True;
    edtCodigodv.Enabled:= True;
    edtDescripciondv.Enabled:= True;
    edtUbicaciondv.Enabled:= True;
    btnDirdv.Enabled:= True;
    btnConfirmardv.Enabled:= True;
    btnLimpiardv.Enabled:= True;

    edtCodigodv.Text:= I.Codigo;
    edtDescripciondv.Text:= '';
    edtUbicaciondv.Text:= '';
    edtDescripciondv.SetFocus;
  end
  else
  begin
    ShowMessage('Se detectó un problema, por favor vuelva a intentar de dar de alta el nuevo Instructivo de Producción ingresando nuevamente a la pantalla');
    btnVolverdv.Click;
  end;

  I.Free;
end;

procedure TInstructivosMaterialesAltaFrm.edtDescripciondvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Ingrese una breve descripción del Instructivo de Producción';
end;

procedure TInstructivosMaterialesAltaFrm.edtUbicaciondvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Ingrese la ubicación del archivo con el Instructivo de Producción';
end;

procedure TInstructivosMaterialesAltaFrm.btnDirdvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Seleccione la carpeta donde se encuentra el Instructivo de Producción';
end;

procedure TInstructivosMaterialesAltaFrm.btnConfirmardvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Da de Alta el Instructivo de Producción en la base de datos';
end;

procedure TInstructivosMaterialesAltaFrm.btnLimpiardvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TInstructivosMaterialesAltaFrm.btnVolverdvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TInstructivosMaterialesAltaFrm.btnConfirmardvClick(
  Sender: TObject);
var
  Instructivo: TInstructivo;
  CodRet: Integer;

begin
  if MessageDlg('¿ Esta seguro que desea dar de alta el Instructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    Instructivo:= TInstructivo.Create;

    with Instructivo do
    begin
      Codigo:= edtCodigodv.Text;
      Descripcion:= edtDescripciondv.Text;
      Revision:= 0;
      Edicion:= 0;
      Fecha:= DateToStr(Date);
      Estado:= PLN_EST_PEND_APR;
      UsuarioAlta:= TSistema.GetInstance.GetUsuario.Logon;
      UsuarioAprobacion:= '';
      FechaAprobacion:= '';
      UsuarioRecepcion:= '';
      FechaRecepcion:= '';
      Ubicacion:= edtUbicaciondv.Text;
      Superado:= 'NS';
      UsuarioCreacion:= TSistema.GetInstance.GetUsuario.Logon;
      FechaCreacion:= DateToStr(Date);
      UsuarioModif:= '';
      FechaModif:= '';

    end;
    CodRet:= TSistema.GetInstance.InstructivoDB.Alta(Instructivo,TAB_INSTRUCTIVO,'NS');
    if CodRet = PLN_ALTA_OK then
    begin
      ShowMessage('El Instructivo de Producción ' + Instructivo.Codigo + ' se dió de alta satisfactoriamente');
      Instructivo.Free;
      btnLimpiardv.Click;

      if MessageDlg('¿ Desea dar de alta otro Instructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
        GenerarCodigo
      else
        btnVolverdv.Click;
    end
    else
      ShowMessage('El Instructivo de Producción ' + Instructivo.Codigo + ' no se pudo dar de alta');
  end;
end;

procedure TInstructivosMaterialesAltaFrm.FormShow(Sender: TObject);
begin
 if PantallaLockeada(SCR_PLANO_ALTA) then
  begin
    LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_INSTRUCTIVOSPROD_ALTA, SCR_INSTRUCTIVOSPROD_ALTA);
    FLocked:= False;
    GenerarCodigo;
  end;

end;

procedure TInstructivosMaterialesAltaFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolverdv.Click;
end;

end.

