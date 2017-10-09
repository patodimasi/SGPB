unit UInstructivosProdBaja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ComCtrls, DB, ADODB, UDVarios, UMotorSql, USistema;

type
  TInstructivosProdBajaFrm = class(TForm)
    lblCodigoIP: TLabel;
    edtCodigoIP: TEdit;
    btnBuscar: TButton;
    lblTituloIP: TLabel;
    DBGridIP: TDBGrid;
    btnConfirmarIP: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    StbInstructivosProd: TStatusBar;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    procedure btnVolverClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnConfirmarIPClick(Sender: TObject);
    procedure edtCodigoIPEnter(Sender: TObject);
    procedure edtCodigoIPKeyPress(Sender: TObject; var Key: Char);
    procedure btnBuscarEnter(Sender: TObject);
    procedure DBGridIPEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnConfirmarIPEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InstructivosProdBajaFrm: TInstructivosProdBajaFrm;

implementation

{$R *.dfm}
procedure TInstructivosProdBajaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TInstructivosProdBajaFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Ret: Boolean;
 Varios : TDVarios;
begin
 Ret:= True;
 if self.edtCodigoIP.Text = '' then
 begin
    self.edtCodigoIP.Color:= clRed;
    ShowMessage('Debe ingresar el código correspondiente al Documento que desea dar de baja');
    self.edtCodigoIP.Color:= clWindow;
    self.edtCodigoIP.SetFocus;
    Ret:= False;
 end
 else
 begin
   Varios:= TDVarios.Create;
   Varios.CodigoDV:= self.edtCodigoIP.Text;
   self.ADODataSet1.Close;
   self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
   TMotorSql.GetInstance().OpenConn;
   sSQL:= 'Select PLN_CODIGO as Código,PLN_NRO_REV as NºRev,PLN_DESCRIPCION as Descripción' +
            ' from INSTRUCTIVOSPRODUCCION where PLN_CODIGO like '+QuotedStr(self.edtCodigoIP.Text+'%') +
            'union ' +
          'Select PLN_CODIGO as Código,PLN_NRO_REV as NºRev,PLN_DESCRIPCION as Descripción' +
            ' from DOCUMENTOSVARIOS where PLN_CODIGO like '+QuotedStr(self.edtCodigoIP.Text+'%');  

   self.ADODataSet1.CommandText:= sSQL;
   self.ADODataSet1.Close;
   self.ADODataSet1.Open;
   if Self.ADODataSet1.Eof then
   Begin
     self.edtCodigoIP.Color:= clRed;
     ShowMessage('El Código que ingresó no corresponde a ningun Documento en la base de datos');
     self.edtCodigoIP.Color:= clWindow;
     self.edtCodigoIP.SetFocus;
   end
   else
   Begin
     self.DataSource1.DataSet:= self.ADODataSet1;
   end;

     TMotorSql.GetInstance.CloseConn;
end;
 end;
procedure TInstructivosProdBajaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.lblCodigoIP.Enabled:= True;
  self.edtCodigoIP.Enabled:= True;
  self.edtCodigoIP.Text:= '';
  self.DBGridIP.DataSource.DataSet:= nil;
  self.btnBuscar.Enabled:= True;
  self.btnConfirmarIP.Enabled:= True;
  self.edtCodigoIP.SetFocus;
end;
procedure TInstructivosProdBajaFrm.btnConfirmarIPClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 sCodigoViejo : string;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigoIP.Text;
  sCodigoViejo := Self.ADODataSet1.FieldByName('Código').AsString;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
  TMotorSql.GetInstance().OpenConn;

  sSQL:= 'delete from INSTRUCTIVOSPRODUCCION ' + ' where PLN_CODIGO = ' + QuotedStr(sCodigoViejo) ;

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  ShowMessage ('El Documento ' + Varios.CodigoDV + ' se dio de baja satisfactoriamente');
  self.edtCodigoIP.Text:= '';

  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
    else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
    sSQL:= 'delete from DOCUMENTOSVARIOS ' + ' where PLN_CODIGO  = ' +  QuotedStr(sCodigoViejo);

   TMotorSql.GetInstance.ExecuteSQL(sSQL);
   if TMotorSql.GetInstance.GetStatus = 0  then
   begin
     TmotorSql.GetInstance.Commit;
   end
   else
   begin
     TMotorSql.GetInstance.Rollback;
   end;
    TMotorSql.GetInstance.CloseConn;    
end;

procedure TInstructivosProdBajaFrm.edtCodigoIPEnter(Sender: TObject);
begin
  self.StbInstructivosProd.SimpleText:= 'Ingrese el código del Documento a dar de baja'
end;
procedure TInstructivosProdBajaFrm.edtCodigoIPKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
  self.btnBuscar.Click;
end;

procedure TInstructivosProdBajaFrm.btnBuscarEnter(Sender: TObject);
begin
  self.StbInstructivosProd.SimpleText:= 'Busca el código del Documento a dar de baja'
end;

procedure TInstructivosProdBajaFrm.DBGridIPEnter(Sender: TObject);
begin
  self.StbInstructivosProd.SimpleText:= 'Listado de revisiones del Documento a dar de baja'
end;

procedure TInstructivosProdBajaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StbInstructivosProd.SimpleText:= 'Vacia todos los casilleros de la pantalla'
end;

procedure TInstructivosProdBajaFrm.btnConfirmarIPEnter(Sender: TObject);
begin
  self.StbInstructivosProd.SimpleText:= 'Dar de baja el Documento'
end;

procedure TInstructivosProdBajaFrm.btnVolverEnter(Sender: TObject);
begin
  self.StbInstructivosProd.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
