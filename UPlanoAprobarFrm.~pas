unit UPlanoAprobarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, UOperacion, UPantallaFrm, DB, ADODB;

type
  TPlanoAprobarFrm = class(TPantallaFrm)
    lblCodigo: TLabel;
    lblDescripcion: TLabel;
    edtCodigo: TEdit;
    edtDescripcion: TEdit;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbPlano: TStatusBar;
    btnBuscar: TButton;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;

    procedure edtCodigoEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
   // procedure FormCreate(Sender: TObject);

  protected
    FOperacion: TOperacion;
    procedure LockScreen;
    procedure UnLockScreen;

  published
    property Operacion: TOperacion read FOperacion write FOperacion;

  end;
var
  PlanoAprobarFrm: TPlanoAprobarFrm;
  AdoCon: TADOConnection;
  AdoDst: TADODataset;

implementation

{$R *.dfm}
uses
  UPlano, USistema, UAprobar, URecibir, UModificacion, UPlanoDB, UUtiles, shlobj;

procedure TPlanoAprobarFrm.LockScreen;
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

procedure TPlanoAprobarFrm.UnLockScreen;
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

procedure TPlanoAprobarFrm.edtCodigoEnter(Sender: TObject);
begin
  if Operacion is TAprobar then
    stbPlano.SimpleText:= 'Ingrese el código del plano'
  else if Operacion is TRecibir then
    stbPlano.SimpleText:= 'Ingrese el código del plano'
  else if Operacion is TModificacion then
    stbPlano.SimpleText:= 'Ingrese el código del plano';
end;

procedure TPlanoAprobarFrm.btnConfirmarEnter(Sender: TObject);
begin
  if Operacion is TAprobar then
    stbPlano.SimpleText:= 'Aprueba el plano especificado'
  else if Operacion is TRecibir then
    stbPlano.SimpleText:= 'Recibe el plano especificado'
  else if Operacion is TModificacion then
    stbPlano.SimpleText:= 'Modifica el plano especificado';
end;

procedure TPlanoAprobarFrm.btnLimpiarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TPlanoAprobarFrm.btnVolverEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TPlanoAprobarFrm.btnVolverClick(Sender: TObject);
begin
 //self.Close;
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TPlanoAprobarFrm.btnLimpiarClick(Sender: TObject);
begin
  edtCodigo.Enabled:= True;
  edtCodigo.Text:= '';
  btnBuscar.Enabled:= True;
  edtDescripcion.Enabled:= False;
  edtDescripcion.Text:= '';
  edtDescripcion.TabStop:= False;
  edtUbicacion.Text:= '';
  edtUbicacion.TabStop:= False;
  edtUbicacion.Enabled:= False;
  btnDir.Enabled:= False;
  btnConfirmar.Enabled:= False;
  edtCodigo.SetFocus;
end;

procedure TPlanoAprobarFrm.btnBuscarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Busca el código de plano ingresado en la base de datos';
end;

procedure TPlanoAprobarFrm.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
    btnBuscar.Click;
end;

procedure TPlanoAprobarFrm.btnBuscarClick(Sender: TObject);
var
  Plano: TPlano;
  Ret: Boolean;

