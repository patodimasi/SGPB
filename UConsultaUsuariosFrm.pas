unit UConsultaUsuariosFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TConsultaUsuariosFrm = class(TForm)
    btnVolver: TButton;
    stbUsuario: TStatusBar;
    btnBuscar: TButton;
    btnLimpiar: TButton;
    btnModificar: TButton;
    btnBaja: TButton;
    btnTodos: TButton;
    ListView: TListView;
    btnDetalles: TButton;
    lblNombre: TLabel;
    lblApellido: TLabel;
    lblLogon: TLabel;
    edtNombre: TEdit;
    edtApellido: TEdit;
    edtLogon: TEdit;
    gbEstados: TGroupBox;
    chkActivo: TCheckBox;
    chkInactivo: TCheckBox;
    chkError: TCheckBox;
    chkBaja: TCheckBox;
    procedure btnBuscarEnter(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTodosEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnModificarEnter(Sender: TObject);
    procedure btnBajaEnter(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnBajaClick(Sender: TObject);
    procedure btnDetallesClick(Sender: TObject);
    procedure btnDetallesEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtNombreEnter(Sender: TObject);
    procedure edtApellidoEnter(Sender: TObject);
    procedure edtLogonEnter(Sender: TObject);
    procedure chkActivoEnter(Sender: TObject);
    procedure chkInactivoEnter(Sender: TObject);
    procedure chkBajaEnter(Sender: TObject);
    procedure chkErrorEnter(Sender: TObject);

  private
    FMainForm: TForm;
    FSQL: string;
    FActualizar: Boolean;
    FSeleccionado: Integer;
    procedure Consultar;
    procedure Actualizar;
    function Where(var W: Boolean): string;
  published
    property MainForm: TForm read FMainForm write FMainForm;
  end;

var
  ConsultaUsuariosFrm: TConsultaUsuariosFrm;

implementation
uses
  ADODB, UUsuarioDB, UUsuario, UUsuarioFrm, UBaja, UModificacion,
  UDetalle, USistema;

{$R *.dfm}

procedure TConsultaUsuariosFrm.btnVolverClick(Sender: TObject);
begin
  FSQL:= '';
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TConsultaUsuariosFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TConsultaUsuariosFrm.btnBuscarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Busca todos los usuarios que cumplan '
                        + 'con el criterio de búsqueda ingresado';
end;

procedure TConsultaUsuariosFrm.btnTodosEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Devuelve el listado de todos los usuarios que '
                            + 'existen en la base de datos';
end;

procedure TConsultaUsuariosFrm.btnLimpiarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Vacia todos los casilleros de la pantalla para '
                        + 'poder realizar una nueva consulta';
end;

procedure TConsultaUsuariosFrm.btnLimpiarClick(Sender: TObject);
begin
  edtNombre.Text:= '';
  edtApellido.Text:= '';
  edtLogon.Text:= '';
  chkActivo.Checked:= True;
  chkInactivo.Checked:= True;
  chkError.Checked:= True;
  chkBaja.Checked:= True;
  btnDetalles.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBaja.Enabled:= False;
  ListView.Clear;
  ListView.Enabled:= False;
  FSeleccionado:= -1;
  edtNombre.SetFocus;
end;

procedure TConsultaUsuariosFrm.btnModificarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Permite modificar los datos del usuario seleccionado de la lista';
end;

procedure TConsultaUsuariosFrm.btnBajaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Permite dar de baja al usuario seleccionado de la lista';
end;

function TConsultaUsuariosFrm.Where(var W: Boolean): string;
begin
  Result:= ' where ';
  if W then
    Result:= ' and ';
  W:= True;
end;

procedure TConsultaUsuariosFrm.btnBuscarClick(Sender: TObject);
var
  W: Boolean;
  VieneComa: Boolean;
begin
  if chkActivo.Checked or chkInactivo.Checked or chkBaja.Checked or chkError.Checked then
  begin
    FSQL:= 'select USR.USR_NOMBRE, USR.USR_APELLIDO, USR.USR_LOGON, USR.USR_ESTADO from USUARIO as USR';
    W:= False;

    if edtNombre.Text <> '' then
      FSQL:= FSQL + Where(W) + ' USR.USR_NOMBRE like ''%' + edtNombre.Text + '%''';

    if edtApellido.Text <> '' then
      FSQL:= FSQL + Where(W) + ' USR.USR_APELLIDO like ''%' + edtApellido.Text + '%''';

    if edtLogon.Text <> '' then
      FSQL:= FSQL + Where(W) + ' USR.USR_LOGON like ''%' + edtLogon.Text + '%''';

    FSQL:= FSQL + Where(W) + ' USR.USR_ESTADO in (';

    VieneComa:= False;
    if chkActivo.Checked then
    begin
      FSQL:= FSQL + '''AC''';
      VieneComa:= True;
    end;

    if chkInactivo.Checked then
    begin
      if VieneComa then
        FSQL:= FSQL + ',''IN'''
      else
      begin
        FSQL:= FSQL + '''IN''';
        VieneComa:= True;
      end;
    end;

    if chkBaja.Checked then
    begin
      if VieneComa then
        FSQL:= FSQL + ',''BA'''
      else
      begin
        FSQL:= FSQL + '''BA''';
        VieneComa:= True;
       end;
    end;

    if chkError.Checked then
    begin
      if VieneComa then
        FSQL:= FSQL + ',''ER'''
      else
      begin
        FSQL:= FSQL + '''ER''';
      end;
    end;

    FSQL:= FSQL + ' )';

    Consultar;
  end
  else
    ShowMessage('Primero debe seleccionar al menos un tipo estado de usuario');
end;


procedure TConsultaUsuariosFrm.FormShow(Sender: TObject);
begin
  FSQL:= '';
  FActualizar:= False;
  btnLimpiar.Click;
end;

procedure TConsultaUsuariosFrm.btnModificarClick(Sender: TObject);
var
  Us: TUsuario;

begin
  if ListView.SelCount > 0 then
  begin
    Us:= TUsuario.Create(ListView.Selected.Caption);
    FSeleccionado:= ListView.ItemIndex;
    if TSistema.GetInstance.UsuarioDB.GetUsuario(Us, CONS_USR_LOGON)then
    begin
      if Us.Logon = TSistema.GetInstance.GetUsuario.Logon then
        ShowMessage('No está permitido que un usuario administrador modifique sus propios datos')
      else if Us.Estado = USR_EST_BAJA then
        ShowMessage('No se puede modificar los datos de un usuario que ya está dado de baja')
      else
      begin
        Enabled:= False;
        UsuarioFrm.MainForm:= Self;
        UsuarioFrm.Operacion:= TModificacion.Create;
        UsuarioFrm.Usuario:= Us;
        UsuarioFrm.Show;
        FActualizar:= True;
      end;
    end;
  end
  else
    stbUsuario.SimpleText:= 'Debe seleccionar primero del listado el usuario que desea modificar';
end;

procedure TConsultaUsuariosFrm.btnBajaClick(Sender: TObject);
var
  Us: TUsuario;

begin
  if ListView.SelCount > 0 then
  begin
    Us:= TUsuario.Create(ListView.Selected.Caption);

    if TSistema.GetInstance.UsuarioDB.GetUsuario(Us, CONS_USR_LOGON)then
    begin
      if Us.Logon = TSistema.GetInstance.GetUsuario.Logon then
        ShowMessage('No está permitido que un usuario administrador se dé de baja a si mismo')
      else if Us.Estado = USR_EST_BAJA then
        ShowMessage('No se puede dar de baja al usuario debido a que el mismo ya está dado de baja')
      else
      begin
        Enabled:= False;
        UsuarioFrm.MainForm:= Self;
        UsuarioFrm.Operacion:= TBaja.Create;
        UsuarioFrm.Usuario:= Us;
        UsuarioFrm.Show;
        FActualizar:= True;
      end;
    end;
  end
  else
    stbUsuario.SimpleText:= 'Debe seleccionar primero del listado el usuario que desea dar de baja';
end;

procedure TConsultaUsuariosFrm.btnDetallesClick(Sender: TObject);
var
  Us: TUsuario;

begin
  if ListView.SelCount > 0 then
  begin
    Us:= TUsuario.Create(ListView.Selected.Caption);

    if TSistema.GetInstance.UsuarioDB.GetUsuario(Us, CONS_USR_LOGON)then
    begin
      Enabled:= False;
      UsuarioFrm.MainForm:= Self;
      UsuarioFrm.Operacion:= TDetalle.Create;
      UsuarioFrm.Usuario:= Us;
      UsuarioFrm.Show;
    end;
  end
  else
    stbUsuario.SimpleText:= 'Debe seleccionar primero del listado el usuario del cual desea ver todos sus datos';
end;

procedure TConsultaUsuariosFrm.btnDetallesEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Muestra todos los datos del usuario seleccionado';
end;

procedure TConsultaUsuariosFrm.btnVolverEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TConsultaUsuariosFrm.Actualizar;
begin
  Consultar;
end;

procedure TConsultaUsuariosFrm.Consultar;
begin
  stbUsuario.SimpleText:= 'Se está realizando la consulta solicitada, por favor aguarde unos segundos...';

  TSistema.GetInstance.UsuarioDB.Consulta(ListView, FSQL);

  with ListView do
  begin
    if Items.Count > 0 then
    begin
      stbUsuario.SimpleText:= 'Se encontraron ' + IntToStr(Items.Count) + ' usuarios que coinciden con el criterio de búsqueda ingresado';

      Enabled:= True;
      btnDetalles.Enabled:= True;
      btnModificar.Enabled:= True;
      btnBaja.Enabled:= True;
      if Items.Count <= FSeleccionado then
        ItemIndex:= Items.Count - 1
      else
        ItemIndex:= FSeleccionado;

      SetFocus;
    end
    else
    begin
      stbUsuario.SimpleText:= 'No se encontraron usuarios que coincidan con el criterio de búsqueda ingresado';
      btnDetalles.Enabled:= False;
      btnModificar.Enabled:= False;
      btnBaja.Enabled:= False;
      Clear;
      Enabled:= False;
      FSeleccionado:= -1;
    end;
  end;
end;

procedure TConsultaUsuariosFrm.btnTodosClick(Sender: TObject);
begin
  FSQL:= 'select USR_CODIGO, USR_NOMBRE, USR_APELLIDO, USR_LOGON ' +
         ', USR_ESTADO, USR_FECHA_ALTA, USR_FECHA_BAJA, PER_CODIGO ' +
         ' from USUARIO';

  Consultar;
end;

procedure TConsultaUsuariosFrm.FormActivate(Sender: TObject);
begin

  if FActualizar then
  begin
    ListView.Clear;
    Actualizar;
    FActualizar:= False;
  end;
end;


procedure TConsultaUsuariosFrm.edtNombreEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese el nombre completo o solo una parte';
end;

procedure TConsultaUsuariosFrm.edtApellidoEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese el apellido completo o solo una parte';
end;

procedure TConsultaUsuariosFrm.edtLogonEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese el nombre de usuario completo o solo una parte';
end;

procedure TConsultaUsuariosFrm.chkActivoEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Usuarios en estado Activo';
end;

procedure TConsultaUsuariosFrm.chkInactivoEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Usuarios en estado Inactivo';
end;

procedure TConsultaUsuariosFrm.chkBajaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Usuarios que hayan sido dados de baja';
end;

procedure TConsultaUsuariosFrm.chkErrorEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Usuarios erróneos';
end;

end.


