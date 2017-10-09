unit UEspecificacionesTecnicasBajaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, ComCtrls, UDVarios, UMotorSql, USistema;

type
  TEspecificacionesTecnicasBajaFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblTitulo: TLabel;
    ADODataSet1: TADODataSet;
    DBGrid1: TDBGrid;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    StbEspTec: TStatusBar;
    DataSource1: TDataSource;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EspecificacionesTecnicasBajaFrm: TEspecificacionesTecnicasBajaFrm;

implementation

{$R *.dfm}

procedure TEspecificacionesTecnicasBajaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TEspecificacionesTecnicasBajaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.lblCodigo.Enabled:= True;
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
  self.DBGrid1.DataSource.DataSet:= nil;
  self.btnBuscar.Enabled:= True;
  self.btnConfirmar.Enabled:= True;
  self.edtCodigo.SetFocus;
end;

procedure TEspecificacionesTecnicasBajaFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Ret: Boolean;
 Varios : TDVarios;
begin
 Ret:= True;
 if self.edtCodigo.Text = '' then
 begin
   self.edtCodigo.Color:= clred;
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
            ' from ESPECIFICACIONES_TECNICAS where PLN_CODIGO like '+QuotedStr(self.edtCodigo.Text+'%') +
             'union ' +
          'Select PLN_CODIGO as Código,PLN_NRO_REV as NºRev,PLN_DESCRIPCION as Descripción' +
            ' from DOCUMENTOSVARIOS where PLN_CODIGO like '+QuotedStr(self.edtCodigo.Text+'%');

   self.ADODataSet1.CommandText:= sSQL;
   self.ADODataSet1.Close;
   self.ADODataSet1.Open;
   if self.ADODataSet1.Eof then
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

procedure TEspecificacionesTecnicasBajaFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 sCodigoViejo : string;
begin
  Varios:= TDvarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  sCodigoViejo:= self.ADODataSet1.fieldByName('Código').AsString;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSQL.getInstance().GetConn;
  TMotorSql.GetInstance().OpenConn;
  
  sSQL:= 'delete from ESPECIFICACIONES_TECNICAS ' + ' where PLN_CODIGO = ' + QuotedStr(sCodigoViejo) ;

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
  if TMotorSql.GetInstance.GetStatus = 0 then
  begin
    TMotorSql.GetInstance.Commit;
  end
  else
  begin
    TMotorSql.GetInstance.Rollback;
  end;
    TMotorSql.GetInstance.CloseConn;
end;

procedure TEspecificacionesTecnicasBajaFrm.edtCodigoEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Ingrese el código del Documento a dar de baja'
end;

procedure TEspecificacionesTecnicasBajaFrm.btnBuscarEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Busca el código del Documento a dar de baja'
end;

procedure TEspecificacionesTecnicasBajaFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Dar de baja el Documento';
end;

procedure TEspecificacionesTecnicasBajaFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TEspecificacionesTecnicasBajaFrm.btnVolverEnter(Sender: TObject);
begin
  self.StbEspTec.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.
