unit UPassFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls, UUsuario, ComCtrls, UOperacion;

const
  MIN_LEN_PASS = 6;


type
  TPassFrm = class(TForm)
    btnVolver: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    stbUsuario: TStatusBar;
    lblUser: TLabel;
    lblAnterior: TLabel;
    edtUser: TEdit;
    edtAnterior: TEdit;
    lblNueva: TLabel;
    edtNueva: TEdit;
    lblRepetir: TLabel;
    edtRepetir: TEdit;
    btnBuscar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure edtUserEnter(Sender: TObject);
    procedure edtAnteriorEnter(Sender: TObject);
    procedure edtNuevaEnter(Sender: TObject);
    procedure edtRepetirEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);

  private
    FOperacion: TOperacion;
    FMainForm: TForm;
    procedure Preparar;
    function SonDatosValidos: Boolean;

  published
    property Operacion: TOperacion read FOperacion write FOperacion;
    property MainForm: TForm read FMainForm write FMainForm;    
  end;

var
  PassFrm: TPassFrm;

implementation
uses
  UUsuarioDB, USistema, UCambiarPass, URestablecerPass, Graphics, UUtiles;

{$R *.dfm}

procedure TPassFrm.FormShow(Sender: TObject);
begin
  Preparar;
end;

procedure TPassFrm.btnVolverClick(Sender: TObject);
begin
  FOperacion.Free;
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TPassFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TPassFrm.Preparar;
begin
  if Operacion is TCambiarPass then
  begin
    Caption:= 'Cambiar Contraseña';
    stbUsuario.SimpleText:= '';
    lblUser.Enabled:= True;
    edtUser.Enabled:= True;
    edtUser.Text:= '';
    lblAnterior.Enabled:= True;
    edtAnterior.PasswordChar:= '*';
    edtAnterior.Enabled:= True;
    edtAnterior.Text:= '';
    lblNueva.Enabled:= True;
    edtNueva.Enabled:= True;
    edtNueva.Text:= '';
    lblRepetir.Enabled:= True;
    edtRepetir.Enabled:= True;
    edtRepetir.Text:= '';
    btnBuscar.Visible:= False;
    btnConfirmar.Enabled:= True;
    edtUser.SetFocus;
  end
  else if Operacion is TRestablecerPass then
  begin
    Caption:= 'Restablecer Contraseña';
    stbUsuario.SimpleText:= '';
    lblUser.Enabled:= True;
    edtUser.Enabled:= True;
    edtUser.Text:= '';
    lblAnterior.Enabled:= False;
    edtAnterior.PasswordChar:= '*';
    edtAnterior.Enabled:= False;
    edtAnterior.Text:= '';
    lblNueva.Enabled:= False;
    edtNueva.Enabled:= False;
    edtNueva.Text:= '';
    lblRepetir.Enabled:= False;
    edtRepetir.Enabled:= False;
    edtRepetir.Text:= '';
    btnBuscar.Visible:= True;
    btnBuscar.Enabled:= True;
    btnConfirmar.Enabled:= False;
    edtUser.SetFocus;
  end;

end;

procedure TPassFrm.btnConfirmarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Cambiar la contraseña anterior del usuario por la nueva';
end;

procedure TPassFrm.btnLimpiarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TPassFrm.btnVolverEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TPassFrm.btnLimpiarClick(Sender: TObject);
begin
  Preparar;
end;

procedure TPassFrm.edtUserEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese el nombre de usuario';
end;

procedure TPassFrm.edtAnteriorEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese la contraseña anterior del usuario';
end;

procedure TPassFrm.edtNuevaEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Ingrese la nueva contraseña del usuario';
end;

procedure TPassFrm.edtRepetirEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Por favor, repita la nueva contraseña del usuario';
end;

procedure TPassFrm.btnBuscarEnter(Sender: TObject);
begin
  stbUsuario.SimpleText:= 'Determina si el usuario existe en la base de datos';
end;

procedure TPassFrm.btnBuscarClick(Sender: TObject);
var
  U: TUsuario;
  Valido: Boolean;

