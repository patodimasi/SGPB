unit UInstructivos_SubinstructivosAprobarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,UDVarios, UMotorSql, DB, ADODB, UUtiles, ShlObj, USistema;

type
  TInstructivos_SubinstructivosAprobarFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    btnDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbInstructivos_Subinstructivos: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Instructivos_SubinstructivosAprobarFrm: TInstructivos_SubinstructivosAprobarFrm;

implementation

{$R *.dfm}
procedure TInstructivos_SubinstructivosAprobarFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVArios;
begin
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clred;
    showMessage('Debe ingresar el código correspondiente al Documento que desea Aprobar');
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
           'from INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS ' +
           'where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text) +
           ' and PLN_ESTADO = ''PA''';

    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Open;
    if self.ADODataSet1.Eof then
    begin
      self.edtCodigo.Color:= clRed;
      showMessage('El Código que ingresó no corresponde a ningun Documento en la base de datos');
      self.edtCodigo.Color:= clWindow;
      self.edtCodigo.SetFocus;
    end
    else
    begin
      self.edtDescripcion.Enabled:= True;
      self.edtUbicacion.Enabled:= True;
      self.btnConfirmar.Enabled:= True;
      Varios.CodigoDV:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
      Varios.DescripcionDV:= self.ADODataSet1.fieldByName('PLN_DESCRIPCION').AsString;
      Varios.UbicacionDv:= self.ADODataSet1.fieldByName('PLN_UBICACION').AsString;
      self.edtDescripcion.Text:= Varios.DescripcionDV;
      self.edtUbicacion.Text:= Varios.UbicacionDv;

      self.ADODataSet1.Open;
      self.ADODataSet1.Close;
    end;
      self.edtCodigo.Enabled:= true;
      self.btnConfirmar.Enabled:= true;
      self.edtDescripcion.Enabled:= False;
      self.edtUbicacion.Enabled:= false;
      self.btnBuscar.Enabled:= True;
      TMotorSql.GetInstance.GetConn;
 end;
end;

procedure TInstructivos_SubinstructivosAprobarFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TInstructivos_SubinstructivosAprobarFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text := '';
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

procedure TInstructivos_SubinstructivosAprobarFrm.btnDirClick(Sender: TObject);
var
 sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_DRIVES, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;
end;

procedure TInstructivos_SubinstructivosAprobarFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 usuario: string;
begin
  Usuario:= TSistema.getInstance.GetUsuario.Logon;
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQl:= 'update INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS '+
         ' set PLN_USUARIO_APR = ' + QuotedStr(usuario) +
         ', PLN_FECHA_APR = ' + QuotedStr(DateToStr(Date)) +
         ', PLN_ESTADO = ' +  QuotedStr('PR') +
         ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  ShowMessage('El Documento ' + Varios.CodigoDV + ' se aprobó satisfactoriamente');
  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
  else
  begin
    TMotorSQL.GetInstance.Rollback;
  end;
  sSQL:= 'update DOCUMENTOSVARIOS '+
         ' set PLN_USUARIO_APR = ' + QuotedStr(usuario) +
         ', PLN_FECHA_APR = ' + QuotedStr(DateToStr(Date)) +
         ', PLN_ESTADO = ' + QuotedStr('PR') +
         ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);

   TMotorSql.GetInstance.ExecuteSQL(sSQl);
   if TMotorSql.GetInstance.GetStatus = 0 then
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

end.
