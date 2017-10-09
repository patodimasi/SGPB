unit UUsuarioFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UUsuario, UOperacion, UPermisos, UPrincipalFrm, UmotorSql, USistema, ULogonFrm,IniFiles,USistemaF;

type
  TUsuarioFrm = class(TForm)
    lblNombre: TLabel;
    lblFechaAlta: TLabel;
    lblFechaBaja: TLabel;
    btnVolver: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    edtNombre: TEdit;
    btnBuscar: TButton;
    cbDiaAlta: TComboBox;
    cbMesAlta: TComboBox;
    cbDiaBaja: TComboBox;
    cbMesBaja: TComboBox;
    cbAnioAlta: TComboBox;
    cbAnioBaja: TComboBox;
    lblApellido: TLabel;
    edtApellido: TEdit;
    edtLogon: TEdit;
    lblLogon: TLabel;
    btnGenerar: TButton;
    cbEstado: TComboBox;
    lblEstado: TLabel;
    gbPermisos: TGroupBox;
    edtFechaAltaDetalle: TEdit;
    edtFechaBajaDetalle: TEdit;
    chkConsultar: TCheckBox;
    chkAlta: TCheckBox;
    chkBaja: TCheckBox;
    chkModificar: TCheckBox;
    chkSuperar: TCheckBox;
    chkAprobar: TCheckBox;
    chkRecibir: TCheckBox;
    chkAdministrar: TCheckBox;
    stbUsuario: TStatusBar;
    procedure btnVolverClick(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure edtNombreEnter(Sender: TObject);
    procedure edtApellidoEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtLogonEnter(Sender: TObject);
    procedure btnGenerarEnter(Sender: TObject);
    procedure cbEstadoEnter(Sender: TObject);
    procedure cbDiaAltaChange(Sender: TObject);
    procedure cbDiaBajaEnter(Sender: TObject);
    procedure cbMesAltaEnter(Sender: TObject);
    procedure cbMesBajaEnter(Sender: TObject);
    procedure cbAnioAltaEnter(Sender: TObject);
    procedure cbAnioBajaEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure gbPermisosEnter(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnGenerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
   // procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLogonExit(Sender: TObject);
    procedure chkAdministrarClick(Sender: TObject);
    procedure chkConsultarEnter(Sender: TObject);
    procedure chkAltaEnter(Sender: TObject);
    procedure chkModificarEnter(Sender: TObject);
    procedure chkSuperarEnter(Sender: TObject);
    procedure chkAprobarEnter(Sender: TObject);
    procedure chkRecibirEnter(Sender: TObject);
    procedure chkAdministrarEnter(Sender: TObject);
    procedure chkBajaEnter(Sender: TObject);
    procedure edtLogonKeyPress(Sender: TObject; var Key: Char);
    procedure edtApellidoKeyPress(Sender: TObject; var Key: Char);
    procedure edtNombreKeyPress(Sender: TObject; var Key: Char);
  
  //  procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure FormCreate(Sender: TObject);

  private
    FOperacion: TOperacion;
    FMainForm: TForm;
    FUsuario: TUsuario;
    function SonDatosValidos(P: TPermisos): Boolean;
    procedure PrepararAltaUsuario;
    procedure PrepararModifUsuario;
    procedure PrepararDetalleUsuario;
    procedure PrepararBajaUsuario;
    
  published
    property Usuario: TUsuario read FUsuario write FUsuario;
    property Operacion: TOperacion read FOperacion write FOperacion;
    property MainForm: TForm read FMainForm write FMainForm;

  end;

var
  UsuarioFrm: TUsuarioFrm;

implementation
uses
  UAlta, UBaja, UModificacion, UDetalle, UUtiles, UUsuarioDB,
  UPermisosDB;

{$R *.dfm}

procedure TUsuarioFrm.btnVolverClick(Sender: TObject);
begin
  if Assigned(FUsuario) then
  begin
    FUsuario.Free;
    FUsuario:= nil;
  end;

  FOperacion.Free;
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
  end;
  

procedure TUsuarioFrm.btnConfirmarEnter(Sender: TObject);
begin
  if Operacion is TAlta then
    stbUsuario.SimpleText:= 'Da de alta al usuario en la base de datos'
  else if Operacion is TBaja then
    stbUsuario.SimpleText:= 'Da de baja al usuarioen la base de datos'
  else if Operacion is TModificacion then
    stbUsuario.SimpleText:= 'Actualiza los datos del usuario en la base de datos';
end;

procedure TUsuarioFrm.edtNombreEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese el nombre';
end;

procedure TUsuarioFrm.edtApellidoEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese el apellido';
end;

procedure TUsuarioFrm.btnBuscarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Determina si el usuario ya fue dado de alta';
end;

procedure TUsuarioFrm.edtLogonEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese el nombre con el cual el usuario se identificará cuando ingrese al programa';
end;

procedure TUsuarioFrm.btnGenerarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Genera automáticamente el nombre de usuario';
end;

procedure TUsuarioFrm.cbEstadoEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Seleccione el estado del usuario';
end;

procedure TUsuarioFrm.cbDiaAltaChange(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Seleccione el día del mes';
end;

procedure TUsuarioFrm.cbDiaBajaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Seleccione el día del mes';
end;

procedure TUsuarioFrm.cbMesAltaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Seleccione el mes del año';
end;

procedure TUsuarioFrm.cbMesBajaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Seleccione el mes del año';
end;

procedure TUsuarioFrm.cbAnioAltaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Seleccione el año de alta del usuario';
end;

procedure TUsuarioFrm.cbAnioBajaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Seleccione el año de baja del usuario';
end;

procedure TUsuarioFrm.btnLimpiarEnter(Sender: TObject);
begin
  if btnLimpiar.Caption = 'Restaurar' then
    stbUsuario.SimpleText:= 'Restaura los datos originales del usuario'
  else
    stbUsuario.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TUsuarioFrm.btnVolverEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TUsuarioFrm.gbPermisosEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Seleccione las tareas que va a poder realizar este usuario'
end;

function TUsuarioFrm.SonDatosValidos(P: TPermisos): Boolean;
var
  CodRet: Boolean;
  C: Integer;
  PermisosDB: TPermisosDB;
begin
  C:= -1;
  CodRet:= True;
  PermisosDB:= TPermisosDB.Create;
  if edtNombre.Text = '' then
  begin
    edtNombre.Color:= clYellow;
    ShowMessage('Debe completar el campo "Nombre", el mismo es obligatorio');
    edtNombre.Color:= clWindow;
    edtNombre.SetFocus;
    CodRet:= False;
  end
  else if edtApellido.Text = '' then
  begin
    edtApellido.Color:= clYellow;
    ShowMessage('Debe completar el campo "Apellido", el mismo es obligatorio');
    edtApellido.Color:= clWindow;
    edtApellido.SetFocus;
    CodRet:= False;
  end
  else if edtLogon.Text = '' then
  begin
    edtLogon.Color:= clYellow;
    ShowMessage('Debe completar el campo "Nombre de usuario", el mismo es obligatorio');
    edtLogon.Color:= clWindow;
    edtLogon.SetFocus;
    CodRet:= False;
  end
  else if cbEstado.Text = '' then
  begin
    cbEstado.Color:= clYellow;
    ShowMessage('Debe seleccionar un estado para el usuario');
    cbEstado.Color:= clWindow;
    cbEstado.SetFocus;
    CodRet:= False;
  end
  else if (cbEstado.Text <> 'ACTIVO') and (cbEstado.Text <> 'INACTIVO') and
          (cbEstado.Text <> 'BAJA') and (cbEstado.Text <> 'ERROR') then
  begin
    cbEstado.Color:= clYellow;
    ShowMessage('El estado ingresado no es un estado válido');
    cbEstado.Color:= clWindow;
    cbEstado.SetFocus;
    CodRet:= False;
  end
  else if not EsFechaValida(cbDiaAlta.Text, cbMesAlta.Text, cbAnioAlta.Text) then
  begin
    cbDiaAlta.Color:= clYellow;
    cbMesAlta.Color:= clYellow;
    cbAnioAlta.Color:= clYellow;
    ShowMessage('La fecha de alta no es válida');
    cbDiaAlta.Color:= clWindow;
    cbMesAlta.Color:= clWindow;
    cbAnioAlta.Color:= clWindow;
    cbDiaAlta.SetFocus;
    CodRet:= False;
  end
  else if not EsFechaValida(cbDiaBaja.Text, cbMesBaja.Text, cbAnioBaja.Text) then
  begin
    cbDiaBaja.Color:= clYellow;
    cbMesBaja.Color:= clYellow;
    cbAnioBaja.Color:= clYellow;
    ShowMessage('La fecha de baja no es válida');
    cbDiaBaja.Color:= clWindow;
    cbMesBaja.Color:= clWindow;
    cbAnioBaja.Color:= clWindow;
    cbDiaBaja.SetFocus;
    CodRet:= False;
  end
  else if not PermisosDB.GetCodigo(P, C) then
  begin
    ShowMessage('Los permisos seleccionados no forman una combinación de permisos permitida');
    CodRet:= False;
  end;

  Result:= CodRet;
end;


procedure TUsuarioFrm.btnConfirmarClick(Sender: TObject);
var
  Us: TUsuario;
  PermDB: TPermisosDB;
  Msg: string;
  CodRet: Integer;
  CodPerm: Integer;

begin
  CodPerm:= -1;
  Us:= TUsuario.Create;
  PermDB:= TPermisosDB.Create;
  if chkConsultar.Checked and chkConsultar.Enabled then
    Us.Permisos.Consultar:= 'S';
  if chkAlta.Checked and chkAlta.Enabled then
    Us.Permisos.Alta:= 'S';
  if chkBaja.Checked and chkBaja.Enabled then
    Us.Permisos.Baja:= 'S';
  if chkModificar.Checked and chkModificar.Enabled then
    Us.Permisos.Modificar:= 'S';
  if chkSuperar.Checked and chkSuperar.Enabled then
    Us.Permisos.Superar:= 'S';
  if chkAprobar.Checked and chkAprobar.Enabled then
    Us.Permisos.Aprobar:= 'S';
  if chkRecibir.Checked and chkRecibir.Enabled then
    Us.Permisos.Recibir:= 'S';
  if chkAdministrar.Checked and chkAdministrar.Enabled then
    Us.Permisos.Administrar:= 'S';

  if SonDatosValidos(Us.Permisos) then
  begin
    if Operacion is TAlta then
      Msg := '¿ Esta seguro que desea dar de alta el usuario ?'
    else if Operacion is TBaja then
      Msg := '¿ Esta seguro que desea dar de baja el usuario ?'
    else if Operacion is TModificacion then
      Msg := '¿ Esta seguro que desea modificar los datos del usuario ?';

    if MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) = mrOK then
    begin
      if Operacion is TAlta then
      begin
        with Us do
        begin
          Nombre:= edtNombre.Text;
          Apellido:= edtApellido.Text;
          Logon:= edtLogon.Text;
          Estado:= USR_EST_ACTIVO;

          FechaAlta:= cbDiaAlta.Text + '/' + cbMesAlta.Text + '/' + cbAnioAlta.Text;
          FechaBaja:= '';

          PermDB.GetCodigo(Permisos, CodPerm);
          Permisos.Codigo:= CodPerm
        end;
        CodRet:= TSistema.GetInstance.UsuarioDB.Alta(Us);
        if CodRet = USR_ALTA_OK then
        begin
          ShowMessage('El usuario ' + Us.Logon + ' se dió de alta satisfactoriamente. La contraseña es la misma que el nombre de usuario.');
          btnLimpiar.Click;
        end
        else if CodRet = USR_ALTA_FAILED then
        begin
          ShowMessage('El usuario ' + Us.Logon + ' no se pudo dar de alta');
        end
        else if CodRet = USR_ALTA_LOGON_DUP then
        begin
          ShowMessage('El nombre de usuario ' + Us.Logon + ' ya esta asignado a otro usuario, por favor, escoja otro nombre para este usuario y vuelva a Confirmar la Alta');
          btnGenerar.Enabled:= True;
          edtLogon.SetFocus;
        end;
      end
      else if Operacion is TBaja then
      begin
        Us.Logon:= edtLogon.Text;
        Us.Estado:= USR_EST_BAJA;
        Us.FechaBaja:= cbDiaBaja.Text + '/' + cbMesBaja.Text + '/' + cbAnioBaja.Text;
        PermDB.GetCodigo(Us.Permisos, CodPerm);
        Us.Permisos.Codigo:= CodPerm;

        // LOS USUARIOS NO SE DAN DE BAJA, SE CAMBIA SU ESTADO A BAJA
        if TSistema.GetInstance.UsuarioDB.Modificacion(Us) then
        begin
          ShowMessage('El usuario ' + Us.Logon + ' se dió de baja satisfactoriamente');
          // Si logró dar de baja vuelvo a la pantalla anterior
          btnVolver.Click;
        end;
      end
      else if Operacion is TModificacion then
      begin
        with Us do
        begin
          Nombre:= edtNombre.Text;
          Apellido:= edtApellido.Text;
          Logon:= edtLogon.Text;

          if cbEstado.Text = 'ACTIVO' then
            Estado:= USR_EST_ACTIVO
          else if cbEstado.Text = 'INACTIVO' then
            Estado:= USR_EST_INACTIVO
          else if cbEstado.Text = 'BAJA' then
            Estado:= USR_EST_BAJA
          else if cbEstado.Text = 'ERROR' then
            Estado:= USR_EST_ERROR;

          FechaAlta:= cbDiaAlta.Text + '/' + cbMesAlta.Text + '/' + cbAnioAlta.Text;
          FechaBaja:= '';

          PermDB.GetCodigo(Permisos, CodPerm);
          Permisos.Codigo:= CodPerm;
        end;

        if TSistema.GetInstance.UsuarioDB.Modificacion(Us) then
        begin
          ShowMessage('El usuario ' + Us.Logon + ' se modificó satisfactoriamente');
          btnVolver.Click;
        end;
      end;
    end;
  end;
  PermDB.Free;
  Us.Free;
end;

procedure TUsuarioFrm.btnGenerarClick(Sender: TObject);
var
  U: TUsuario;
  sLogon: string;
begin
  U:= TUsuario.Create;

  U.Nombre:= edtNombre.Text;
  U.Apellido:= edtApellido.Text;

  sLogon:= TSistema.GetInstance.UsuarioDB.GenerarLogon(U);

  if sLogon = '' then
  begin
    edtLogon.Color:= clYellow;
    ShowMessage('No se pudo generar de forma automática un nombre de usuario, ingréselo manualmente');
    edtLogon.Color:= clWindow;
    btnGenerar.Enabled:= False;
    edtLogon.SetFocus;
  end
  else
    edtLogon.Text:= sLogon;


  U.Free;

end;

procedure TUsuarioFrm.FormShow(Sender: TObject);
begin
  stbUsuario.SimpleText:= '';

  if Operacion is TAlta then
    PrepararAltaUsuario
  else if Operacion is TBaja then
    PrepararBajaUsuario
  else if Operacion is TModificacion then
    PrepararModifUsuario
  else if Operacion is TDetalle then
    PrepararDetalleUsuario;

end;

procedure TUsuarioFrm.btnLimpiarClick(Sender: TObject);
begin
  if Operacion is TModificacion then
    PrepararModifUsuario
  else
    PrepararAltaUsuario;
end;

procedure TUsuarioFrm.btnBuscarClick(Sender: TObject);
var
  U: TUsuario;
  PrepararAlta: Boolean;
  Valido: Boolean;

begin
  PrepararAlta:= False;
  Valido:= True;

  U:= TUsuario.Create;

  if edtNombre.Text = '' then
  begin
    edtNombre.Color:= clYellow;
    ShowMessage('Debe completar el campo "Nombre", el mismo es obligatorio');
    edtNombre.Color:= clWindow;
    edtNombre.SetFocus;
    Valido:= False;
  end
  else if edtApellido.Text = '' then
  begin
    edtApellido.Color:= clYellow;
    ShowMessage('Debe completar el campo "Apellido", el mismo es obligatorio');
    edtApellido.Color:= clWindow;
    edtApellido.SetFocus;
    Valido:= False;
  end;

  if Valido then
  begin
    U.Nombre:= edtNombre.Text;
    U.Apellido:= edtApellido.Text;

    if TSistema.GetInstance.UsuarioDB.GetUsuario(U, CONS_USR_NYA) then
    begin
      if MessageDlg('Ya existe un usuario para esta persona, ¿ desea darlo de alta de todas formas ?', mtConfirmation, mbOKCancel, 0) = mrOK then
        PrepararAlta:= True;
    end
    else
      PrepararAlta:= True;

    if PrepararAlta then
    begin
      lblNombre.Enabled:= False;
      edtNombre.Enabled:= False;
      lblApellido.Enabled:= False;
      edtApellido.Enabled:= False;
      btnBuscar.Enabled:= False;
      lblLogon.Enabled:= True;
      edtLogon.Enabled:= True;
      btnGenerar.Enabled:= True;
      lblEstado.Enabled:= True;
      cbEstado.Enabled:= False;
      cbEstado.ItemIndex:= 0;
      lblFechaAlta.Enabled:= True;
      cbDiaAlta.Enabled:= True;
      cbMesAlta.Enabled:= True;
      cbAnioAlta.Enabled:= True;
      gbPermisos.Enabled:= True;
      chkConsultar.Checked:= True;
      chkConsultar.Enabled:= True;
      chkAlta.Checked:= False;
      chkAlta.Enabled:= True;
      chkBaja.Checked:= False;
      chkBaja.Enabled:= True;
      chkModificar.Checked:= False;
      chkModificar.Enabled:= True;
      chkSuperar.Checked:= False;
      chkSuperar.Enabled:= True;
      chkAprobar.Checked:= False;
      chkAprobar.Enabled:= True;
      chkRecibir.Checked:= False;
      chkRecibir.Enabled:= True;
      chkAdministrar.Checked:= False;
      chkAdministrar.Enabled:= True;

      btnConfirmar.Enabled:= True;
      edtLogon.SetFocus;
    end;
  end;
  U.Free;

end;

{procedure TUsuarioFrm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TIniFile;
  //Usuario: string;
begin
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, 'SGPBFotos.INI' ) );
  try
    Ini.WriteString( 'Directorio', 'Base', ExtractFilePath(Application.ExeName));

  finally
    Ini.Free;

  end;
end;}


