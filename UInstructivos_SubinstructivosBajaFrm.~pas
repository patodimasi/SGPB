unit UInstructivos_SubinstructivosBajaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ComCtrls, DB, ADODB, UDVarios, USistema, UMotorSQL;

type
  TInstructivos_Subinstructivos_EnsayosBajaFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblTitulo: TLabel;
    DBGrid1: TDBGrid;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnvolver: TButton;
    stbInstructivos_Subinstructivos: TStatusBar;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    procedure btnvolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Instructivos_Subinstructivos_EnsayosBajaFrm: TInstructivos_Subinstructivos_EnsayosBajaFrm;

implementation

{$R *.dfm}

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.btnvolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.lblCodigo.Enabled:= True;
  self.lblCodigo.Enabled:= True;
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
  self.DBGrid1.DataSource.DataSet:= nil;
  self.btnBuscar.Enabled:= True;
  self.btnConfirmar.Enabled:= True;
  self.edtCodigo.SetFocus;

end;

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Ret: Boolean;
 Varios: TDVarios;
begin
  Ret:= True;
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clRed;
    ShowMessage('Debe ingresar el código correspondiente al Documento que desea dar de baja');
    self.edtCodigo.Color:= clWindow;
    self.edtCodigo.SetFocus;
    Ret:= False;
  end
  else
  begin
    Varios:= TDVarios.Create;
    Varios.CodigoDV:= self.edtCodigo.Text;
    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
    TMotorSql.GetInstance().OpenConn;
    sSQL:= 'Select PLN_CODIGO as Código,PLN_NRO_REV as NºRev,PLN_DESCRIPCION as Descripción ' +
            ' from INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS where PLN_CODIGO like '+QuotedStr(self.edtCodigo.Text+'%') +
            'union ' +
            'Select PLN_CODIGO as Código,PLN_NRO_REV as NºRev,PLN_DESCRIPCION as Descripción' +
            ' from DOCUMENTOSVARIOS where PLN_CODIGO like '+QuotedStr(self.edtCodigo.Text+'%');
    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Close;
    self.ADODataSet1.Open;
    if Self.ADODataSet1.Eof then
    Begin
      self.edtCodigo.Color:= clRed;
      ShowMessage('El Código que ingresó no corresponde a ningun Documento en la base de datos');
      self.edtCodigo.Color:= clWindow;
      self.edtCodigo.SetFocus;
    end
    else
    Begin
      self.DataSource1.DataSet:= self.ADODataSet1;
    end;
      TMotorSql.GetInstance.CloseConn;
 end;
 end;

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 sCodigoViejo : string;
 begin
   Varios:= TDVarios.Create;
   Varios.CodigoDV:= self.edtCodigo.Text;
   sCodigoViejo := Self.ADODataSet1.FieldByName('Código').AsString;
   self.ADODataSet1.Close;
   self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
   TMotorSql.GetInstance().OpenConn;

   sSQL:= 'delete from INSTRUCTIVOS_SUBINSTRUCTIVOS_ENSAYOS ' + ' where PLN_CODIGO = ' + QuotedStr(sCodigoViejo) ;

   TMotorSql.GetInstance.ExecuteSQL(sSQL);
   ShowMessage ('El Documento ' + Varios.CodigoDV + ' se dio de baja satisfactoriamente');

   self.edtCodigo.Text:= '';
   if TMotorSQL.GetInstance.GetStatus = 0 then
   begin
     TMotorSQL.GetInstance.Commit;
   end
   else
   Begin
     TMotorSQL.GetInstance.Rollback;
   end;

   sSQL:= 'delete from DOCUMENTOSVARIOS ' + ' where PLN_CODIGO = ' + QuotedStr(sCodigoViejo) ;

   TMotorSql.GetInstance.ExecuteSQL(sSQL);
   if TMotorSql.GetInstance.GetStatus = 0 then
   begin
     TMotorSql.GetInstance.Commit;
   end
   else
   begin
     TMotorSql.GetInstance.Rollback;
   end;  
     TMotorSQL.GetInstance.CloseConn;
end;

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.edtCodigoKeyPress(
  Sender: TObject; var Key: Char);
begin
if Ord(Key) = 13 then
    self.btnBuscar.Click;
end;
procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.edtCodigoEnter(Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Ingrese el código del Documento a dar de baja';
end;

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.btnBuscarEnter(Sender: TObject);
begin
 self.stbInstructivos_Subinstructivos.SimpleText:= 'Busca el código del Documento a dar de baja'
end;

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.DBGrid1Enter(
  Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Listado de revisiones del Documento a dar de baja'
end;

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.btnConfirmarEnter(
  Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Dar de baja el Documento';
end;

procedure TInstructivos_Subinstructivos_EnsayosBajaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbInstructivos_Subinstructivos.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

end.
