unit UInstructivos_SubinstructivosAltaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UMotorSql, USistema, DB,ADODB, UDVarios, UUtiles, shlobj;

type
  TInstructivos_SubinstructivosAltaFrm = class(TForm)
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
    stbInstructivos: TStatusBar;
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
    procedure edtUbicacionEnter(Sender: TObject);
    procedure btnDirEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);

  private
    procedure GenerarCodigo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Instructivos_SubinstructivosAltaFrm: TInstructivos_SubinstructivosAltaFrm;

implementation

{$R *.dfm}
procedure TInstructivos_SubinstructivosAltaFrm.GenerarCodigo;
var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;
  CodMax: string;
  iCodMax: integer;
  iUltimoCodMax :integer;
begin
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;
  sSQL:= 'select PLN_CODIGO as CodMax from INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS where PLN_CODIGO like '+QuotedStr('IB10-%');
  Dst:= TADODataset.Create(nil);
  try
    Dst.Connection:= MSQL.GetConn;
    Dst.CommandText:= sSQL;
    Dst.Open;
    if Dst.Eof then
    Begin
      Self.edtCodigo.Text := 'IB10-001';
    end
    else
    Begin
      iUltimoCodMax := -1;
    while not(Dst.Eof) do
    Begin
      CodMax:= Dst.FieldByName('CodMax').AsString;
      Delete(CodMax,1,5);
      iCodMax := StrToInt(CodMax);
      if iCodMax>iUltimoCodMax then
      Begin
        iUltimoCodMax := iCodMax;
      end;
        Dst.Next;
    end;
      Self.edtCodigo.Text := 'IB10-'+IntToStr(iUltimoCodMax+1);
    end;
      Dst.Close;
      MSQL.CloseConn;
    finally
      Dst.Free;
  end;
end;

procedure TInstructivos_SubinstructivosAltaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtDescripcion.Text:= '';
  self.edtUbicacion.Text:= '';
  self.edtDescripcion.SetFocus;
end;

procedure TInstructivos_SubinstructivosAltaFrm.btnConfirmarClick(Sender: Tobject);
var
  sSQL: string;
  UsuarioAlta: string;
  Varios: TDVarios;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  UsuarioAlta:= TSistema.GetInstance.GetUsuario.Logon;

  sSQL:= 'insert into INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA)'+
         ' VALUES ('+QuotedStr(Self.edtCodigo.Text)+','+QuotedStr(Self.edtDescripcion.Text)+','+QuotedStr('PA')+','+QuotedStr(self.edtUbicacion.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+')';


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
    sSQL:= 'insert into DOCUMENTOSVARIOS (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA,PLN_NRO_REV)'+
         ' VALUES ('+QuotedStr(Self.edtCodigo.Text)+','+QuotedStr(Self.edtDescripcion.Text)+','+QuotedStr('PA')+','+QuotedStr(self.edtUbicacion.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+','+QuotedStr('0')+')';


            //    , [Formatear(P.Codigo), Formatear(P.Descripcion)]);
  TMotorSQL.GetInstance.OpenConn;

  TMotorSQL.GetInstance.ExecuteSQL(sSQL);
  //ShowMessage('El Documento ' + Varios.CodigoDV + ' se dio de alta satisfactoriamente');

  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
    else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
    TMotorSQL.GetInstance.CloseConn;
    Self.edtCodigo.Text := '';
    Self.edtDescripcion.Text := '';
    Self.edtUbicacion.Text := '';
    Self.GenerarCodigo;
end;

procedure TInstructivos_SubinstructivosAltaFrm.FormShow(Sender: TObject);
begin
  SELF.GenerarCodigo;
end;

procedure TInstructivos_SubinstructivosAltaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TInstructivos_SubinstructivosAltaFrm.btnDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, edtUbicacion.Text);
  if sDir <> '' then
    edtUbicacion.Text:= sDir;

end;
procedure TInstructivos_SubinstructivosAltaFrm.edtDescripcionEnter(Sender: TObject);
begin
  self.stbInstructivos.SimpleText:= 'Ingrese una breve descripción del Documento';
end;

procedure TInstructivos_SubinstructivosAltaFrm.edtUbicacionEnter(Sender: TObject);
begin
  self.stbInstructivos.SimpleText:= 'Ingrese la ubicación del archivo con el Documento';
end;

procedure TInstructivos_SubinstructivosAltaFrm.btnDirEnter(Sender: TObject);
begin
  self.stbInstructivos.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento';
end;

procedure TInstructivos_SubinstructivosAltaFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbInstructivos.SimpleText:= 'Da de Alta el Documento en la base de datos';
end;

procedure TInstructivos_SubinstructivosAltaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbInstructivos.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TInstructivos_SubinstructivosAltaFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbInstructivos.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