procedure TUsuarioFrm.PrepararAltaUsuario;
begin
  UsuarioFrm.Caption:= 'Alta de Usuario';

  // Habilito el nombre
  lblNombre.Enabled:= True;
  edtNombre.Enabled:= True;
  edtNombre.Text:= '';

  // Habilito el apellido
  lblApellido.Enabled:= True;
  edtApellido.Enabled:= True;
  edtApellido.Text:= '';

  // Habilito el botón de buscar
  btnBuscar.Enabled:= True;
  btnBuscar.Visible:= True;

  // Deshabilito el logon
  lblLogon.Enabled:= False;
  edtLogon.Enabled:= False;
  edtLogon.Text:= '';

  // Deshabilito el generar logon
  btnGenerar.Enabled:= False;
  btnGenerar.Visible:= True;

  // Deshabilito el estado
  lblEstado.Enabled:= False;
  cbEstado.Enabled:= False;
  cbEstado.ItemIndex:= 0;

  // Deshabilito la fecha
  // Pongo la fecha actual
  lblFechaAlta.Enabled:= False;
  cbDiaAlta.Text:= Copy(DateToStr(Date), 1, 2);
  cbMesAlta.Text:= Copy(DateToStr(Date), 4, 2);
  cbAnioAlta.Text:= Copy(DateToStr(Date), 7, 4);
  cbDiaAlta.Enabled:= False;
  cbMesAlta.Enabled:= False;
  cbAnioAlta.Enabled:= False;

  // Oculto la fecha de baja
  lblFechaBaja.Visible:= False;
  cbDiaBaja.Visible:= False;
  cbMesBaja.Visible:= False;
  cbAnioBaja.Visible:= False;

  // Oculto las fechas del detalle
  edtFechaAltaDetalle.Visible:= False;
  edtFechaBajaDetalle.Visible:= False;

  // Deshabilito los permisos
  gbPermisos.Enabled:= False;
  chkAdministrar.Checked:= False;
  chkAdministrar.Enabled:= False;
  chkConsultar.Checked:= True;
  chkConsultar.Enabled:= False;
  chkAlta.Checked:= False;
  chkAlta.Enabled:= False;
  chkBaja.Checked:= False;
  chkBaja.Enabled:= False;
  chkModificar.Checked:= False;
  chkModificar.Enabled:= False;
  chkSuperar.Checked:= False;
  chkSuperar.Enabled:= False;
  chkAprobar.Checked:= False;
  chkAprobar.Enabled:= False;
  chkRecibir.Checked:= False;
  chkRecibir.Enabled:= False;


  // Deshabilito Confirmar
  btnConfirmar.Enabled:= False;
  btnConfirmar.Visible:= True;

  // Habilito Limpiar
  btnLimpiar.Enabled:= True;
  btnLimpiar.Visible:= True;
  btnLimpiar.Caption:= '&Limpiar';

  // Pongo el foco en el nombre
  edtNombre.SetFocus;
