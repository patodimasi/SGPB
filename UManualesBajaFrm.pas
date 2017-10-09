unit UManualesBajaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ComCtrls, DB, ADODB, UManuales, UMotorSql,USistema, UPantallaFrm;

type
  TManualesBajaFrm = class(TPantallaFrm)
    lblCodigoMan: TLabel;
    edtCodigoMan: TEdit;
    btnBuscarMan: TButton;
    lblTitulo: TLabel;
    DBGridMan: TDBGrid;
    btnConfirmarMan: TButton;
    btnLimpiarMan: TButton;
    btnvolverMan: TButton;
    stbManuales: TStatusBar;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    procedure btnvolverManClick(Sender: TObject);
    procedure btnvolverManEnter(Sender: TObject);
    procedure btnLimpiarManEnter(Sender: TObject);
    procedure btnBuscarManEnter(Sender: TObject);
    procedure btnBuscarManClick(Sender: TObject);
    procedure btnLimpiarManClick(Sender: TObject);
    procedure btnConfirmarManClick(Sender: TObject);
    procedure edtCodigoManKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarManEnter(Sender: TObject);
    //procedure FormShow(Sender: TObject);
    procedure edtCodigoManEnter(Sender: TObject);
    procedure DBGridManEnter(Sender: TObject);

  private
   { procedure LockScreen;
    procedure UnLockScreen;}
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManualesBajaFrm: TManualesBajaFrm;

implementation

{$R *.dfm}
{procedure TManualesBajaFrm.LockScreen;
begin
  self.lblCodigoMan.Enabled:= False;
  self.edtCodigoMan.Enabled:= False;
  self.edtCodigoMan.Text:= '';
  self.DBGridMan.DataSource.DataSet:= nil;
  self.lblTitulo.Enabled:= False;
  self.DBGridMan.Enabled:= False;
  self.btnBuscarMan.Visible:= False;
  self.btnConfirmarMan.Visible:= False;
  self.btnLimpiarMan.Visible:= False;
  self.btnvolverMan.SetFocus;
end;

procedure TManualesBajaFrm.UnLockScreen;
begin
   self.lblCodigoMan.Enabled:= True;
  self.edtCodigoMan.Enabled:= True;
  self.lblTitulo.Enabled:= True;
  self.DBGridMan.Enabled:= True;
  self.btnBuscarMan.Visible:= True;
  self.btnConfirmarMan.Visible:= True;
  self.btnLimpiarMan.Visible:= True;
end;}
procedure TManualesBajaFrm.btnvolverManClick(Sender: TObject);
begin
{if not self.FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_MANUALES_BAJA);
  end
  else
  begin
    self.UnLockScreen;
    self.FLocked:= False;
  end;
    self.MainForm.Enabled:= True;
    self.MainForm.Show;
    Hide;
    self.MainForm:= nil;}
    self.Close;
end;

procedure TManualesBajaFrm.btnvolverManEnter(Sender: TObject);
begin
  self.stbManuales.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TManualesBajaFrm.btnLimpiarManEnter(Sender: TObject);
begin
  self.stbManuales.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TManualesBajaFrm.btnBuscarManEnter(Sender: TObject);
begin
  self.stbManuales.SimpleText:= 'Busca el código del Manual a dar de baja';
end;

procedure TManualesBajaFrm.btnBuscarManClick(Sender: TObject);
var
 sSQL: string;
 Ret: Boolean;
 Manuales : TManuales;

begin
 Ret:= True;
 if self.edtCodigoMan.Text = '' then
 begin
   self.edtCodigoMan.Color:= clLime;
   ShowMessage('Debe ingresar el código correspondiente al Manual que desea dar de baja');
   self.edtCodigoMan.Color:= clWindow;
   self.edtCodigoMan.SetFocus;
   Ret:= False;
 end
 else
 begin
   Manuales:= TManuales.Create;
   Manuales.CodigoM:= self.edtCodigoMan.Text;
   self.ADODataSet1.Close;
   self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
   TMotorSql.GetInstance().OpenConn;
   sSQL:= 'Select PLN_CODIGO as Código,PLN_NRO_REV as NºRev,PLN_DESCRIPCION as Descripción' +
          ' from MANUALESPRODUCTO where PLN_CODIGO like '+QuotedStr(self.edtCodigoMan.Text+'%');

   self.ADODataSet1.CommandText:= sSQL;
//   self.ADODataSet1.Close;
   self.ADODataSet1.Open;
   if Self.ADODataSet1.Eof then
   Begin
     self.edtCodigoMan.Color:= clLime;
     ShowMessage('El Código que ingresó no corresponde a ningun Manual en la base de datos');
     self.edtCodigoMan.Color:= clWindow;
     self.edtCodigoMan.SetFocus;
   end
   else
   Begin
     self.DataSource1.DataSet:= self.ADODataSet1;
   end;
     TMotorSql.GetInstance.CloseConn;
end;
 end;
procedure TManualesBajaFrm.btnLimpiarManClick(Sender: TObject);
begin
 self.lblCodigoMan.Enabled:= True;
 self.edtCodigoMan.Enabled:= True;
 self.edtCodigoMan.Text:= '';
 self.DBGridMan.DataSource.DataSet:= nil;

 self.btnBuscarMan.Enabled:= True;
 self.btnConfirmarMan.Enabled:= True;
 self.edtCodigoMan.SetFocus;
end;

procedure TManualesBajaFrm.btnConfirmarManClick(Sender: TObject);
var
 sSQL: string;
 Manuales: TManuales;
 sCodigoViejo : string;
 begin
   Manuales:= TManuales.create;
   Manuales.CodigoM:= self.edtCodigoMan.Text;
   sCodigoViejo := Self.ADODataSet1.FieldByName('Código').AsString;
   self.ADODataSet1.Close;
   self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
   TMotorSql.GetInstance().OpenConn;

   sSQL:= 'delete from MANUALESPRODUCTO ' + ' where PLN_CODIGO = ' + QuotedStr(sCodigoViejo) ;

   TMotorSql.GetInstance.ExecuteSQL(sSQL);
   ShowMessage ('El Manual ' + Manuales.CodigoM + ' se dio de baja satisfactoriamente');

   self.edtCodigoMan.Text:= '';

   if TMotorSQL.GetInstance.GetStatus = 0 then
   begin
     TMotorSQL.GetInstance.Commit;
   end
   else
   Begin
     TMotorSQL.GetInstance.Rollback;
   end;
     TMotorSQL.GetInstance.CloseConn;
end;

procedure TManualesBajaFrm.edtCodigoManKeyPress(Sender: TObject;
  var Key: Char);
begin
if Ord(Key) = 13 then
    self.btnBuscarMan.Click;
end;

procedure TManualesBajaFrm.btnConfirmarManEnter(Sender: TObject);
begin
  self.stbManuales.SimpleText:= 'Dar de baja el Manual';
end;

{procedure TManualesBajaFrm.FormShow(Sender: TObject);
begin
 if self.PantallaLockeada(SCR_MANUALES_BAJA) then
  begin
    self.LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_MANUALES_BAJA,SCR_MANUALES_BAJA);
    self.FLocked:= False;
  end;
 end;
}
procedure TManualesBajaFrm.edtCodigoManEnter(Sender: TObject);
begin
  self.stbManuales.SimpleText:= 'Ingrese el código del Manual a dar de baja'
end;

procedure TManualesBajaFrm.DBGridManEnter(Sender: TObject);
begin
  self.stbManuales.SimpleText:= 'Listado de revisiones del Manual a dar de baja';
end;
end.
