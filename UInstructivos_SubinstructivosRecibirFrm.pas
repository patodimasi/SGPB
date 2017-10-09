unit UInstructivos_SubinstructivosRecibirFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, UDVarios, USistema, UMotorSql,UUtiles,ShlObj;

type
  TInstructivos_SubinstructivosRecibirFrm = class(TForm)
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
    stbInstructivos_Subinstructivos: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Instructivos_SubinstructivosRecibirFrm: TInstructivos_SubinstructivosRecibirFrm;

implementation

{$R *.dfm}

procedure TInstructivos_SubinstructivosRecibirFrm.btnBuscarClick(Sender: TObject);
var
 sSql: string;
 Varios: TDVarios;
begin
  if self.edtcodigo.Text = '' then
  begin
    self.edtcodigo.Color:= clred;
    showMessage('Debe ingresar el código correspondiente al Documento que desea Recibir');
    self.edtcodigo.Color:= clwindow;
    self.edtcodigo.SetFocus;
  end
  else
  begin
    self.edtcodigo.Text:= UpperCase(self.edtcodigo.Text);
    Varios:= TDVarios.Create;
    Varios.CodigoDV:= self.edtCodigo.Text;
    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
    TMotorSql.GetInstance.OpenConn;

    sSql:= 'select PLN_CODIGO ' +
            ',PLN_DESCRIPCION ' +
            ',PLN_ESTADO ' +
            ',PLN_UBICACION ' +
            'from INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS ' +
            'where PLN_CODIGO = ' + QuotedStr(self.edtcodigo.Text) +
            ' and PLN_ESTADO = ''PR''';

    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Open;
    if self.ADODataSet1.Eof then
    begin
      self.edtcodigo.Color:= clred;
      showMessage('El Código que ingresó no corresponde a ningun Documento en la base de datos');
      self.edtcodigo.Color:= clwindow;
      self.edtcodigo.SetFocus;
    end
    else
    begin
      self.edtDescripcion.Enabled:= true;
      self.edtUbicacion.Enabled:= true;
      self.btnConfirmar.Enabled:= true;
      Varios.CodigoDV:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
      Varios.DescripcionDV:= self.ADODataSet1.fieldByName('PLN_DESCRIPCION').AsString;
      Varios.UbicacionDv:= self.ADODataSet1.fieldByName('PLN_UBICACION').AsString;

      self.edtDescripcion.Text:= Varios.DescripcionDV;
      self.edtUbicacion.Text:= Varios.UbicacionDv;

      self.ADODataSet1.Open;
      self.ADODataSet1.Close;

    end;
      self.edtcodigo.Enabled:= true;
      self.btnConfirmar.Enabled:= true;
      self.edtDescripcion.Enabled:= false;
      self.edtUbicacion.Enabled:= false;
      self.btnBuscar.Enabled:= true;

      TMotorSql.GetInstance.CloseConn;
  end;
 end;
procedure TInstructivos_SubinstructivosRecibirFrm.btnDirClick(Sender: TObject);
var
 sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_DRIVES, edtUbicacion.Text);
  if sDir <> '' then
    edtUbicacion.Text:= sDir;
end;

procedure TInstructivos_SubinstructivosRecibirFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TInstructivos_SubinstructivosRecibirFrm.btnLimpiarClick(Sender: TObject);
begin
   self.edtcodigo.Enabled:= true;
  self.btnBuscar.Enabled:= true;
  self.edtDescripcion.Enabled:= false;
  self.edtDescripcion.Text:= '';
  self.edtDescripcion.TabStop:= false;
  self.edtUbicacion.Text:= '';
  self.edtUbicacion.TabStop:= false;
  self.edtUbicacion.Enabled:= false;
  self.btnDir.Enabled:= false;
  self.btnConfirmar.Enabled:= false;
  self.edtcodigo.SetFocus;
end;

procedure TInstructivos_SubinstructivosRecibirFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 usuario: string;
begin
  usuario:= TSistema.getInstance.getUsuario.Logon;
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TmotorSql.getInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'update INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS ' +
          'set PLN_USUARIO_REC = ' + QuotedStr(usuario) +
          ', PLN_FECHA_REC = ' + QuotedStr(DateToStr(Date)) +
          ', PLN_ESTADO = ' + QuotedStr('AC') +
          ' where PLN_CODIGO = ' + QuotedStr(self.edtcodigo.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  ShowMessage('El Documento ' + Varios.CodigoDV + ' se recibió satisfactoriamente');
  if TMotorSql.GetInstance.GetStatus = 0 then
  begin
    TMotorSql.GetInstance.Commit;
  end
  else
  begin
    TMotorSql.GetInstance.Rollback;
  end;
  sSQL:= 'update DOCUMENTOSVARIOS ' +
         'set PLN_USUARIO_REC = ' + QuotedStr(usuario) +
         ', PLN_FECHA_REC = ' + QuotedStr(DateToStr(Date)) +
         ', PLN_ESTADO = ' + QuotedStr('AC') +
         ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);

   TMotorSql.GetInstance.ExecuteSQL(sSQL);
   if TMotorSql.GetInstance.GetStatus = 0 then
   begin
     TMotorSql.GetInstance.Commit;
   end
   else
   begin
     TMotorSql.GetInstance.Rollback;
   end;    
    self.edtcodigo.Text:= '';
    self.edtDescripcion.Text:= '';
    self.edtUbicacion.Text:= '';

    TMotorSql.GetInstance.CloseConn;
 end;

end.