end;

procedure TUsuarioFrm.PrepararModifUsuario;
begin
  UsuarioFrm.Caption:= 'Modificar Usuario';

  // Deshabilito el nombre
  lblNombre.Enabled:= True;
  edtNombre.Enabled:= False;
  edtNombre.Text:= Usuario.Nombre;

  // Deshabilito el apellido
  lblApellido.Enabled:= True;
  edtApellido.Enabled:= False;
  edtApellido.Text:= Usuario.Apellido;

  // Oculto el botón de buscar
  btnBuscar.Visible:= False;

  // Deshabilito el logon
  lblLogon.Enabled:= True;
  edtLogon.Enabled:= False;
  edtLogon.Text:= Usuario.Logon;

  // Oculto el botón de generar logon
  btnGenerar.Visible:= False;

  // Habilito el estado
  lblEstado.Enabled:= True;
  cbEstado.Enabled:= True;
  if Usuario.Estado = USR_EST_ACTIVO then
    cbEstado.ItemIndex:= 0
  else if Usuario.Estado = USR_EST_INACTIVO then
    cbEstado.ItemIndex:= 1
  else if Usuario.Estado = USR_EST_BAJA then
    cbEstado.ItemIndex:= 2
  else if Usuario.Estado = USR_EST_ERROR then
    cbEstado.ItemIndex:= 3;

  // Habilito la fecha de alta
  lblFechaAlta.Enabled:= True;
  cbDiaAlta.Visible:= False;
  cbMesAlta.Visible:= False;
  cbAnioAlta.Visible:= False;
  edtFechaAltaDetalle.Enabled:= False;
  edtFechaAltaDetalle.Text:= Usuario.FechaAlta;

  // Muestro la fecha de baja si tiene
  lblFechaBaja.Visible:= False;
  edtFechaBajaDetalle.Visible:= False;
  cbDiaBaja.Visible:= False;
  cbMesBaja.Visible:= False;
  cbAnioBaja.Visible:= False;

  gbPermisos.Enabled:= True;
  chkAdministrar.Checked:= False;
  chkAdministrar.Enabled:= True;  
  chkConsultar.Checked:= False;
  chkConsultar.Enabled:= True;
  chkAlta.Checked:= False;
  chkAlta.Enabled:= True;
  chkBaja.Checked:= False;
  chkBaja.Enabled:= True;
  chkModificar.Checked:= False;
  chkModificar.Enabled:= True;
  chkSuperar.Checked:= False;
  chkSuperar.Enabled:= True;
  chkAprobar.Checked:= False;
  chkAprobar.Enabled:= True;
  chkRecibir.Checked:= False;
  chkRecibir.Enabled:= True;

  if Usuario.Permisos.Administrar = 'S' then
    chkAdministrar.Checked:= True
  else
  begin
    if Usuario.Permisos.Consultar = 'S' then
      chkConsultar.Checked:= True;

    if Usuario.Permisos.Alta = 'S' then
      chkAlta.Checked:= True;

    if Usuario.Permisos.Baja = 'S' then
      chkBaja.Checked:= True;

    if Usuario.Permisos.Modificar = 'S' then
      chkModificar.Checked:= True;

    if Usuario.Permisos.Superar = 'S' then
      chkSuperar.Checked:= True;

    if Usuario.Permisos.Aprobar = 'S' then
      chkAprobar.Checked:= True;

    if Usuario.Permisos.Recibir = 'S' then
      chkRecibir.Checked:= True;
  end;


  btnConfirmar.Enabled:= True;
  btnConfirmar.Visible:= True;

  btnLimpiar.Caption:= '&Restaurar';
  btnLimpiar.Enabled:= True;
  btnLimpiar.Visible:= True;

  cbEstado.SetFocus;

