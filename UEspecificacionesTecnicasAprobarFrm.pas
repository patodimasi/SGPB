unit UEspecificacionesTecnicasAprobarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB ,UDVarios, USistema, UMotorSql,UUtiles, ShlObj;

type
  TEspecificacionesTecnicasAprobarFrm = class(TForm)
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
    StbEspTec: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EspecificacionesTecnicasAprobarFrm: TEspecificacionesTecnicasAprobarFrm;

implementation

{$R *.dfm}

procedure TEspecificacionesTecnicasAprobarFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TEspecificacionesTecnicasAprobarFrm.btnLimpiarClick(Sender: TObject);
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

procedure TEspecificacionesTecnicasAprobarFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
begin
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clRed;
    showMessage('Debe ingresar el c�digo correspondiente al Documento que desea Aprobar');
    self.edtCodigo.Color:= clWindow;
    self.edtCodigo.SetFocus;
  end
  else
  begin
    self.edtCodigo.Text:= UpperCase(self.edtCodigo.Text);
    Varios:= TDVarios.Create;
    Varios.CodigoDV:= self.edtCodigo.Text;

    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.getInstance.GetConn;
    TMotorSql.GetInstance.OpenConn;

    sSQL:= 'select PLN_CODIGO ' +
           ',PLN_DESCRIPCION ' +
           ',PLN_ESTADO ' +
           ',PLN_UBICACION ' +
           'from ESPECIFICACIONES_TECNICAS ' +
           'where PLN_CODIGO = ' + QuotedStr(SELF.edtCodigo.Text) +
           ' and PLN_ESTADO = ''PA''';

    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Open;

    if self.ADODataSet1.Eof then
    begin
      self.edtCodigo.Color:= clRed;
      showMessage('El C�digo que ingres� no corresponde a ningun Documento en la base de datos');
      self.edtCodigo.Color:= clWindow;
       self.edtCodigo.SetFocus;
    end
    else
    begin
     self.edtDescripcion.Enabled:= True;
     self.edtUbicacion.Enabled:= True;
     self.btnConfirmar.Enabled:= True;
     Varios.CodigoDV:= self.ADODataSet1.fieldbyName('PLN_CODIGO').AsString;
     Varios.DescripcionDV:= self.ADODataSet1.fieldByName('PLN_DESCRIPCION').AsString;
     Varios.UbicacionDv:= self.ADODataSet1.fieldByName('PLN_UBICACION').AsString;

     self.edtDescripcion.Text:= Varios.DescripcionDV;
     self.edtUbicacion.Text:= Varios.UbicacionDv;
     self.ADODataSet1.Open;
     self.ADODataSet1.Close;
    end;
     self.edtCodigo.Enabled:= True;
     self.btnConfirmar.Enabled:= True;
     self.edtDescripcion.Enabled:= False;
     self.edtUbicacion.Enabled:= False;
     self.btnBuscar.Enabled:= True;
     TMotorSql.GetInstance.GetConn;
 end;
end;

procedure TEspecificacionesTecnicasAprobarFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 usuario: string;
begin
  Usuario:= TSistema.getInstance.GetUsuario.Logon;
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;

  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.getInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQl:= 'update ESPECIFICACIONES_TECNICAS '+
         ' set PLN_USUARIO_APR = ' + QuotedStr(usuario) +
         ', PLN_FECHA_APR = ' + QuotedStr(DateToStr(Date)) +
         ', PLN_ESTADO = ' +  QuotedStr('PR') +
         ' where PLN_CODIGO = ' + QuotedStr(SELF.edtCodigo.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  ShowMessage('El Documento ' + Varios.CodigoDV + ' se aprob� satisfactoriamente');
  if TMotorSql.GetInstance.GetStatus = 0 then
  begin
    TMotorSql.GetInstance.Commit;
  end
  else
  Begin
    TMotorSql.GetInstance.Rollback;
  end;
  sSQL:= 'update DOCUMENTOSVARIOS ' +
         ' set PLN_USUARIO_APR = ' + QuotedStr(usuario) +
         ', PLN_FECHA_APR = ' + QuotedStr(DateToStr(Date)) +
         ', PLN_ESTADO = ' + QuotedStr('PR') +
         'Where PLN_CODIGO = ' + QuotedStr(SELF.edtCodigo.Text);

  TMotorSQL.GetInstance.ExecuteSQL(sSQL);
  if TMotorSql.GetInstance.GetStatus = 0  then
  begin
    TMotorSql.GetInstance.Commit;
  end
  else
  begin
    TMotorSql.GetInstance.Rollback;
  end;
    self.edtCodigo.Text:= '';
    self.edtDescripcion.Text:= '';
    self.edtUbicacion.Text:= '';

    TMotorSql.GetInstance.CloseConn;
end;

procedure TEspecificacionesTecnicasAprobarFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_DRIVES, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;
end;

procedure TEspecificacionesTecnicasAprobarFrm.edtCodigoEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Ingrese el c�digo del Documento a Aprobar'
end;

procedure TEspecificacionesTecnicasAprobarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Busca el c�digo del Documento ingresado en la base de datos'
end;

procedure TEspecificacionesTecnicasAprobarFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Ingrese la ubicaci�n del archivo con el Documento';
end;

procedure TEspecificacionesTecnicasAprobarFrm.btnDirEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento'
end;

procedure TEspecificacionesTecnicasAprobarFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Aprueba el Documento ingresado'
end;

procedure TEspecificacionesTecnicasAprobarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TEspecificacionesTecnicasAprobarFrm.btnVolverEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
