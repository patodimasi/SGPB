unit USubinstructivosProdAltaFrm;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, ComCtrls, UPantallaFrm,UMotorSQL, DB, ADODB;

type
  TSubinstructivosProdAltaFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbSubinstructivosProd: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
   // procedure btnConfirmarClick(Sender: TObject);
  //  procedure btnDirClick(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    //procedure LockScreen;
    //procedure UnLockScreen;
    procedure GenerarCodigo;
    { Private declarations }
  public

    { Public declarations }
  end;
var
  SubinstructivosProdAltaFrm: TSubinstructivosProdAltaFrm;

implementation
uses
  USubinstructivo, USistema, USubinstructivoDB, UUtiles, shlobj;
{$R *.dfm}
procedure TSubinstructivosProdAltaFrm.GenerarCodigo;
var
  S: TSubinstructivo;
begin
  S:= TSubinstructivo.Create;
  if TSistema.GetInstance.SubinstructivoDB.GenerarSubinstructivo(S) then
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

    edtCodigo.Text:= S.Codigo;
    edtDescripcion.Text:= '';
    edtUbicacion.Text:= '';
    edtDescripcion.SetFocus;
  end
  else
  begin
    ShowMessage('Se detectó un problema, por favor vuelva a intentar de dar de alta el nuevo Subinstructivo de Producción ingresando nuevamente a la pantalla');
    btnVolver.Click;
  end;

  S.Free;
end;

procedure TSubinstructivosProdAltaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSubinstructivosProdAltaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtDescripcion.Text:= '';
  self.edtUbicacion.Text:= '';
  self.edtDescripcion.SetFocus;
end;
procedure TSubinstructivosProdAltaFrm.FormShow(Sender: TObject);
begin
  GenerarCodigo;
end;

procedure TSubinstructivosProdAltaFrm.edtDescripcionEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:='Ingrese una breve descripción del Subinstructivo de Producción';
end;

procedure TSubinstructivosProdAltaFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Ingrese la ubicación del Subinstructivo de Producción';
end;

procedure TSubinstructivosProdAltaFrm.btnDirEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Seleccione la carpeta donde se encuentra el Subinstructivo de Producción';
end;

procedure TSubinstructivosProdAltaFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Da de Alta el Subinstructivo de Producción en la base de datos';
end;

procedure TSubinstructivosProdAltaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TSubinstructivosProdAltaFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TSubinstructivosProdAltaFrm.btnConfirmarClick(Sender: TObject);
var
  Subinstructivo: TSubinstructivo;
  CodRet: Integer;

begin
  if MessageDlg('¿ Esta seguro que desea dar de alta el Subinstructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    Subinstructivo:= TSubinstructivo.Create;

    with Subinstructivo do
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
    
    CodRet:= TSistema.GetInstance.SubinstructivoDB.Alta(Subinstructivo, TAB_SUBINSTRUCTIVO,'NS');
    if CodRet = PLN_ALTA_OK then
    begin
      ShowMessage('El Subinstructivo de Producción' + Subinstructivo.Codigo + ' se dió de alta satisfactoriamente');
      Subinstructivo.Free;
      btnLimpiar.Click;

      if MessageDlg('¿ Desea dar de alta otro Subinstructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
        GenerarCodigo
      else
        btnVolver.Click;
    end
    else
      ShowMessage('El Subinstructivo de Producción ' + Subinstructivo.Codigo + ' no se pudo dar de alta');
  end;
end;

end.