begin
  Valido:= True;
  U:= TUsuario.Create;

  if edtUser.Text = '' then
  begin
    edtUser.Color:= clYellow;
    ShowMessage('Debe completar el campo "Usuario", el mismo es obligatorio');
    edtUser.Color:= clWindow;
    edtUser.SetFocus;
    Valido:= False;
  end;

  if Valido then
  begin
    U.Logon:= edtUser.Text;

    if not TSistema.GetInstance.UsuarioDB.GetUsuario(U, CONS_USR_LOGON) then
    begin
      edtUser.Color:= clYellow;
      ShowMessage('El usuario ingresado no existe en la base de datos');
      edtUser.Color:= clWindow;
      edtUser.SetFocus;
    end
    else
    begin
      lblUser.Enabled:= False;
      edtUser.Enabled:= False;
      edtAnterior.PasswordChar:= #0;
      edtAnterior.Text:= U.Pass;
      lblNueva.Enabled:= True;
      edtNueva.Enabled:= True;
      lblRepetir.Enabled:= True;
      edtRepetir.Enabled:= True;
      btnBuscar.Enabled:= False;
      btnConfirmar.Enabled:= True;
      edtNueva.SetFocus;
    end;
  end;
  U.Free;

end;

procedure TPassFrm.btnConfirmarClick(Sender: TObject);
var
  Usuario, PassAnt, PassNue: string;
begin
  if SonDatosValidos then
    if MessageDlg('¿ Esta seguro que desea modificar la contraseña del usuario ?', mtConfirmation, mbOKCancel, 0) = mrOK then
    begin
      Usuario:= edtUser.Text;
      PassAnt:= edtAnterior.Text;
      PassNue:= edtNueva.Text;

      if TSistema.GetInstance.UsuarioDB.CambiarPass(Usuario, PassAnt, PassNue) then
      begin
        ShowMessage('Al usuario ' + Usuario + ' se le modificó la contraseña satisfactoriamente');
        btnVolver.Click;
      end
      else
        ShowMessage('No se le pudo modificar la contraseña al usuario');
    end;
end;

function TPassFrm.SonDatosValidos: Boolean;
var
  CodRet: Boolean;
  sNueva, sRepetir: string;
  U: TUsuario;
  Ret: Integer;

begin
  CodRet:= True;
  sNueva:= Trim(edtNueva.Text);
  sRepetir:= Trim(edtRepetir.Text);

  if edtUser.Text = '' then
    CodRet:= InformarDatoInvalido(edtUser, 'Debe ingresar el Usuario')
  else if edtAnterior.Text = '' then
    CodRet:= InformarDatoInvalido(edtAnterior, 'Debe ingresar la Contraseña Anterior del usuario')
  else if sNueva = '' then
    CodRet:= InformarDatoInvalido(edtNueva, 'Debe ingresar la Nueva Contraseña para el usuario')
  else if Length(sNueva) < MIN_LEN_PASS then
    CodRet:= InformarDatoInvalido(edtNueva, 'La Nueva Contraseña no puede tener menos de ' + IntToStr(MIN_LEN_PASS) + ' caracteres')
  else if sRepetir = '' then
    CodRet:= InformarDatoInvalido(edtRepetir, 'Debe ingresar la verificación de la Nueva Contraseña')
  else if Length(sRepetir) < MIN_LEN_PASS then
    CodRet:= InformarDatoInvalido(edtRepetir, 'La verficación de la Nueva Contraseña no puede tener menos de ' + IntToStr(MIN_LEN_PASS) + ' caracteres')
  else if sNueva <> sRepetir then
    CodRet:= InformarDatoInvalido(edtNueva, 'La contraseña nueva y la contraseña nueva re-ingresada como verificación no coinciden')
  else
  begin
    U:= TUsuario.Create;
    U.Logon:= UpperCase(edtUser.Text);
    U.Pass:= edtAnterior.Text;
    Ret:= TSistema.GetInstance.UsuarioDB.ConsultarLogon(U);

    if Ret = USER_INVALID then
      CodRet:= InformarDatoInvalido(edtUser, 'El usuario ingresado no es válido.')
    else if Ret = PASS_INVALID then
      CodRet:= InformarDatoInvalido(edtAnterior, 'La contraseña ingresada no es correcta.');

    U.Free;
  end;

  Result:= CodRet;
end;


end.