end;

procedure TUsuarioFrm.PrepararDetalleUsuario;
begin
  UsuarioFrm.Caption:= 'Detalles del Usuario';

  // Deshabilito el nombre
  lblNombre.Enabled:= True;
  edtNombre.Enabled:= False;
  edtNombre.Text:= Usuario.Nombre;

  // Deshabilito el apellido
  lblApellido.Enabled:= True;
  edtApellido.Enabled:= False;
  edtApellido.Text:= Usuario.Apellido;

  // Oculto el botón de buscar
  btnBuscar.Visible:= False;

  // Deshabilito el logon
  lblLogon.Enabled:= True;
  edtLogon.Enabled:= False;
  edtLogon.Text:= Usuario.Logon;

  // Oculto el botón de generar logon
  btnGenerar.Visible:= False;

  // Habilito el estado
  lblEstado.Enabled:= True;
  cbEstado.Enabled:= False;
  if Usuario.Estado = USR_EST_ACTIVO then
    cbEstado.ItemIndex:= 0
  else if Usuario.Estado = USR_EST_INACTIVO then
    cbEstado.ItemIndex:= 1
  else if Usuario.Estado = USR_EST_BAJA then
    cbEstado.ItemIndex:= 2
  else if Usuario.Estado = USR_EST_ERROR then
    cbEstado.ItemIndex:= 3;

  // Habilito la fecha de alta
  lblFechaAlta.Enabled:= True;
  cbDiaAlta.Visible:= False;
  cbMesAlta.Visible:= False;
  cbAnioAlta.Visible:= False;
  edtFechaAltaDetalle.Enabled:= False;
  edtFechaAltaDetalle.Text:= Usuario.FechaAlta;
  edtFechaAltaDetalle.Visible:= True;

  // Muestro la fecha de baja si tiene
  cbDiaBaja.Visible:= False;
  cbMesBaja.Visible:= False;
  cbAnioBaja.Visible:= False;
  if Usuario.FechaBaja <> '' then
  begin
    lblFechaBaja.Enabled:= True;
    edtFechaBajaDetalle.Visible:= True;
    edtFechaBajaDetalle.Enabled:= False;
    edtFechaBajaDetalle.Text:= Usuario.FechaBaja;
  end
  else
  begin
    lblFechaBaja.Visible:= False;
    edtFechaBajaDetalle.Visible:= False;
  end;

  gbPermisos.Enabled:= False;
  chkAdministrar.Checked:= False;
  chkAdministrar.Enabled:= False;
  chkConsultar.Checked:= False;
  chkConsultar.Enabled:= False;
  chkAlta.Checked:= False;
  chkAlta.Enabled:= False;
  chkBaja.Checked:= False;
  chkBaja.Enabled:= False;
  chkModificar.Checked:= False;
  chkModificar.Enabled:= False;
  chkSuperar.Checked:= False;
  chkSuperar.Enabled:= False;
  chkAprobar.Checked:= False;
  chkAprobar.Enabled:= False;
  chkRecibir.Checked:= False;
  chkRecibir.Enabled:= False;

  if Usuario.Permisos.Administrar = 'S' then
  begin
    chkAdministrar.Checked:= True;
    chkAdministrar.Enabled:= True;
  end
  else
  begin
    if Usuario.Permisos.Consultar = 'S' then
    begin
      chkConsultar.Checked:= True;
      chkConsultar.Enabled:= True;
    end;

    if Usuario.Permisos.Alta = 'S' then
    begin
      chkAlta.Checked:= True;
      chkAlta.Enabled:= True;
    end;

    if Usuario.Permisos.Baja = 'S' then
    begin
      chkBaja.Checked:= True;
      chkBaja.Enabled:= True;
    end;

    if Usuario.Permisos.Modificar = 'S' then
    begin
      chkModificar.Checked:= True;
      chkModificar.Enabled:= True;
    end;


    if Usuario.Permisos.Superar = 'S' then
    begin
      chkSuperar.Checked:= True;
      chkSuperar.Enabled:= True;
    end;

    if Usuario.Permisos.Aprobar = 'S' then
    begin
      chkAprobar.Checked:= True;
      chkAprobar.Enabled:= True;
    end;

    if Usuario.Permisos.Recibir = 'S' then
    begin
      chkRecibir.Checked:= True;
      chkRecibir.Enabled:= True;
    end;
  end;

  btnConfirmar.Visible:= False;
  btnLimpiar.Visible:= False;

  stbUsuario.SimpleText:= 'Regresa a la pantalla anterior';
  btnVolver.SetFocus;

