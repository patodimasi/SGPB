unit UInstructivosProdAprobarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, UOperacion, UPantallaFrm, DB, ADODB;

type
  TInstructivosProdAprobarFrm = class(TPantallaFrm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbInstructivosProd: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

  protected
    FOperacion: TOperacion;
    procedure LockScreen;
    procedure UnLockScreen;

  published
    property Operacion: TOperacion read FOperacion write FOperacion;

  end;

var
  InstructivosProdAprobarFrm: TInstructivosProdAprobarFrm;

implementation
uses
  UInstructivo, USistema, UAprobar, URecibir, UModificacion, UInstructivoDB, UUtiles, shlobj;

{$R *.dfm}

procedure TInstructivosProdAprobarFrm.LockScreen;
begin
  lblCodigo.Enabled:= False;
  edtCodigo.Enabled:= False;
  edtCodigo.Text:= '';
  lblDescripcion.Enabled:= False;
  edtDescripcion.Enabled:= False;
  edtDescripcion.Text:= '';
  lblUbicacion.Enabled:= False;
  edtUbicacion.Enabled:= False;
  edtUbicacion.Text:= '';
  btnDir.Enabled:= False;
  btnBuscar.Visible:= False;
  btnConfirmar.Visible:= False;
  btnLimpiar.Visible:= False;
  btnVolver.SetFocus;
end;

procedure TInstructivosProdAprobarFrm.UnLockScreen;
begin
  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
  lblDescripcion.Enabled:= True;
  edtDescripcion.Enabled:= True;
  lblUbicacion.Enabled:= True;
  edtUbicacion.Enabled:= True;
  btnDir.Enabled:= True;
  btnBuscar.Visible:= True;
  btnConfirmar.Visible:= True;
  btnLimpiar.Visible:= True;
end;

procedure TInstructivosProdAprobarFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
  self.btnBuscar.Enabled:= True;
  self.edtDescripcion.Enabled:= False;
  self.edtDescripcion.Text:= '';
  self.edtDescripcion.TabStop:= False;
  self.edtUbicacion.Enabled:= False;
  self.edtUbicacion.Text:= '';
  self.edtUbicacion.TabStop:= False;
  self.btnDir.Enabled:= False;
  self.btnConfirmar.Enabled:= False;
  self.edtCodigo.SetFocus;
end;

procedure TInstructivosProdAprobarFrm.btnBuscarClick(Sender: TObject);
var
  Instructivo: TInstructivo;
  Ret: Boolean;

begin
  Ret:= False;
  if edtCodigo.Text = '' then
  begin
    edtCodigo.Color:= clYellow;
    if Operacion is TAprobar then
      ShowMessage('Debe ingresar el código correspondiente al Instructivo de Producción que desea aprobar')
    else if Operacion is TRecibir then
      ShowMessage('Debe ingresar el código correspondiente al Instructivo de Producción que desea recibir')
    else if Operacion is TModificacion then
      ShowMessage('Debe ingresar el código correspondiente al Instructivo de Producción que desea modificar');

    edtCodigo.Color:= clWindow;
    edtCodigo.SetFocus;
  end
  else
  begin
    edtCodigo.Text:= UpperCase(edtCodigo.Text);
    Instructivo:= TInstructivo.Create;
    Instructivo.Codigo:= edtCodigo.Text;

    if Operacion is TAprobar then
      Ret:= TSistema.GetInstance.InstructivoDB.GetInstructivo(Instructivo,PLN_EST_PEND_APR)
    else if Operacion is TRecibir then
      Ret:= TSistema.GetInstance.InstructivoDB.GetInstructivo(Instructivo,PLN_EST_PEND_REC)
    else if Operacion is TModificacion then
      Ret:= TSistema.GetInstance.InstructivoDB.GetInstructivo(Instructivo, PLN_EST_TODOS);
    if Ret then
    begin
      edtDescripcion.Text:= Instructivo.Descripcion;
      edtUbicacion.Text:= Instructivo.Ubicacion;
      btnConfirmar.Enabled:= True;
      edtCodigo.Enabled:= False;
      btnBuscar.Enabled:= False;

      if Operacion is TModificacion then
      begin
        edtDescripcion.Enabled:= True;
        edtDescripcion.TabStop:= True;
        edtUbicacion.Enabled:= True;
        edtUbicacion.TabStop:= True;
        btnDir.Enabled:= True;
        edtDescripcion.SetFocus;
      end
      else
        btnConfirmar.SetFocus;
    end
    else
    begin
      edtCodigo.Color:= clYellow;
      if Operacion is TAprobar then
        ShowMessage('El código que ingresó no corresponde a ningún Instructivo de Producción existente pendiente de aprobación en la base de datos')
      else if Operacion is TRecibir then
        ShowMessage('El código que ingresó no corresponde a ningún Instructivo de Producción existente pendiente de recepción en la base de datos')
      else if Operacion is TModificacion then
        ShowMessage('El código que ingresó no corresponde a ningún Instructivo de Producción existente en la base de datos');

      edtCodigo.Color:= clWindow;
      edtCodigo.SetFocus;
    end;
    Instructivo.Free;
  end;
end;

procedure TInstructivosProdAprobarFrm.btnVolverClick(Sender: TObject);
begin
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TInstructivosProdAprobarFrm.btnConfirmarClick(Sender: TObject);
var
  Instructivo: TInstructivo;
  CodRet: Integer;

begin
  CodRet:= 0;

  if Operacion is TAprobar then
    CodRet:= MessageDlg('¿ Esta seguro que desea aprobar el Instructivo de Producción ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TRecibir then
    CodRet:= MessageDlg('¿ Esta seguro que desea recibir el Instructivo de Producción ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TModificacion then
    CodRet:= MessageDlg('¿ Esta seguro que desea modificar el Instructivo de Producción ?', mtConfirmation, mbOKCancel, 0);

  if CodRet = mrOK then
  begin
    Instructivo:= TInstructivo.Create;

    Instructivo.Codigo:= edtCodigo.Text;

    if Operacion is TAprobar then
    begin
      CodRet:= TSistema.GetInstance.InstructivoDB.Aprobar(Instructivo);
      if CodRet = PLN_APR_OK then
      begin
        ShowMessage('El Instructivo de Producción ' + Instructivo.Codigo + ' se aprobó satisfactoriamente');
        Instructivo.Free;
        if MessageDlg('¿ Desea aprobar otro Instructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then

          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El Instructivo de Producción ' + Instructivo.Codigo + ' no se pudo aprobar');
    end
    else if Operacion is TRecibir then
    begin
      CodRet:= TSistema.GetInstance.InstructivoDB.Recibir(Instructivo);
      if CodRet = PLN_REC_OK then
      begin
        ShowMessage('El Instructivo ' + Instructivo.Codigo + ' se recibió satisfactoriamente');
        Instructivo.Free;

        if MessageDlg('¿ Desea recibir otro Instructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El Instructivo de Producción ' + Instructivo.Codigo + ' no se pudo recibir');
    end
    else if Operacion is TModificacion then
    begin
      Instructivo.Descripcion:= edtDescripcion.Text;
      Instructivo.Ubicacion:= edtUbicacion.Text;
      CodRet:= TSistema.GetInstance.InstructivoDB.Modificacion(Instructivo);
      if CodRet = PLN_MODIF_OK then
      begin
        ShowMessage('El Instructivo de Producción ' + Instructivo.Codigo + ' se modificó satisfactoriamente');
        Instructivo.Free;

        if MessageDlg('¿ Desea modificar otro Instructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El Instructivo de Producción ' + Instructivo.Codigo + ' no se pudo modificar');
    end;

  end;
end;

procedure TInstructivosProdAprobarFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_DRIVES, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;
end;

procedure TInstructivosProdAprobarFrm.edtCodigoEnter(Sender: TObject);
begin
  if Operacion is TAprobar then
    stbInstructivosProd.SimpleText:= 'Ingrese el código del Instructivo de Producción'
  else if Operacion is TRecibir then
    stbInstructivosProd.SimpleText:= 'Ingrese el código del Instructivo de Producción'
  else if Operacion is TModificacion then
    stbInstructivosProd.SimpleText:= 'Ingrese el código del Instructivo de Producción';
end;

procedure TInstructivosProdAprobarFrm.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Ord(Key) = 13 then
    self.btnBuscar.Click;
end;

procedure TInstructivosProdAprobarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Busca el código del Instructivo de Instructivo de Producción ingresado en la base de datos';
end;

procedure TInstructivosProdAprobarFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Ingrese la ubicación del Instructivo de Producción';
end;

procedure TInstructivosProdAprobarFrm.btnDirEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Seleccione la carpeta donde se encuentra el Instructivo de Producción';
end;

procedure TInstructivosProdAprobarFrm.btnConfirmarEnter(Sender: TObject);
begin
  if Operacion is TAprobar then
    stbInstructivosProd.SimpleText:= 'Aprueba el Instructivo de Producción especificado'
  else if Operacion is TRecibir then
    stbInstructivosProd.SimpleText:= 'Recibe el Instructivo de Producción especificado'
  else if Operacion is TModificacion then
    stbInstructivosProd.SimpleText:= 'Modifica el Instructivo de Producción especificado';
end;

procedure TInstructivosProdAprobarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TInstructivosProdAprobarFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TInstructivosProdAprobarFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   btnVolver.Click;
end;

procedure TInstructivosProdAprobarFrm.FormShow(Sender: TObject);
begin
  edtCodigo.Enabled:= True;
  edtCodigo.Text:= '';
  btnBuscar.Enabled:= True;
  edtDescripcion.Enabled:= False;
  edtDescripcion.Text:= '';
  edtDescripcion.TabStop:= False;
  btnDir.Enabled:= False;
  btnConfirmar.Enabled:= False;
  edtUbicacion.Enabled:= False;
  edtUbicacion.Text:= '';
  edtUbicacion.TabStop:= False;
  edtCodigo.SetFocus;

  if Operacion is TAprobar then
  begin
    InstructivosProdAprobarFrm.Caption:= 'Aprobar Instructivo de Producción';
  end
  else if Operacion is TRecibir then
  begin
    InstructivosProdAprobarFrm.Caption:= 'Recibir Instructivo de Producción';
  end
  else if Operacion is TModificacion then
  begin
    InstructivosProdAprobarFrm.Caption:= 'Modificar Instructivo de Producción';
  end;
end;

end.
