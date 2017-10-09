unit USubinstructivosProdAprobarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, UOperacion, UPantallaFrm, DB, ADODB;

type
  TSubinstructivosProdAprobarFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    ADODataSet1: TADODataSet;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbSubinstructivosProd: TStatusBar;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    //procedure btnConfirmarClick(Sender: TObject);
    
   protected
    FOperacion: TOperacion;
  //  procedure LockScreen;
   // procedure UnLockScreen;

  published
    property Operacion: TOperacion read FOperacion write FOperacion;

  end;

var
  SubinstructivosProdAprobarFrm: TSubinstructivosProdAprobarFrm;

implementation
uses
  USubinstructivo, USistema, UAprobar, URecibir, UModificacion, USubinstructivoDB, UUtiles, shlobj;

{$R *.dfm}

procedure TSubinstructivosProdAprobarFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSubinstructivosProdAprobarFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
  self.btnBuscar.Enabled:= True;
  self.edtDescripcion.Enabled:= False;
  self.edtDescripcion.Text:= '';
  self.edtDescripcion.TabStop:= False;
  self.edtUbicacion.Text:= '';
  self.edtUbicacion.TabStop:= False;
  self.edtUbicacion.Enabled:= False;
  self.btnDir.Enabled:= False;
  self.btnConfirmar.Enabled:= False;
  self.edtCodigo.SetFocus;
end;

procedure TSubinstructivosProdAprobarFrm.btnBuscarClick(Sender: TObject);
var
  Subinstructivo: TSubinstructivo;
  Ret: Boolean;

begin
  Ret:= False;
  if edtCodigo.Text = '' then
  begin
    edtCodigo.Color:= clYellow;
    if Operacion is TAprobar then
      ShowMessage('Debe ingresar el código correspondiente al Subinstructivo de Producción que desea aprobar')
    else if Operacion is TRecibir then
      ShowMessage('Debe ingresar el código correspondiente al Subinstructivo de Producción que desea recibir')
    else if Operacion is TModificacion then
      ShowMessage('Debe ingresar el código correspondiente al Subinstructivo de Producción que desea modificar');

    edtCodigo.Color:= clWindow;
    edtCodigo.SetFocus;
  end
  else
  begin
    edtCodigo.Text:= UpperCase(edtCodigo.Text);
    Subinstructivo:= TSubinstructivo.Create;
    Subinstructivo.Codigo:= self.edtCodigo.Text;

    if Operacion is TAprobar then
      Ret:= TSistema.GetInstance.SubinstructivoDB.GetSubinstructivo(Subinstructivo, PLN_EST_PEND_APR)
    else if Operacion is TRecibir then
      Ret:= TSistema.GetInstance.SubinstructivoDB.GetSubinstructivo(Subinstructivo, PLN_EST_PEND_REC)
    else if Operacion is TModificacion then
      Ret:= TSistema.GetInstance.SubinstructivoDB.GetSubinstructivo(Subinstructivo, PLN_EST_TODOS);
    if Ret then
    begin
      edtDescripcion.Text:= Subinstructivo.Descripcion;
      edtUbicacion.Text:= Subinstructivo.Ubicacion;
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
        ShowMessage('El código que ingresó no corresponde a ningún Subinstructivo de Producción existente pendiente de aprobación en la base de datos')
      else if Operacion is TRecibir then
        ShowMessage('El código que ingresó no corresponde a ningún Subinstructivo de Producción existente pendiente de recepción en la base de datos')
      else if Operacion is TModificacion then
        ShowMessage('El código que ingresó no corresponde a ningún Subinstructivo de Producción existente en la base de datos');

      edtCodigo.Color:= clWindow;
      edtCodigo.SetFocus;
    end;
    Subinstructivo.Free;
  end;
end;

procedure TSubinstructivosProdAprobarFrm.edtDescripcionEnter(
  Sender: TObject);