end;

procedure TUsuarioFrm.PrepararBajaUsuario;
begin
  UsuarioFrm.Caption:= 'Baja de Usuario';

  // Deshabilito el nombre
  lblNombre.Enabled:= True;
  edtNombre.Enabled:= False;
  edtNombre.Text:= Usuario.Nombre;

  // Deshabilito el apellido
  lblApellido.Enabled:= True;
  edtApellido.Enabled:= False;
  edtApellido.Text:= Usuario.Apellido;

  // Deshabilito el logon
  lblLogon.Enabled:= True;
  edtLogon.Enabled:= False;
  edtLogon.Text:= Usuario.Logon;

  btnBuscar.Visible:= False;
  btnGenerar.Visible:= False;

  // Deshabilito el estado pero lo seteo como baja
  lblEstado.Enabled:= True;
  cbEstado.Enabled:= False;
  cbEstado.ItemIndex:= 2;

  // Deshabilito la fecha de alta
  lblFechaAlta.Enabled:= True;
  cbDiaAlta.Visible:= False;
  cbMesAlta.Visible:= False;
  cbAnioAlta.Visible:= False;
  edtFechaAltaDetalle.Visible:= True;
  edtFechaAltaDetalle.Enabled:= False;
  edtFechaAltaDetalle.Text:= Usuario.FechaAlta;

  gbPermisos.Enabled:= False;
  chkAdministrar.Checked:= False;
  chkAdministrar.Enabled:= False;
  chkConsultar.Checked:= False;
  chkConsultar.Enabled:= False;
  chkAlta.Checked:= False;
  chkAlta.Enabled:= False;
  chkBaja.Checked:= False;
  chkBaja.Enabled:= False;
  chkModificar.Checked:= False;
  chkModificar.Enabled:= False;
  chkSuperar.Checked:= False;
  chkSuperar.Enabled:= False;
  chkAprobar.Checked:= False;
  chkAprobar.Enabled:= False;
  chkRecibir.Checked:= False;
  chkRecibir.Enabled:= False;

  if Usuario.Permisos.Administrar = 'S' then
  begin
    chkAdministrar.Checked:= True;
    chkAdministrar.Enabled:= True;
  end
  else
  begin
    if Usuario.Permisos.Consultar = 'S' then
    begin
      chkConsultar.Checked:= True;
      chkConsultar.Enabled:= True;
    end;

    if Usuario.Permisos.Alta = 'S' then
    begin
      chkAlta.Checked:= True;
      chkAlta.Enabled:= True;
    end;

    if Usuario.Permisos.Baja = 'S' then
    begin
      chkBaja.Checked:= True;
      chkBaja.Enabled:= True;
    end;

    if Usuario.Permisos.Modificar = 'S' then
    begin
      chkModificar.Checked:= True;
      chkModificar.Enabled:= True;
    end;


    if Usuario.Permisos.Superar = 'S' then
    begin
      chkSuperar.Checked:= True;
      chkSuperar.Enabled:= True;
    end;

    if Usuario.Permisos.Aprobar = 'S' then
    begin
      chkAprobar.Checked:= True;
      chkAprobar.Enabled:= True;
    end;

    if Usuario.Permisos.Recibir = 'S' then
    begin
      chkRecibir.Checked:= True;
      chkRecibir.Enabled:= True;
    end;
  end;

  // Habilito fecha de baja con la fecha del día por defecto
  lblFechaBaja.Enabled:= True;
  cbDiaBaja.Enabled:= True;
  cbMesBaja.Enabled:= True;
  cbAnioBaja.Enabled:= True;
  cbDiaBaja.Visible:= True;
  cbMesBaja.Visible:= True;
  cbAnioBaja.Visible:= True;
  edtFechaBajaDetalle.Visible:= False;

  Usuario.FechaBaja:= DateToStr(Date);
  cbDiaBaja.Text:= Copy(Usuario.FechaBaja, 1, 2);
  cbMesBaja.Text:= Copy(Usuario.FechaBaja, 4, 2);
  cbAnioBaja.Text:= Copy(Usuario.FechaBaja, 7, 4);

  btnConfirmar.Enabled:= True;
  btnConfirmar.Visible:= True;
  btnLimpiar.Visible:= True;
  btnLimpiar.Caption:= '&Limpiar';
  btnLimpiar.Enabled:= False;
  btnConfirmar.SetFocus;

