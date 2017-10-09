unit UEspecificacionesTecnicasAltaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, UDVarios, UMotorSQl, USistema, shlobj,UUtiles;

type
  TEspecificacionesTecnicasAltaFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lblNroRev: TLabel;
    edtNroRev: TEdit;
    lblNroEdic: TLabel;
    edtNroEdic: TEdit;
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
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure edtNroRevEnter(Sender: TObject);
    procedure edtNroEdicEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EspecificacionesTecnicasAltaFrm: TEspecificacionesTecnicasAltaFrm;

implementation

{$R *.dfm}

procedure TEspecificacionesTecnicasAltaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TEspecificacionesTecnicasAltaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtDescripcion.Text:= '';
  self.edtUbicacion.Text:= '';
  self.edtCodigo.Text:= '';
  self.edtDescripcion.SetFocus;
  self.edtNroRev.Text:= '';
  self.edtNroEdic.Text:= '';
end;

procedure TEspecificacionesTecnicasAltaFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL:string;
 UsuarioAlta:string;
 Varios:TDVarios;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  UsuarioAlta:= TSistema.getInstance.getUsuario.Logon;

  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'select PLN_CODIGO ' +
         ' from ESPECIFICACIONES_TECNICAS' +
         ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);
  self.ADODataSet1.CommandText:= sSQL;
  self.ADODataSet1.Close;
  self.ADODataSet1.Open;

  if self.ADODataSet1.RecordCount > 0 then
  begin
    ShowMessage('El Documento ya existe en la Base de Datos');
    self.edtCodigo.Color:= clwindow;
    self.edtCodigo.SetFocus;
  end
  else
  begin
    sSQL:= 'insert into  ESPECIFICACIONES_TECNICAS (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA,PLN_NRO_REV,PLN_NRO_EDIC)'+
           ' VALUES ('+QuotedStr(Self.edtCodigo.Text)+','+QuotedStr(Self.edtDescripcion.Text)+','+QuotedStr('PA')+','+QuotedStr(self.edtUbicacion.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+','+QuotedStr(self.edtNroRev.Text)+','+QuotedStr(self.edtNroEdic.Text)+')';

    TMotorSql.GetInstance.OpenConn;
    TMotorSql.GetInstance.ExecuteSQL(sSQL);
    ShowMessage('El Documento ' + Varios.CodigoDV + ' se dio de alta satisfactoriamente');

    if TMotorSQL.GetInstance.GetStatus = 0 then
    begin
      TMotorSQL.GetInstance.Commit;
    end
    else
    begin
      TMotorSQL.GetInstance.Rollback;
    end;
    sSQL:= 'insert into DOCUMENTOSVARIOS  (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA,PLN_NRO_REV,PLN_NRO_EDIC)'+
           'VALUES ('+ QuotedStr(self.edtCodigo.Text)+','+QuotedStr(SELF.edtDescripcion.Text)+','+QuotedStr('PA')+','+QuotedStr(SELF.edtUbicacion.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+','+QuotedStr(self.edtNroRev.Text)+','+QuotedStr(self.edtNroEdic.Text)+')';
    TMotorSql.GetInstance.ExecuteSQL(sSQL);
    if TMotorSql.GetInstance.GetStatus = 0 then
    begin
      TMotorSQL.GetInstance.Commit;
    end
    else
    begin
      TMotorSQL.GetInstance.Rollback;
    end;

      TMotorSQL.GetInstance.CloseConn;
      TMotorSQL.GetInstance.CloseConn;
      Self.edtCodigo.Text := '';
      Self.edtDescripcion.Text := '';
      Self.edtUbicacion.Text := '';
      self.edtNroRev.Text:= '';
      self.edtNroEdic.Text:= '';
  end;
 end;

procedure TEspecificacionesTecnicasAltaFrm.btnDirClick(Sender: TObject);
var
 sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, edtUbicacion.Text);
  if sDir <> '' then
    edtUbicacion.Text:= sDir;

end;

procedure TEspecificacionesTecnicasAltaFrm.edtDescripcionEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Ingrese una breve descripción del documento';
end;

procedure TEspecificacionesTecnicasAltaFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Ingrese la ubicación del archivo con el documento';
end;

procedure TEspecificacionesTecnicasAltaFrm.edtNroRevEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Ingrese el numero de revisión del documento';
end;

procedure TEspecificacionesTecnicasAltaFrm.edtNroEdicEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Ingrese el numero de edición del documento';
end;

procedure TEspecificacionesTecnicasAltaFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Da de alta el documento en la base de datos'
end;

procedure TEspecificacionesTecnicasAltaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TEspecificacionesTecnicasAltaFrm.btnVolverEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TEspecificacionesTecnicasAltaFrm.btnDirEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Seleccione la carpeta donde se encuentra el documento';
end;

end.
