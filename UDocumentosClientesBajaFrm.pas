unit UDocumentosClientesBajaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB,UDVarios, UMotorSql, USistema,
  ComCtrls;

type
  TDocumentosClientesBajaFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblTitulo: TLabel;
    DBGrid1: TDBGrid;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    ADODataSet1: TADODataSet;
    StatusBar1: TStatusBar;
    DataSource1: TDataSource;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DocumentosClientesBajaFrm: TDocumentosClientesBajaFrm;

implementation

{$R *.dfm}

procedure TDocumentosClientesBajaFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Ret: Boolean;
 Varios : TDVarios;
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
   self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
   TMotorSql.GetInstance().OpenConn;
   sSQL:= 'Select PLN_CODIGO as Código,PLN_NRO_REV as NºRev,PLN_DESCRIPCION as Descripción' +
            ' from DOCUMENTOSCLIENTES where PLN_CODIGO like '+QuotedStr(self.edtCodigo.Text+'%') +
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

procedure TDocumentosClientesBajaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.lblCodigo.Enabled:= True;
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
  self.DBGrid1.DataSource.DataSet:= nil;
  self.btnBuscar.Enabled:= True;
  self.btnConfirmar.Enabled:= True;
  self.edtCodigo.SetFocus;
end;

procedure TDocumentosClientesBajaFrm.btnConfirmarClick(Sender: TObject);
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

  sSQL:= 'delete from DOCUMENTOSCLIENTES ' + ' where PLN_CODIGO = ' + QuotedStr(sCodigoViejo) ;

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

procedure TDocumentosClientesBajaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TDocumentosClientesBajaFrm.edtCodigoEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Ingrese el código del Documento a dar de baja'
end;

procedure TDocumentosClientesBajaFrm.btnBuscarEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Busca el código del Documento a dar de baja'
end;

procedure TDocumentosClientesBajaFrm.DBGrid1Enter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Listado de revisiones del Documento a dar de baja'
end;

procedure TDocumentosClientesBajaFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Dar de baja el Documento';
end;

procedure TDocumentosClientesBajaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TDocumentosClientesBajaFrm.btnVolverEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
