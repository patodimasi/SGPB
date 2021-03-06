unit UInstructivos_SubinstructivosModificarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, UDVarios,UMotorSql,UUtiles, ShlObj;

type
  TInstructivos_SubinstructivosModificarFrm = class(TForm)
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
    procedure btnVolverClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
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
  Instructivos_SubinstructivosModificarFrm: TInstructivos_SubinstructivosModificarFrm;

implementation

{$R *.dfm}

procedure TInstructivos_SubinstructivosModificarFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 //Ret: boolean;
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
                  ', PLN_USUARIO_REC ' +
                  ', PLN_UBICACION ' +
            ' from INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS ' +
            ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text);
    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Open;

    if (Self.ADODataSet1.Eof) then
    begin
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
  end;
    TMotorSql.GetInstance.CloseConn;
 end;
end;

procedure TInstructivos_SubinstructivosModificarFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TInstructivos_SubinstructivosModificarFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, self.edtUbicacion.Text);
  if sDir <> '' then
    self.edtUbicacion.Text:= sDir;

end;

procedure TInstructivos_SubinstructivosModificarFrm.btnLimpiarClick(Sender: Tobject);
begin
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
  self.btnBuscar.Enabled:= True;
  self.edtDescripcion.Enabled:= False;
  self.edtDescripcion.Text:= '';
  self.edtDescripcion.TabStop:= False;
  self.edtUbicacion.Text:= '';
  self.edtUbicacion.TabStop:= false;
  self.edtUbicacion.Enabled:= False;
  self.btnDir.Enabled:= False;
  self.btnConfirmar.Enabled:= False;
  self.edtCodigo.SetFocus;
end;

procedure TInstructivos_SubinstructivosModificarFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  Varios.DescripcionDV:= self.edtDescripcion.Text;
  Varios.UbicacionDv:= self.edtUbicacion.Text;

  self.ADODataSet1.close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'update INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS ' +
         'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripcion.Text) +
         ', PLN_UBICACION =  '  +  QuotedStr(self.edtUbicacion.Text) +
         'where PLN_CODIGO =  ' +  QuotedStr(self.edtCodigo.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
  else
  begin
    TMotorSQL.GetInstance.Rollback;
  end;
  sSQL:= 'update DOCUMENTOSVARIOS ' +
         'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripcion.Text) +
         ', PLN_UBICACION =  '  +  QuotedStr(self.edtUbicacion.Text) +
         'where PLN_CODIGO =  ' +  QuotedStr(self.edtCodigo.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
  else
  begin
    TMotorSQL.GetInstance.Rollback;
  end;  
    ShowMessage('El Documento ' + Varios.CodigoDV + ' se modifico satisfactoriamente');
    self.edtCodigo.Text:= '';
    self.edtDescripcion.Text:= '';
    self.edtUbicacion.Text:= '';

    TMotorSql.GetInstance.OpenConn;
end;
procedure TInstructivos_SubinstructivosModificarFrm.edtCodigoEnter(Sender: TObject);
begin
self.stbInstructivos_Subinstructivos.SimpleText:='Ingrese el c�digo del Documento a modificar';
end;

procedure TInstructivos_SubinstructivosModificarFrm.edtCodigoKeyPress(
  Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    btnBuscar.Click;
end;

procedure TInstructivos_SubinstructivosModificarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Busca el c�digo del Documento ingresado en la base de datos';
end;

procedure TInstructivos_SubinstructivosModificarFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Ingrese la ubicaci�n del archivo con el Documento';
end;

procedure TInstructivos_SubinstructivosModificarFrm.btnDirEnter(Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento'
end;

procedure TInstructivos_SubinstructivosModificarFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Modifica el Documento especificado';
end;

procedure TInstructivos_SubinstructivosModificarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TInstructivos_SubinstructivosModificarFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
