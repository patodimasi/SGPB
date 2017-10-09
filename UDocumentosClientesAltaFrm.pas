unit UDocumentosClientesAltaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,  USistema, UDVarios, UMotorSql, ComCtrls, DB, ADODB,shlobj,UUtiles;

type
  TDocumentosClientesAltaFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    StbDocumentosClientes: TStatusBar;
    ADODataSet1: TADODataSet;
    lblNroRev: TLabel;
    edtNroRev: TEdit;
    lblNroEdic: TLabel;
    edtNroEdic: TEdit;
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure edtNroRevEnter(Sender: TObject);
    procedure edtNroEdicEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DocumentosClientesAltaFrm: TDocumentosClientesAltaFrm;

implementation

{$R *.dfm}

procedure TDocumentosClientesAltaFrm.btnConfirmarClick(Sender: TObject);
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
         ' from DOCUMENTOSCLIENTES' +
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

  //sSQL := 'insert into MATERIALES (PLN_FECHA,PLN_CODIGO) values ('+QuotedStr('27/11/2007')+','+QuotedStr('PEPA')+')';

//  sSQL:= 'insert into  MATERIALES (PLN_CODIGO,PLN_DESCRIPCION)'+
//         ' VALUES (%s,%s)';
//  sSql := Format(sSqr,[QuotedStr(Self.edtCodigol).Text,QuotedStr(Self.edtDescripcionl.Text)]);

  sSQL:= 'insert into  DOCUMENTOSCLIENTES (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA,PLN_NRO_REV,PLN_NRO_EDIC)'+
         ' VALUES ('+QuotedStr(Self.edtCodigo.Text)+','+QuotedStr(Self.edtDescripcion.Text)+','+QuotedStr('PR')+','+QuotedStr(self.edtUbicacion.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+','+QuotedStr(self.edtNroRev.Text)+','+QuotedStr(self.edtNroEdic.Text)+')';


            //    , [Formatear(P.Codigo), Formatear(P.Descripcion)]);
  TMotorSQL.GetInstance.OpenConn;

  TMotorSQL.GetInstance.ExecuteSQL(sSQL);
  ShowMessage('El Documento ' + Varios.CodigoDV + ' se dio de alta satisfactoriamente');

  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
    else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
   sSQL:= 'insert into DOCUMENTOSVARIOS  (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA,PLN_NRO_REV,PLN_NRO_EDIC)'+
           'VALUES ('+ QuotedStr(SELF.edtCodigo.Text)+','+QuotedStr(SELF.edtDescripcion.Text)+','+QuotedStr('PR')+','+QuotedStr(SELF.edtUbicacion.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+','+QuotedStr(self.edtNroRev.Text)+','+QuotedStr(self.edtNroEdic.Text)+')';
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
      Self.edtCodigo.Text := '';
      Self.edtDescripcion.Text := '';
      Self.edtUbicacion.Text := '';
      self.edtNroRev.Text:= '';
      self.edtNroEdic.Text:= '';
//  Self.GenerarCodigo;

end;
 end;

procedure TDocumentosClientesAltaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TDocumentosClientesAltaFrm.btnLimpiarClick(Sender: TObject);
begin
 self.edtDescripcion.Text:= '';
 self.edtUbicacion.Text:= '';
 self.edtCodigo.Text:= '';
 self.edtDescripcion.SetFocus;
 self.edtNroRev.Text:= '';
 self.edtNroEdic.Text:= '';
end;

procedure TDocumentosClientesAltaFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, edtUbicacion.Text);
  if sDir <> '' then
    edtUbicacion.Text:= sDir;

end;

procedure TDocumentosClientesAltaFrm.edtDescripcionEnter(Sender: TObject);
begin
  self.StbDocumentosClientes.SimpleText:= 'Ingrese una breve descripción del Documento';
end;

procedure TDocumentosClientesAltaFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.StbDocumentosClientes.SimpleText:= 'Ingrese la ubicación del archivo con el Documento';
end;

procedure TDocumentosClientesAltaFrm.btnDirEnter(Sender: TObject);
begin
  self.StbDocumentosClientes.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento';
end;

procedure TDocumentosClientesAltaFrm.edtNroRevEnter(Sender: TObject);
begin
  self.StbDocumentosClientes.SimpleText:= 'Ingrese el numero de revisión del Documento';
end;

procedure TDocumentosClientesAltaFrm.edtNroEdicEnter(Sender: TObject);
begin
  self.StbDocumentosClientes.SimpleText:= 'Ingrese el numero de Edición del Documento';
end;

procedure TDocumentosClientesAltaFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.StbDocumentosClientes.SimpleText:= 'Da de Alta el Documento en la base de datos';
end;

procedure TDocumentosClientesAltaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StbDocumentosClientes.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TDocumentosClientesAltaFrm.btnVolverEnter(Sender: TObject);
begin
  self.StbDocumentosClientes.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
