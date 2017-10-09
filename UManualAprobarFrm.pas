unit UManualAprobarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB,UOperacion, UMotorSql, UUtiles, UPantallaFrm;

type
  TManualAprobarFrm = class(TPantallaFrm)
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
    StbManual: TStatusBar;

    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnDirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);


  protected
    FOperacion: TOperacion;
    procedure LockScreen;
    procedure UnLockScreen;
    
  published
    property Operacion: TOperacion read FOperacion write FOperacion;

  end;

var
  ManualAprobarFrm: TManualAprobarFrm;
  AdoCon: TADOConnection;
  AdoDst: TADODataset;

implementation
  uses
  UManuales, USistema, UAprobar, URecibir, UModificacion, UManualDB, shlobj;
{$R *.dfm}

procedure TManualAprobarFrm.LockScreen;
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

procedure TManualAprobarFrm.UnLockScreen;
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

procedure TManualAprobarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StbManual.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TManualAprobarFrm.btnVolverEnter(Sender: TObject);
begin
  self.StbManual.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TManualAprobarFrm.btnVolverClick(Sender: TObject);
begin
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TManualAprobarFrm.btnLimpiarClick(Sender: TObject);
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

procedure TManualAprobarFrm.btnBuscarClick(Sender: TObject);
var
  Manual: TManuales;
  Ret: Boolean;
  
begin
  Ret:= False;
  if edtCodigo.Text = '' then
  begin
    edtCodigo.Color:= clYellow;
    if Operacion is TAprobar then
      ShowMessage('Debe ingresar el código correspondiente al manual que desea aprobar')
    else if Operacion is TRecibir then
      ShowMessage('Debe ingresar el código correspondiente al manual que desea recibir')
    else if Operacion is TModificacion then
      ShowMessage('Debe ingresar el código correspondiente al manual que desea modificar');

    edtCodigo.Color:= clWindow;
    edtCodigo.SetFocus;
  end
  else
  begin
    edtCodigo.Text:= UpperCase(edtCodigo.Text);
    Manual:= TManuales.Create;
    Manual.CodigoM:= edtCodigo.Text;

    if Operacion is TAprobar then
     Ret:= TSistema.GetInstance.ManualDB.GetManual(Manual, PLN_EST_PEND_APR)
    else if Operacion is TRecibir then
      Ret:= TSistema.GetInstance.ManualDB.GetManual(Manual, PLN_EST_PEND_REC)
    else if Operacion is TModificacion then
      Ret:= TSistema.GetInstance.ManualDB.GetManual(Manual, PLN_EST_TODOS);
    if Ret then
    begin
      edtDescripcion.Text:= Manual.DescripcionM;
      edtUbicacion.Text:= Manual.UbicacionM;
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
        ShowMessage('El código que ingresó no corresponde a ningún manual existente pendiente de aprobación en la base de datos')
      else if Operacion is TRecibir then
        ShowMessage('El código que ingresó no corresponde a ningún manual existente pendiente de recepción en la base de datos')
      else if Operacion is TModificacion then
        ShowMessage('El código que ingresó no corresponde a ningún manual existente en la base de datos');

      edtCodigo.Color:= clWindow;
      edtCodigo.SetFocus;
    end;
    Manual.Free;
  end;
end;

procedure TManualAprobarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.StbManual.SimpleText:= 'Busca el código del Manual ingresado en la base de datos';
end;

procedure TManualAprobarFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.StbManual.SimpleText:= 'Ingrese la ubicación del archivo con el Manual';
end;

procedure TManualAprobarFrm.btnDirEnter(Sender: TObject);
begin
  self.StbManual.SimpleText:= 'Seleccione la carpeta donde se encuentra el Manual';
end;

procedure TManualAprobarFrm.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Ord(Key) = 13 then
    self.btnBuscar.Click;
end;

procedure TManualAprobarFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Manual:',
      CSIDL_DRIVES, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;
end;

procedure TManualAprobarFrm.FormShow(Sender: TObject);
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
      ManualAprobarFrm.Caption:= 'Aprobar Manual';
    end
     else if Operacion is TRecibir then
     begin
       ManualAprobarFrm.Caption:= 'Recibir Manual';
    end
   else if Operacion is TModificacion then
    begin
       ManualAprobarFrm.Caption:= 'Modificar Manual'
    end;
end;

procedure TManualAprobarFrm.edtDescripcionEnter(Sender: TObject);
begin
   StbManual.SimpleText:= 'Ingrese la descripcion del manual';
end;

procedure TManualAprobarFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TManualAprobarFrm.btnConfirmarClick(Sender: TObject);
var
  Manual: TManuales;
  CodRet: Integer;

begin
  CodRet:= 0;

  if Operacion is TAprobar then
    CodRet:= MessageDlg('¿ Esta seguro que desea aprobar el manual ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TRecibir then
    CodRet:= MessageDlg('¿ Esta seguro que desea recibir el manual ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TModificacion then
    CodRet:= MessageDlg('¿ Esta seguro que desea modificar el manual ?', mtConfirmation, mbOKCancel, 0);

  if CodRet = mrOK then
  begin
    Manual:= TManuales.Create;

    Manual.CodigoM:= edtCodigo.Text;

    if Operacion is TAprobar then
    begin
      CodRet:= TSistema.GetInstance.ManualDB.Aprobar(Manual);

      if CodRet = PLN_APR_OK then
      begin
        ShowMessage('El manual ' + Manual.CodigoM + ' se aprobó satisfactoriamente');
        Manual.Free;

        if MessageDlg('¿ Desea aprobar otro manual ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El manual ' + Manual.CodigoM + ' no se pudo aprobar');
    end
    else if Operacion is TRecibir then
    begin
       CodRet:= TSistema.GetInstance.ManualDB.Recibir(Manual);
      if CodRet = PLN_REC_OK then
      begin
        ShowMessage('El manual ' + manual.CodigoM + ' se recibió satisfactoriamente');
        manual.Free;

        if MessageDlg('¿ Desea recibir otro manual ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El manual ' + manual.CodigoM + ' no se pudo recibir');
    end
    else if Operacion is TModificacion then
    begin
      manual.DescripcionM:= self.edtDescripcion.Text;
      manual.UbicacionM:= self.edtUbicacion.Text;
      CodRet:= TSistema.GetInstance.ManualDB.Modificacion(Manual);
      if CodRet = PLN_MODIF_OK then
      begin
        ShowMessage('El manual ' + Manual.CodigoM + ' se modificó satisfactoriamente');
        Manual.Free;

        if MessageDlg('¿ Desea modificar otro manual ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El manual ' + Manual.CodigoM + ' no se pudo modificar');
    end;

  end;
end;

procedure TManualAprobarFrm.edtCodigoEnter(Sender: TObject);
begin
   if Operacion is TAprobar then
    StbManual.SimpleText:= 'Ingrese el código del manual'
  else if Operacion is TRecibir then
    StbManual.SimpleText:= 'Ingrese el código del manual'
  else if Operacion is TModificacion then
    StbManual.SimpleText:= 'Ingrese el código del manual';
end;

procedure TManualAprobarFrm.btnConfirmarEnter(Sender: TObject);
begin
 if Operacion is TAprobar then
    StbManual.SimpleText:= 'Aprueba el manual especificado'
  else if Operacion is TRecibir then
    StbManual.SimpleText:= 'Recibe el manual especificado'
  else if Operacion is TModificacion then
    StbManual.SimpleText:= 'Modifica el manual especificado';
end;

end.
