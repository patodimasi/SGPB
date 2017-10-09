unit UInstructivosProdAprobarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, UDVarios, USistema, UMotorSql,UUtiles, ShlObj;

type
  TInstructivosProdAprobarFrm = class(TForm)
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
    stbInstructivosProd: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
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
  InstructivosProdAprobarFrm: TInstructivosProdAprobarFrm;

implementation

{$R *.dfm}

procedure TInstructivosProdAprobarFrm.btnLimpiarClick(Sender: TObject);
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

procedure TInstructivosProdAprobarFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
begin
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clRed;
    showMessage('Debe ingresar el código correspondiente al Documento que desea Aprobar');
    self.edtCodigo.Color:= clWindow;
    self.edtCodigo.SetFocus;
  end
  else
  begin
    //self.edtCodigol.Text:= UpperCase(self.edtCodigol.Text);
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
           'from INSTRUCTIVOSPRODUCCION ' +
           'where PLN_CODIGO = ' + QuotedStr(SELF.edtCodigo.Text) +
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
procedure TInstructivosProdAprobarFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TInstructivosProdAprobarFrm.btnConfirmarClick(Sender: TObject);
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

  sSQl:= 'update INSTRUCTIVOSPRODUCCION '+
         ' set PLN_USUARIO_APR = ' + QuotedStr(usuario) +
         ', PLN_FECHA_APR = ' + QuotedStr(DateToStr(Date)) +
         ', PLN_ESTADO = ' +  QuotedStr('PR') +
         ' where PLN_CODIGO = ' + QuotedStr(SELF.edtCodigo.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  ShowMessage('El Documento ' + Varios.CodigoDV + ' se aprobó satisfactoriamente');
  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
  else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
  sSQL:= 'update DOCUMENTOSVARIOS ' +
         ' set PLN_USUARIO_APR = ' + QuotedStr(usuario) +
         ', PLN_FECHA_APR = ' + QuotedStr(DateToStr(Date)) +
         ', PLN_ESTADO = ' + QuotedStr('PR') +
         'Where PLN_CODIGO = ' + QuotedStr(SELF.edtCodigo.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  if TMotorSql.GetInstance.GetStatus = 0 then
  begin
    TmotorSQl.GetInstance.Commit;
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

procedure TInstructivosProdAprobarFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_DRIVES, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;
end;

procedure TInstructivosProdAprobarFrm.edtCodigoEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Ingrese el código del Documento a Aprobar';
end;

procedure TInstructivosProdAprobarFrm.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Ord(Key) = 13 then
    self.btnBuscar.Click;
end;

procedure TInstructivosProdAprobarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Busca el código del Documento ingresado en la base de datos';
end;

procedure TInstructivosProdAprobarFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Ingrese la ubicación del archivo con el Documento';
end;

procedure TInstructivosProdAprobarFrm.btnDirEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento';
end;

procedure TInstructivosProdAprobarFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Aprueba el Documento ingresado';
end;

procedure TInstructivosProdAprobarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TInstructivosProdAprobarFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbInstructivosProd.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
