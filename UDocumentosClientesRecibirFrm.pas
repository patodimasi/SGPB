unit UDocumentosClientesRecibirFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, USistema,UDVarios, UMotorSql,UUtiles,ShlObj;

type
  TRecibirDocumentosClientesFrm = class(TForm)
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
    StatusBar1: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnVolverClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecibirDocumentosClientesFrm: TRecibirDocumentosClientesFrm;

implementation

{$R *.dfm}

procedure TRecibirDocumentosClientesFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TRecibirDocumentosClientesFrm.btnBuscarClick(Sender: TObject);
var
 sSql: string;
 Varios: TDVarios;
begin
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clred;
    showMessage('Debe ingresar el código correspondiente al Documento que desea Recibir');
    self.edtCodigo.Color:= clwindow;
    self.edtCodigo.SetFocus;
  end
  else
  begin
    self.edtCodigo.Text:= UpperCase(self.edtCodigo.Text);
    Varios:= TDVarios.Create;
    Varios.CodigoDV:= self.edtCodigo.Text;

    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
    TMotorSql.GetInstance.OpenConn;

    sSql:= 'select PLN_CODIGO ' +
            ',PLN_DESCRIPCION ' +
            ',PLN_ESTADO ' +
            ',PLN_UBICACION ' +
            'from DOCUMENTOSCLIENTES ' +
            'where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text) +
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
      Varios.CodigoDV:= self.ADODataSet1.fieldbyname('PLN_CODIGO').AsString;
      Varios.DescripcionDV:= self.ADODataSet1.fieldbyname('PLN_DESCRIPCION').AsString;
      Varios.UbicacionDv:= self.ADODataSet1.fieldbyname('PLN_UBICACION').AsString;

      self.edtDescripcion.Text:= Varios.DescripcionDV;
      self.edtUbicacion.Text:= Varios.UbicacionDv;

      self.ADODataSet1.Open;
      self.ADODataSet1.Close;

    end;
      self.edtCodigo.Enabled:= True;
      self.btnConfirmar.Enabled:= True;
      self.edtDescripcion.Enabled:= False;
      self.edtUbicacion.Enabled:= False;
      self.btnbuscar.Enabled:= True;

      TMotorSql.GetInstance.CloseConn;

  end;
 end;

procedure TRecibirDocumentosClientesFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtCodigo.Enabled:= True;
  self.btnbuscar.Enabled:= True;
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

procedure TRecibirDocumentosClientesFrm.btnConfirmarClick(Sender: TObject);
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

  sSQL:= 'update DOCUMENTOSCLIENTES ' +
         'set PLN_USUARIO_REC = ' + QuotedStr(usuario) +
         ', PLN_FECHA_REC = ' + QuotedStr(DateToStr(Date)) +
         ', PLN_ESTADO = ' + QuotedStr('AC') +
         ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);

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
     self.edtUbicacion.Text:='';
     TMotorSql.GetInstance.CloseConn;
 end;

procedure TRecibirDocumentosClientesFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_DRIVES, self.edtUbicacion.Text);
  if sDir <> '' then
    edtUbicacion.Text:= sDir;
end;

end.
