unit USubinstructivosProdRecibirFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB,UDVARIOS, USistema, UMotorSQL;

type
  TRecibirSubinstructivosProdFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblDescrpcion: TLabel;
    edtDescripcion: TEdit;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbSubinstructivosProd: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecibirSubinstructivosProdFrm: TRecibirSubinstructivosProdFrm;

implementation

{$R *.dfm}

procedure TRecibirSubinstructivosProdFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TRecibirSubinstructivosProdFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtCodigo.Enabled:= True;
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

procedure TRecibirSubinstructivosProdFrm.btnBuscarClick(Sender: TObject);
var
 sSql: string;
 Varios: TDVarios;
begin
 if self.edtCodigo.Text = '' then
 begin
   self.edtCodigo.Color:= clred;
   showMessage('Debe ingresar el código correspondiente al Documento que desea Recibir');
   self.edtCodigo.Color:= clWindow;
   self.edtCodigo.SetFocus;
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
          'from SUBINSTRUCTIVOSPRODUCCION ' +
          'where PLN_CODIGO = ' + QuotedStr(self.edtcodigo.Text) +
          ' and PLN_ESTADO = ''PR''';

   self.ADODataSet1.CommandText:= sSQL;
   self.ADODataSet1.Open;

   if self.ADODataSet1.Eof then
   begin
     self.edtCodigo.Color:= clred;
     showMessage('El Código que ingresó no corresponde a ningun Documento en la base de datos');
     self.edtCodigo.Color:= clwindow;
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
     self.edtUbicacion.Text:= Varios.DescripcionDV;

     self.ADODataSet1.Open;
     self.ADODataSet1.Close;

   end;
     self.edtCodigo.Enabled:= True;
     self.btnConfirmar.Enabled:= True;
     self.edtDescripcion.Enabled:= False;
     self.edtUbicacion.Enabled:= False;
     self.btnBuscar.Enabled:= True;

     TMotorSql.GetInstance.CloseConn;
   end;
 end;

procedure TRecibirSubinstructivosProdFrm.btnConfirmarClick(Sender: TObject);
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

  sSQL:= 'update SUBINSTRUCTIVOSPRODUCCION ' +
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

    self.edtCodigo.Text:= '';
    self.edtDescripcion.Text:= '';
    self.edtUbicacion.Text:= '';
    TMotorSql.GetInstance.CloseConn;
end;
procedure TRecibirSubinstructivosProdFrm.edtCodigoEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:=  'Ingrese el código del Documento a Recibir';
end;

procedure TRecibirSubinstructivosProdFrm.btnBuscarEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Busca el codigo del Documento ingresado en la base de datos';
end;

procedure TRecibirSubinstructivosProdFrm.edtUbicacionEnter(Sender:TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Ingrese la ubicacion del archivo con el Documento';
end;

procedure TRecibirSubinstructivosProdFrm.btnDirEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento';
end;

procedure TRecibirSubinstructivosProdFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbSubinstructivosProd.SimpleText:= 'Recibe el Documento especificado';
end;

end.
