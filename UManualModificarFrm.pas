unit UManualModificarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UManuales, DB, ADODB, UMotorSql, USistema, UUtiles,ShlObj, UPantallaFrm;

type
  TManualModificarFrm = class(TPantallaFrm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblUbicacion: TLabel;
    edtUbicacion: TEdit;
    btnDir: TButton;
    btnconfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbManual: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnVolverClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnconfirmarClick(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure btnconfirmarEnter(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    //procedure FormShow(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);

  private
    //procedure LockScreen;
    //procedure UnLockScreen;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManualModificarFrm: TManualModificarFrm;

implementation

{$R *.dfm}
{procedure TManualModificarFrm.LockScreen;
begin
  self.lblCodigo.Enabled:= False;
  self.edtCodigo.Enabled:= False;
  self.edtCodigo.Text:= '';
  self.lblDescripcion.Enabled:= False;
  self.edtDescripcion.Enabled:= False;
  self.edtDescripcion.Text:= '';
  self.lblUbicacion.Enabled:= False;
  self.edtUbicacion.Enabled:= False;
  self.edtUbicacion.Text:= '';
  self.btnDir.Enabled:= False;
  self.btnBuscar.Visible:= False;
  self.btnLimpiar.Visible:= False;
  self.btnconfirmar.Visible:= False;
  self.btnVolver.SetFocus;
end;
procedure TManualModificarFrm.UnLockScreen;
begin
  self.lblCodigo.Enabled:= True;
  self.edtCodigo.Enabled:= True;
  self.lblDescripcion.Enabled:= True;
  self.edtDescripcion.Enabled:= True;
  self.lblUbicacion.Enabled:= True;
  self.edtUbicacion.Enabled:= True;
  self.btnDir.Enabled:= True;
  self.btnBuscar.Visible:= True;
  self.btnconfirmar.Visible:= True;
  self.btnLimpiar.Visible:= True;
end;}
procedure TManualModificarFrm.btnVolverClick(Sender: TObject);
begin
 {if not self.FLocked then
 begin
   TSistema.GetInstance.UnLockScreen(SCR_MANUALES_MODIFICAR);
 end
 else
 begin
   self.UnLockScreen;
   self.FLocked:= False;
 end;
   self.MainForm.Enabled:= True;
   self.MainForm.Show;
   Hide;
   SELF.MainForm:= nil;
 end;}
  self.Close;
end;
procedure TManualModificarFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Manuales: TManuales;
 Ret: boolean;
begin
 if self.edtCodigo.Text = '' then
 begin
   self.edtCodigo.Color:= clred;
   ShowMessage('Debe ingresar el c�digo correspondiente al Manual que desea Modificar');
   self.edtCodigo.Color:= clWindow;
   self.edtCodigo.SetFocus;
 end
 else
 begin
   self.edtCodigo.Text:= UpperCase(self.edtCodigo.Text);
   Manuales:= TManuales.Create;
   Manuales.CodigoM:= self.edtCodigo.Text;

   self.ADODataSet1.Close;
   self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
   TMotorSql.GetInstance.OpenConn;

   sSQL:= 'select PLN_CODIGO ' +
          ', PLN_DESCRIPCION ' +
          ', PLN_UBICACION ' +
          ' from MANUALESPRODUCTO' +
          ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);
  self.ADODataSet1.CommandText:= sSQL;
  self.ADODataSet1.Open;

  if (Self.ADODataSet1.Eof) then
  Begin
    self.edtCodigo.Color:= clRed;
    showMessage('El C�digo que ingres� no corresponde a ningun Manual en la base de datos');
    self.edtCodigo.Color:= clWindow;
    self.edtCodigo.SetFocus;
  end
  else
  begin
    Self.edtDescripcion.Enabled := True;
    Self.edtUbicacion.Enabled := True;
    Self.btnConfirmar.Enabled := True;
    Manuales.CodigoM:= self.ADODataSet1.FieldByName('PLN_CODIGO').AsString;
    Manuales.DescripcionM:= self.ADODataSet1.FieldByName('PLN_DESCRIPCION').AsString;
    Manuales.UbicacionM:= self.ADODataSet1.FieldByName('PLN_UBICACION').AsString;

    self.edtDescripcion.Text:= Manuales.DescripcionM;
    self.edtUbicacion.Text:= Manuales.UbicacionM;
    self.edtDescripcion.SetFocus;
    self.ADODataSet1.Open;
    self.ADODataSet1.Close;
  end;
   TMotorSql.GetInstance.CloseConn;
end;
 end;

procedure TManualModificarFrm.btnLimpiarClick(Sender: TObject);
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
  self.btnconfirmar.Enabled:= False;
  self.edtCodigo.SetFocus;
end;
procedure TManualModificarFrm.btnconfirmarClick(Sender: TObject);
var
 sSQL: string;
 Manuales: TManuales;
 UsuarioM: string;
begin
  Manuales:= TManuales.create;
  Manuales.CodigoM:= self.edtCodigo.Text;
  Manuales.DescripcionM:= self.edtDescripcion.Text;
  Manuales.UbicacionM:= self.edtUbicacion.Text;
  UsuarioM:= TSistema.getInstance.getUsuario.Logon;

  self.ADODataSet1.close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'update MANUALESPRODUCTO ' +
         'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripcion.Text) +
         ', PLN_UBICACION =  '  +  QuotedStr(self.edtUbicacion.Text) +
         ', USUARIO_MODIF = ' + QuotedStr(UsuarioM) +
         ', FECHA_MODIF = ' + QuotedStr(DateToStr(Date)) +
         'where PLN_CODIGO =  ' +  QuotedStr(self.edtCodigo.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
  else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
    ShowMessage('El Manual ' + Manuales.CodigoM + ' se modifico satisfactoriamente');
    self.edtCodigo.Text:= '';
    self.edtDescripcion.Text:= '';
    self.edtUbicacion.Text:= '';

    TMotorSql.GetInstance.OpenConn;
end;
procedure TManualModificarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TManualModificarFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TManualModificarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Busca el c�digo del Manual ingresado en la base de datos';
end;

procedure TManualModificarFrm.btnconfirmarEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Modifica el Manual especificado';
end;

procedure TManualModificarFrm.edtCodigoEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Ingrese el c�digo del Manual a Modificar';
end;

procedure TManualModificarFrm.btnDirEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Seleccione la carpeta donde se encuentra el Manual';
end;

procedure TManualModificarFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Manual:',
      CSIDL_NETWORK, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;

end;

{procedure TManualModificarFrm.FormShow(Sender: TObject);
begin
  if self.PantallaLockeada(SCR_MANUALES_MODIFICAR) then
  begin
    self.LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_MANUALES_MODIFICAR,SCR_MANUALES_MODIFICAR);
    self.FLocked:= False;
  end;
end;}

procedure TManualModificarFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.stbManual.SimpleText:= 'Ingrese la ubicaci�n del archivo con el Manual';
end;

end.
