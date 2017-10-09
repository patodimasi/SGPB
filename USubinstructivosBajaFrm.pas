unit USubinstructivosBajaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ExtCtrls, DBCtrls, Grids, DBGrids, ComCtrls, UDVarios, USistema, UMotorSql;

type
  TSubinstructivosProdBajaFrm = class(TForm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    lblTitulo: TLabel;
    DBGrid1: TDBGrid;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    StatusBar1: TStatusBar;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SubinstructivosProdBajaFrm: TSubinstructivosProdBajaFrm;

implementation

{$R *.dfm}

procedure TSubinstructivosProdBajaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSubinstructivosProdBajaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.lblCodigo.Enabled:= True;
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
  self.DBGrid1.DataSource.DataSet:= nil;
  self.btnBuscar.Enabled:= True;
  self.btnConfirmar.Enabled:= True;
  self.edtCodigo.SetFocus;

end;

procedure TSubinstructivosProdBajaFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Ret: Boolean;
 Varios: TDVarios;
begin
  Ret:= True;
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clRed;
    ShowMessage('Debe ingresar el c�digo correspondiente al Documento que desea dar de baja');
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
    sSQL:= 'Select PLN_CODIGO as C�digo,PLN_NRO_REV as N�Rev,PLN_DESCRIPCION as Descripci�n ' +
            ' from SUBINSTRUCTIVOSPRODUCCION where PLN_CODIGO like '+QuotedStr(self.edtCodigo.Text+'%') +
            ' union ' +
           'Select PLN_CODIGO as C�digo,PLN_NRO_REV as N�Rev,PLN_DESCRIPCION as Descripci�n ' +
            ' from DOCUMENTOSVARIOS where PLN_CODIGO like '+QuotedStr(self.edtCodigo.Text+'%');

    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Close;
    self.ADODataSet1.Open;
    if Self.ADODataSet1.Eof then
    Begin
      self.edtCodigo.Color:= clRed;
      ShowMessage('El C�digo que ingres� no corresponde a ningun Documento en la base de datos');
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
procedure TSubinstructivosProdBajaFrm.btnConfirmarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 sCodigoViejo : string;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigo.Text;
  sCodigoViejo := Self.ADODataSet1.FieldByName('C�digo').AsString;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
  TMotorSql.GetInstance().OpenConn;

  sSQL:= 'delete from SUBINSTRUCTIVOSPRODUCCION ' + ' where PLN_CODIGO = ' + QuotedStr(sCodigoViejo) ;

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
end.
