unit USubinstructivosProdModificarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,UDVarios, USistema, UMotorSql, DB, ADODB,UUtiles, ShlObj;

type
  TModificarSubinstructivosFrm = class(TForm)
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
    StbSubinstructivosProd: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure edtUbicacionChange(Sender: TObject);
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
  ModificarSubinstructivosFrm: TModificarSubinstructivosFrm;

implementation

{$R *.dfm}

procedure TModificarSubinstructivosFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TModificarSubinstructivosFrm.btnLimpiarClick(Sender: TObject);
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

procedure TModificarSubinstructivosFrm.btnBuscarClick(Sender: TObject);
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
          ', PLN_NRO_REV ' +
          ', PLN_NRO_EDIC ' +
          ', PLN_UBICACION ' +
          ' from SUBINSTRUCTIVOSPRODUCCION ' +
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
     self.edtDescripcion.Enabled:= True;
     self.edtUbicacion.Enabled:= True;
     self.btnConfirmar.Enabled:= True;

     Varios.CodigoDV:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
     Varios.DescripcionDV:= self.ADODataSet1.fieldByName('PLN_DESCRIPCION').AsString;
     Varios.UbicacionDv:=self.ADODataSet1.fieldByName('PLN_UBICACION').AsString;

     self.edtDescripcion.Text:= Varios.DescripcionDV;
     self.edtUbicacion.Text:= Varios.UbicacionDv;
     self.edtDescripcion.SetFocus;
     self.ADODataSet1.Open;
     self.ADODataSet1.Close;
   end;
    TMotorSql.GetInstance.CloseConn;
   end;
  end;
procedure TModificarSubinstructivosFrm.btnDirClick(Sender: TObject);
var
 sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;

end;
procedure TModificarSubinstructivosFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 UsuarioV: string;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  Varios.DescripcionDV:= self.edtDescripcion.Text;
  Varios.UbicacionDv:= self.edtUbicacion.Text;

  self.ADODataSet1.close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'update SUBINSTRUCTIVOSPRODUCCION ' +
         'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripcion.Text) +
         ', PLN_UBICACION =  '  +  QuotedStr(self.edtUbicacion.Text) +
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

    TMotorSql.GetInstance.OpenConn;
 end;
procedure TModificarSubinstructivosFrm.edtCodigoEnter(Sender: TObject);
begin
  self.StbSubinstructivosProd.SimpleText:= 'Ingrese el c�digo del Documento a aprobar'
end;

procedure TModificarSubinstructivosFrm.btnBuscarEnter(Sender: TObject);
begin
  self.StbSubinstructivosProd.SimpleText:= 'Busca el c�digo del Documento ingresado en la base de datos';
end;

procedure TModificarSubinstructivosFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.StbSubinstructivosProd.SimpleText:= 'Ingrese la ubicaci�n del archivo con el Documento';
end;

procedure TModificarSubinstructivosFrm.edtUbicacionChange(Sender: TObject);
begin
  self.StbSubinstructivosProd.SimpleText:= 'Ingrese la ubicaci�n del archivo con el Documento';
end;

procedure TModificarSubinstructivosFrm.btnDirEnter(Sender: TObject);
begin
  self.StbSubinstructivosProd.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento';
end;

procedure TModificarSubinstructivosFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.StbSubinstructivosProd.SimpleText:= 'Modifica el Documento especificado';
end;

procedure TModificarSubinstructivosFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StbSubinstructivosProd.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TModificarSubinstructivosFrm.btnVolverEnter(Sender: TObject);
begin
  self.StbSubinstructivosProd.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