end;


procedure TUsuarioFrm.edtLogonExit(Sender: TObject);
begin
  edtLogon.Text:= UpperCase(edtLogon.Text)
end;

procedure TUsuarioFrm.chkAdministrarClick(Sender: TObject);
begin
  if chkAdministrar.Checked then
  begin
    chkConsultar.Enabled:= False;
    chkAlta.Enabled:= False;
    chkBaja.Enabled:= False;
    chkModificar.Enabled:= False;
    chkSuperar.Enabled:= False;
    chkAprobar.Enabled:= False;
    chkRecibir.Enabled:= False;
  end
  else
  begin
    chkConsultar.Enabled:= True;
    chkAlta.Enabled:= True;
    chkBaja.Enabled:= True;
    chkModificar.Enabled:= True;
    chkSuperar.Enabled:= True;
    chkAprobar.Enabled:= True;
    chkRecibir.Enabled:= True;
  end;
end;

procedure TUsuarioFrm.chkConsultarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Otorgar permisos para consultar planos';
end;

procedure TUsuarioFrm.chkAltaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Otorgar permisos para dar de alta planos';
end;

procedure TUsuarioFrm.chkModificarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Otorgar permisos para modificar planos';
end;

procedure TUsuarioFrm.chkSuperarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Otorgar permisos para superar planos';
end;

procedure TUsuarioFrm.chkAprobarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Otorgar permisos para aprobar planos';
end;

procedure TUsuarioFrm.chkRecibirEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Otorgar permisos para recibir planos';
end;

procedure TUsuarioFrm.chkAdministrarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Otorgar permisos para administrar el sistema (tiene todos los permisos)';
end;

procedure TUsuarioFrm.chkBajaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Otorgar permisos para dar de baja planos (los planos dados de baja no pueden recuperarse)';
end;



procedure TUsuarioFrm.edtLogonKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    btnGenerar.Click;
end;

procedure TUsuarioFrm.edtApellidoKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    btnBuscar.Click;
end;

procedure TUsuarioFrm.edtNombreKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    btnBuscar.Click;
end;


{procedure TUsuarioFrm.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  Base: string;
  Usuario: string;
  begin
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, 'SGPBFotos.INI' ) );
  try
    Base:= Ini.ReadString('Directorio','Base',ExtractFilePath(Application.ExeName));

  finally

   Ini.Free
  end;
end;}

end.

