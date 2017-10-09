unit USubinstructivosProdSuperarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, USubinstructivo, UPantallaFrm, DB, ADODB;

type
  TSubinstructivosProdSuperarFrm = class(TForm)
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
    lblFechaApr: TLabel;
    edtFechaApr: TEdit;
    lblUApr: TLabel;
    edtUApr: TEdit;
    gbNueva: TGroupBox;
    lblNroRev2: TLabel;
    edtNroRev2: TEdit;
    lblFechaSup2: TLabel;
    edtFechaSup2: TEdit;
    lblDescripcion2: TLabel;
    edtDescripcion2: TEdit;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbSubinstructivosProd: TStatusBar;
    ADODataSet1: TADODataSet;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure btnVolverClick(Sender: TObject);
   // procedure btnBuscarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
  //  procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtDescripcion2Enter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
  private
    FSubinstructivo: TSubinstructivo;
    procedure Limpiar;
    //procedure LockScreen;
    //procedure UnLockScreen;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SubinstructivosProdSuperarFrm: TSubinstructivosProdSuperarFrm;

implementation
uses
  USistema, USubinstructivoDB;

{$R *.dfm}

procedure TSubinstructivosProdSuperarFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSubinstructivosProdSuperarFrm.Limpiar;
begin
  if Assigned(FSubinstructivo) then
  begin
    FSubinstructivo.Free;
    FSubinstructivo:= nil;
  end;

  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
  edtCodigo.Text:= '';
  edtNroRev.Text:= '';
  edtNroEdic.Text:= '';
  edtDescripcion.Text:= '';
  edtFechaAlta.Text:= '';
  edtFechaApr.Text:= '';
  edtUAlta.Text:= '';
  edtUApr.Text:= '';
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

procedure TSubinstructivosProdSuperarFrm.btnLimpiarClick(Sender: TObject);
begin
  self.Limpiar;
end;

procedure TSubinstructivosProdSuperarFrm.edtCodigoEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Ingrese el código del Documento a superar';
end;

procedure TSubinstructivosProdSuperarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Busca el código del Documento a Superar';
end;

procedure TSubinstructivosProdSuperarFrm.edtDescripcion2Enter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Ingrese la descripción de la nueva revisión del Documento';
end;

procedure TSubinstructivosProdSuperarFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Supera el Documento';
end;

procedure TSubinstructivosProdSuperarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TSubinstructivosProdSuperarFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TSubinstructivosProdSuperarFrm.btnBuscarClick(Sender: TObject);
begin

  if edtCodigo.Text = '' then
  begin
    edtCodigo.Color:= clYellow;
    ShowMessage('Debe ingresar el código correspondiente al Subinstructivo de Producción que desea superar');
    edtCodigo.Color:= clWindow;
    edtCodigo.SetFocus;
  end
  else
  begin
    edtCodigo.Text:= UpperCase(edtCodigo.Text);

    FSubinstructivo:= TSubinstructivo.Create;
    FSubinstructivo.Codigo:= edtCodigo.Text;

      if TSistema.GetInstance.SubinstructivoDB.GetSubinstructivo(FSubinstructivo,PLN_EST_SUPERABLE) then
    begin
      edtDescripcion.Text:= FSubinstructivo.Descripcion;
      edtNroRev.Text:= IntToStr(FSubinstructivo.Revision);
      edtNroEdic.Text:= IntToStr(FSubinstructivo.Edicion);
      edtFechaAlta.Text:= FSubinstructivo.Fecha;
      edtUAlta.Text:= FSubinstructivo.UsuarioAlta;
      edtFechaApr.Text:= FSubinstructivo.FechaAprobacion;
      edtUApr.Text:= FSubinstructivo.UsuarioAprobacion;
      //edtFechaSup.Text:= FPlano.FechaCreacion;
      //edtUSup.Text:= FPlano.UsuarioCreacion;
      edtNroRev2.Text:= IntToStr(FSubinstructivo.Revision + 1);
      edtFechaSup2.Text:= DateToStr(Date);
      btnConfirmar.Enabled:= True;
      edtCodigo.Enabled:= False;
      btnBuscar.Enabled:= False;
      edtDescripcion2.Enabled:= True;
      edtDescripcion2.TabStop:= True;
      edtDescripcion2.Text:= edtDescripcion.Text;
      edtDescripcion2.SetFocus;
      self.Edit1.Text:= FSubinstructivo.FechaRecepcion;
      self.Edit2.Text:= FSubinstructivo.UsuarioRecepcion;
      self.Edit1.Enabled:= False;
      self.Edit2.Enabled:= False;
      self.edtNroRev.Enabled:= False;
      self.edtNroEdic.Enabled:= False;
      self.edtDescripcion.Enabled:= False;
      self.edtUAlta.Enabled:= False;
      self.edtUApr.Enabled:= False;
      self.edtFechaApr.Enabled:= False;
      self.edtFechaAlta.Enabled:= False;

    end
    else
    begin
      edtCodigo.Color:= clYellow;
      ShowMessage('El código que ingresó no corresponde a un Subinstructivo de Producción en condiciones de ser superado');
      edtCodigo.Color:= clWindow;
      edtCodigo.SetFocus;
    end;
  end;

end;

procedure TSubinstructivosProdSuperarFrm.btnConfirmarClick(
  Sender: TObject);
var
  SubNuevo: TSubinstructivo;
  CodRet: Integer;
  usuarionuevo: string;
begin
  if MessageDlg('¿ Esta seguro que desea superar el Subinstructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    FSubinstructivo.UsuarioCreacion:= TSistema.GetInstance.GetUsuario.Logon;
    FSubinstructivo.FechaCreacion:= DateToStr(Date);
    FSubinstructivo.UsuarioModif:= '';
    FSubinstructivo.FechaModif:= '';
    usuarionuevo:= TSistema.getInstance.getUsuario.Logon;

    SubNuevo:= TSubinstructivo.Create;
    SubNuevo.Copiar(FSubinstructivo);
    with SubNuevo do
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
    CodRet:= TSistema.GetInstance.SubinstructivoDB.Superar(FSubinstructivo,SubNuevo);
    if CodRet = PLN_SUPERAR_OK then
    begin
      ShowMessage('El Subinstructivo de Producción ' + FSubinstructivo.Codigo + ' se dió superó satisfactoriamente');
      SubNuevo.Free;

      if MessageDlg('¿ Desea superar otro Subinstructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
        btnLimpiar.Click
      else
        btnVolver.Click;
    end
    else
      ShowMessage('El Subinstructivo de Producción ' + FSubinstructivo.Codigo + ' no se pudo superar');
  end;
end;

procedure TSubinstructivosProdSuperarFrm.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
  btnBuscar.Click;
end;

end.