begin
  Ret:= False;
  if edtCodigo.Text = '' then
  begin
    edtCodigo.Color:= clYellow;
    if Operacion is TAprobar then
      ShowMessage('Debe ingresar el código correspondiente al plano que desea aprobar')
    else if Operacion is TRecibir then
      ShowMessage('Debe ingresar el código correspondiente al plano que desea recibir')
    else if Operacion is TModificacion then
      ShowMessage('Debe ingresar el código correspondiente al plano que desea modificar');

    edtCodigo.Color:= clWindow;
    edtCodigo.SetFocus;
  end
  else
  begin
    edtCodigo.Text:= UpperCase(edtCodigo.Text);
    Plano:= TPlano.Create;
    Plano.Codigo:= edtCodigo.Text;

    if Operacion is TAprobar then
      Ret:= TSistema.GetInstance.PlanoDB.GetPlano(Plano, PLN_EST_PEND_APR)
    else if Operacion is TRecibir then
      Ret:= TSistema.GetInstance.PlanoDB.GetPlano(Plano, PLN_EST_PEND_REC)
    else if Operacion is TModificacion then
      Ret:= TSistema.GetInstance.PlanoDB.GetPlano(Plano, PLN_EST_TODOS);

    if Ret then
    begin
      edtDescripcion.Text:= Plano.Descripcion;
      edtUbicacion.Text:= Plano.Ubicacion;
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
        ShowMessage('El código que ingresó no corresponde a ningún plano existente pendiente de aprobación en la base de datos')
      else if Operacion is TRecibir then
        ShowMessage('El código que ingresó no corresponde a ningún plano existente pendiente de recepción en la base de datos')
      else if Operacion is TModificacion then
        ShowMessage('El código que ingresó no corresponde a ningún plano existente en la base de datos');

      edtCodigo.Color:= clWindow;
      edtCodigo.SetFocus;
    end;
    Plano.Free;
  end;
end;

procedure TPlanoAprobarFrm.btnConfirmarClick(Sender: TObject);
var
  Plano: TPlano;
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
    Plano:= TPlano.Create;

    Plano.Codigo:= edtCodigo.Text;

    if Operacion is TAprobar then
    begin
      CodRet:= TSistema.GetInstance.PlanoDB.Aprobar(Plano);
      if CodRet = PLN_APR_OK then
      begin
        ShowMessage('El plano ' + Plano.Codigo + ' se aprobó satisfactoriamente');
        Plano.Free;
        if MessageDlg('¿ Desea aprobar otro plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then

          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El plano ' + Plano.Codigo + ' no se pudo aprobar');
    end
    else if Operacion is TRecibir then
    begin
      CodRet:= TSistema.GetInstance.PlanoDB.Recibir(Plano);
      if CodRet = PLN_REC_OK then
      begin
        ShowMessage('El plano ' + Plano.Codigo + ' se recibió satisfactoriamente');
        Plano.Free;

        if MessageDlg('¿ Desea recibir otro plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El plano ' + Plano.Codigo + ' no se pudo recibir');
    end
    else if Operacion is TModificacion then
    begin
      Plano.Descripcion:= edtDescripcion.Text;
      Plano.Ubicacion:= edtUbicacion.Text;
      CodRet:= TSistema.GetInstance.PlanoDB.Modificacion(Plano);
      if CodRet = PLN_MODIF_OK then
      begin
        ShowMessage('El plano ' + Plano.Codigo + ' se modificó satisfactoriamente');
        Plano.Free;

        if MessageDlg('¿ Desea modificar otro plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El plano ' + Plano.Codigo + ' no se pudo modificar');
    end;

  end;
end;

procedure TPlanoAprobarFrm.FormShow(Sender: TObject);
begin
    //FLocked:= False;
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
      PlanoAprobarFrm.Caption:= 'Aprobar Plano';
    end
     else if Operacion is TRecibir then
     begin
       PlanoAprobarFrm.Caption:= 'Recibir Plano';
    end
    else if Operacion is TModificacion then
    begin
       PlanoAprobarFrm.Caption:= 'Modificar Plano';
    end;
end;

procedure TPlanoAprobarFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TPlanoAprobarFrm.edtUbicacionEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese la ubicación del archivo con el plano';
end;

procedure TPlanoAprobarFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el plano:',
      CSIDL_DRIVES, edtUbicacion.Text);
  if sDir <> '' then
    edtUbicacion.Text:= sDir;
end;

procedure TPlanoAprobarFrm.btnDirEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione la carpeta donde se encuentra el plano';
end;

procedure TPlanoAprobarFrm.edtDescripcionEnter(Sender: TObject);
begin
   stbPlano.SimpleText:= 'Ingrese la descripcion del plano';
end;

end.
