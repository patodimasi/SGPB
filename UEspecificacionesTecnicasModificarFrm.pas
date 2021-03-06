unit UEspecificacionesTecnicasModificarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ComCtrls,UDVarios, USistema, UMotorSql,UUtiles,ShlObj;

type
  TEspecificacionesTecnicasModificarFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    ADODataSet1: TADODataSet;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    StbEspTec: TStatusBar;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EspecificacionesTecnicasModificarFrm: TEspecificacionesTecnicasModificarFrm;

implementation

{$R *.dfm}

procedure TEspecificacionesTecnicasModificarFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TEspecificacionesTecnicasModificarFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
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

procedure TEspecificacionesTecnicasModificarFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 Ret: boolean;
begin
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clred;
    ShowMessage('Debe ingresar el c�digo correspondiente al Documento que desea Modificar');
    self.edtCodigo.Color:= clWindow;
    self.edtCodigo.SetFocus;
  end
  else
  begin
    self.edtCodigo.Text:= UpperCase(self.edtCodigo.Text);
    Varios:= TDVarios.Create;
    Varios.CodigoDV:= self.edtCodigo.Text;
    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
    TMotorSql.GetInstance.OpenConn;
    sSQL:= 'select PLN_CODIGO ' +
           ', PLN_DESCRIPCION ' +
           ', PLN_UBICACION ' +
           ' from ESPECIFICACIONES_TECNICAS' +
           ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);

    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Open;
    if (Self.ADODataSet1.Eof) then
    Begin
      self.edtCodigo.Color:= clRed;
      showMessage('El C�digo que ingres� no corresponde a ningun Documento en la base de datos');
      self.edtCodigo.Color:= clWindow;
      self.edtCodigo.SetFocus;
    end
    else
    begin
      Self.edtDescripcion.Enabled := True;
      Self.edtUbicacion.Enabled := True;
      Self.btnConfirmar.Enabled := True;
      Varios.CodigoDV:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
      Varios.DescripcionDV:= self.ADODataSet1.fieldByName('PLN_DESCRIPCION').AsString;
      Varios.UbicacionDv:= self.ADODataSet1.fieldByName('PLN_UBICACION').AsString;
      self.edtDescripcion.Text:= Varios.DescripcionDV;
      self.edtUbicacion.Text:= Varios.UbicacionDv;
      self.edtDescripcion.SetFocus;
      self.ADODataSet1.Open;
      self.ADODataSet1.Close;
      self.edtCodigo.Color:= clWindow;
    end;
     TMotorSql.GetInstance.CloseConn;
   end;
 end;



procedure TEspecificacionesTecnicasModificarFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 UsuarioV: string;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  Varios.DescripcionDV:= self.edtDescripcion.Text;
  Varios.UbicacionDv:= self.edtUbicacion.Text;
  UsuarioV:= TSistema.getInstance.getUsuario.Logon;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'update ESPECIFICACIONES_TECNICAS ' +
         'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripcion.Text) +
         ', PLN_UBICACION =  '  +  QuotedStr(self.edtUbicacion.Text) +
         ', USUARIO_MODIF = ' + QuotedStr(UsuarioV) +
         ', FECHA_MODIF = ' + QuotedStr(DateToStr(Date)) +
         'where PLN_CODIGO =  ' +  QuotedStr(self.edtCodigo.Text);

 TMotorSql.GetInstance.ExecuteSQL(sSQL);
 if TMotorSQL.GetInstance.GetStatus = 0 then
 begin
   TMotorSql.GetInstance.Commit;
 end
 else
 Begin
   TMotorSQL.GetInstance.Rollback;
 end;
    sSQL:= 'update DOCUMENTOSVARIOS ' +
           'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripcion.Text)+
           ', PLN_UBICACION = ' + QuotedStr(self.edtUbicacion.Text) +
           ', USUARIO_MODIF = ' + QuotedStr(UsuarioV) +
           ', FECHA_MODIF = ' + QuotedStr(DateToStr(Date)) +
           'where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);

    TMotorSql.GetInstance.ExecuteSQL(sSQL);
    if TMotorSQL.GetInstance.GetStatus = 0 then
    begin
      TMotorSQL.GetInstance.Commit;
    end
    else
    begin
      TMotorSQl.GetInstance.Rollback;
    end;
      ShowMessage('El Documento ' + Varios.CodigoDV + ' se modifico satisfactoriamente');
      self.edtCodigo.Text:= '';
      self.edtDescripcion.Text:= '';
      self.edtUbicacion.Text:= '';

      TMotorSql.GetInstance.CloseConn;
end;

procedure TEspecificacionesTecnicasModificarFrm.btnDirClick(
  Sender: TObject);
 var
 sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;

end;

end.