begin
  stbSubinstructivosProd.SimpleText:= 'Ingrese la descripcion del Subinstructivo de Producción';
end;

procedure TSubinstructivosProdAprobarFrm.edtCodigoEnter(Sender: TObject);
begin
   if Operacion is TAprobar then
    stbSubinstructivosProd.SimpleText:= 'Ingrese el código del Subinstructivo de Producción '
  else if Operacion is TRecibir then
    stbSubinstructivosProd.SimpleText:= 'Ingrese el código del Subinstructivo de Producción'
  else if Operacion is TModificacion then
    stbSubinstructivosProd.SimpleText:= 'Ingrese el código del Subinstructivo de Producción';
end;

procedure TSubinstructivosProdAprobarFrm.FormShow(Sender: TObject);
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
     SubinstructivosProdAprobarFrm.Caption:= 'Aprobar Subinstructivo de Producción';
  end
  else if Operacion is TRecibir then
    begin
     SubinstructivosProdAprobarFrm.Caption:= 'Recibir Subinstructivo de Producción';
    end
    else if Operacion is TModificacion then
    begin
      SubinstructivosProdAprobarFrm.Caption:= 'Modificar Subinstructivo de Producción';
    end;
end;

procedure TSubinstructivosProdAprobarFrm.btnConfirmarClick(
  Sender: TObject);
var
  Subinstructivo: TSubinstructivo;
  CodRet: Integer;

begin
  CodRet:= 0;

  if Operacion is TAprobar then
    CodRet:= MessageDlg('¿ Esta seguro que desea aprobar el plano ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TRecibir then
    CodRet:= MessageDlg('¿ Esta seguro que desea recibir el plano ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TModificacion then
    CodRet:= MessageDlg('¿ Esta seguro que desea modificar el plano ?', mtConfirmation, mbOKCancel, 0);

  if CodRet = mrOK then
  begin
    Subinstructivo:= TSubinstructivo.Create;

    Subinstructivo.Codigo:= edtCodigo.Text;

    if Operacion is TAprobar then
    begin
      CodRet:= TSistema.getInstance.SubinstructivoDB.Aprobar(Subinstructivo);
      if CodRet = PLN_APR_OK then
      begin
        ShowMessage('El Subinstructivo de Producción  ' + Subinstructivo.Codigo + ' se aprobó satisfactoriamente');
        Subinstructivo.Free;
        if MessageDlg('¿ Desea aprobar otro Subinstructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then

          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El Subinstructivo de Producción ' + Subinstructivo.Codigo + ' no se pudo aprobar');
    end
    else if Operacion is TRecibir then
    begin
      CodRet:= TSistema.getInstance.SubinstructivoDB.Recibir(Subinstructivo);
      if CodRet = PLN_REC_OK then
      begin
        ShowMessage('El Subinstructivo de Producción ' + Subinstructivo.Codigo + ' se recibió satisfactoriamente');
        Subinstructivo.Free;

        if MessageDlg('¿ Desea recibir otro Subinstructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El Subinstructivo de Producción ' + Subinstructivo.Codigo + ' no se pudo recibir');
    end
    else if Operacion is TModificacion then
    begin
      Subinstructivo.Descripcion:= edtDescripcion.Text;
      Subinstructivo.Ubicacion:= edtUbicacion.Text;

      CodRet:= TSistema.getInstance.SubinstructivoDB.Modificacion(Subinstructivo);
      if CodRet = PLN_MODIF_OK then
      begin
        ShowMessage('El Subinstructivo de Producción ' + Subinstructivo.Codigo + ' se modificó satisfactoriamente');
        Subinstructivo.Free;

        if MessageDlg('¿ Desea modificar otro Subinstructivo de Producción ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El Subinstructivo de Producción ' + Subinstructivo.Codigo + ' no se pudo modificar');
    end;

  end;
end;

procedure TSubinstructivosProdAprobarFrm.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Ord(Key) = 13 then
    btnBuscar.Click;
end;

end.
