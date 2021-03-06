unit UMaterialesBajaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,UUtiles,
  Dialogs, StdCtrls, Grids, DBGrids, ComCtrls, DB, ADODB,UMotorSQL,UPantallaFrm,UPlano,USistema, UMateriales;

type
  TMaterialesBajaFrm = class(TPantallaFrm)
    lblCodigoM: TLabel;
    edtCodigoM: TEdit;
    btnBuscarM: TButton;
    lblTituloM: TLabel;
    DBGridM: TDBGrid;
    btnConfirmarM: TButton;
    btnLimpiarM: TButton;
    btnVolverM: TButton;
    stbPlano: TStatusBar;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    procedure btnBuscarMEnter(Sender:TObject);
    procedure btnBuscarMClick(Sender:TObject);
    procedure btnLimpiarMClick(Sender:TObject);
    procedure btnLimpiarMEnter(Sender:TObject);
    procedure btnConfirmarMEnter(Sender:TObject);
    procedure btnConfirmarMClick(Sender:Tobject);
    procedure btnVolverMEnter(Sender:TObject);
    procedure btnVolverMClick(Sender: TObject);
   // procedure FormShow(Sender: TObject);
    procedure edtCodigoMEnter(Sender: TObject);
    procedure DBGridMEnter(Sender: TObject);
    procedure Consultar();
   
  private
    //function DatosValidos():Boolean;
    //procedure LockScreen;
    //procedure UnLockScreen;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaterialesBajaFrm: TMaterialesBajaFrm;

implementation
uses
   UOperacion,URecuperar, UPlanoDB;

{$R *.dfm}
{procedure TMaterialesBajaFrm.LockScreen;
begin
  self.lblCodigoM.Enabled:= False;
  self.edtCodigoM.Enabled:= False;
  self.edtCodigoM.Text:= '';
  self.DBGridM.DataSource.DataSet:= nil;
  self.lblTituloM.Enabled:= False;
  self.DBGridM.Enabled:= False;
  self.btnBuscarM.Visible:= False;
  self.btnConfirmarM.Visible:= False;
  self.btnLimpiarM.Visible:= False;
  self.btnVolverM.SetFocus;
end;
procedure TMaterialesBajaFrm.UnLockScreen;
begin
  self.lblCodigoM.Enabled:= True;
  self.edtCodigoM.Enabled:= True;
  self.lblTituloM.Enabled:= True;
  self.DBGridM.Enabled:= True;
  self.btnBuscarM.Visible:= True;
  self.btnConfirmarM.Visible:= True;
  self.btnLimpiarM.Visible:= True;
end; }

procedure TMaterialesBajaFrm.Consultar;
var
 sSql: string;
begin
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.getInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;
  sSql:= 'Select PLN_CODIGO as C�digo, PLN_NRO_REV as N�Rev, PLN_DESCRIPCION as Descripci�n,PLN_SUPERADO' +
         ' from MATERIALES where PLN_CODIGO ='+ QuotedStr(self.edtCodigoM.Text) + 
         ' union ' +
         'select PLN_CODIGO as C�digo, PLN_NRO_REV as N�Rev, PLN_DESCRIPCION as Descripci�n,PLN_SUPERADO' +
         ' from HISTORICOMATERIALES where PLN_CODIGO ='+ QuotedStr(self.edtCodigoM.Text);
  self.ADODataSet1.CommandText:= sSQL;
  self.ADODataSet1.Close;
  self.ADODataSet1.Open;
  Self.DataSource1.DataSet := Self.ADODataSet1;
end;
procedure TMaterialesBajaFrm.btnBuscarMEnter(Sender: TObject);
begin
stbPlano.SimpleText:= 'Busca el c�digo de la Lista de Material a dar de Baja';
end;
procedure TMaterialesBajaFrm.btnBuscarMClick(Sender: TObject);
var
 sSQL: string;
 Ret: Boolean;
 Materiales : TMateriales;
 //prueba: string;
begin
 Ret:= True;
 if self.edtCodigoM.Text = '' then
 begin
    self.edtCodigoM.Color:= clRed;
    ShowMessage('Debe ingresar el c�digo correspondiente a la Lista de Materiales que desea dar de baja');
    self.edtCodigoM.Color:= clWindow;
    self.edtCodigoM.SetFocus;
     Ret:= False;
 end
 else
 begin
     Materiales:= TMateriales.Create;
     Materiales.Codigol:= self.edtCodigoM.Text;
     self.ADODataSet1.Close;
     self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
     TMotorSql.GetInstance().OpenConn;
     sSQL:= 'Select PLN_CODIGO as C�digo,PLN_NRO_REV as N�Rev,PLN_DESCRIPCION as Descripci�n,PLN_SUPERADO ' +
            ' from MATERIALES where PLN_CODIGO like '+QuotedStr(self.edtCodigoM.Text+'%') + 'order by PLN_NRO_REV'+
            ' union ' +
            'Select PLN_CODIGO as C�digo,PLN_NRO_REV as N�Rev,PLN_DESCRIPCION as Descripci�n,PLN_SUPERADO ' +
            ' from HISTORICOMATERIALES where PLN_CODIGO like '+QuotedStr(self.edtCodigoM.Text+'%');
           //' + QuotedStr(self.edtCodigoM.Text);
{    sSQL:= 'Select PLN_CODIGO as C�digo,PLN_NRO_REV as N�Rev,PLN_DESCRIPCION as Descripci�n ' +
           ' from MATERIALES where PLN_CODIGO = ' + QuotedStr(self.edtCodigoM.Text) +
           ' union ' +
           'Select PLN_CODIGO as C�digo,PLN_NRO_REV as N�Rev,PLN_DESCRIPCION as Descripci�n ' +
           ' from HISTORICOMATERIALES where PLN_CODIGO =' + QuotedStr(self.edtCodigoM.Text);}

   self.ADODataSet1.CommandText:= sSQL;
   self.ADODataSet1.Close;
   self.ADODataSet1.Open;
   if Self.ADODataSet1.Eof then
   Begin
        self.edtCodigoM.Color:= clRed;
       ShowMessage('El C�digo que ingres� no corresponde a ninguna Lista de Materiales en la base de datos');
       self.edtCodigoM.Color:= clWindow;
       self.edtCodigoM.SetFocus;
   end
     else
   Begin
     self.DataSource1.DataSet:= self.ADODataSet1;
   end;
   TMotorSql.GetInstance.CloseConn;
end;
 end;

procedure TMaterialesBajaFrm.btnLimpiarMEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;
procedure TMaterialesBajaFrm.btnLimpiarMClick(Sender: TObject);
begin
  self.lblCodigoM.Enabled:= True;
  self.edtCodigoM.Enabled:= True;
  self.edtCodigoM.Text:= '';
  self.DBGridM.DataSource.DataSet:= nil;

  self.btnBuscarM.Enabled:= True;
  self.btnConfirmarM.Enabled:= true;
  self.edtCodigoM.SetFocus;

end;
procedure TMaterialesBajaFrm.btnConfirmarMEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Da de baja la Lista de Materiales';
end;
procedure TMaterialesBajaFrm.btnConfirmarMClick(Sender: TObject);
var
 i: integer;
 sSQL: string;
 Materiales: TMateriales;
 sCodigoViejo : string;
 vector: array of TMateriales;
 contador: integer;
 begin
  Materiales:= TMateriales.Create;
  contador:= self.DBGridM.SelectedRows.Count;
  SetLength(vector,contador);
  for i:=low(vector) to high(vector) do
  Begin
   vector[i] := TMateriales.Create;
  end;
   self.DBGridM.SelectedField.DataSet.Prior;
   for i:= 0 to self.DBGridM.SelectedRows.Count-1 do
   begin
    (vector[i] as TMateriales).Codigol:= self.DBGridM.SelectedField.DataSet.Fields[0].AsString;
    (vector[i] as TMateriales).Revisionl:= self.DBGridM.SelectedField.DataSet.Fields[1].AsInteger;
    (vector[i] as TMateriales).Descripcionl:= self.DBGridM.SelectedField.DataSet.Fields[2].AsString;
    (vector[i] as TMateriales).FSuperado:= self.DBGridM.SelectedField.DataSet.Fields[3].AsString;
    self.DBGridM.SelectedField.DataSet.Next;
   end;
    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
    TMotorSql.GetInstance().OpenConn;
  try
    for i:= 0 to contador-1 do
    begin
     if vector[i].FSuperado = 'NS' then
     begin
     sSQL:= 'delete from Materiales ' + ' where PLN_CODIGO = ' + QuotedStr(vector[i].Codigol) + 'and PLN_NRO_REV = ' +
             IntToStr(vector[i].Revisionl)+ 'and PLN_DESCRIPCION = ' + QuoTedStr(vector[i].Descripcionl);

        TMotorSql.GetInstance.ExecuteSQL(sSQL);
           TMotorSQL.GetInstance.Commit;

      end
      else
      begin
       sSQL:= 'delete from HistoricoMateriales ' + ' where PLN_CODIGO = ' + QuotedStr(vector[i].Codigol) + 'and PLN_NRO_REV = ' +
             IntToStr(vector[i].Revisionl)+ 'and PLN_DESCRIPCION = ' + QuoTedStr(vector[i].Descripcionl);
          TMotorSql.GetInstance.ExecuteSQL(sSQL);
           TMotorSQL.GetInstance.Commit;
      end;
   { end;
    ShowMessage ('La Lista de Materiales ' + Materiales.Codigol + ' se dio de baja satisfactoriamente');
    self.edtCodigoM.Text:= '';

    if TMotorSQL.GetInstance.GetStatus = 0 then
    begin }
  {  end
    else
    Begin
    }
     end;
    except
      TMotorSQL.GetInstance.Rollback;
    end;
    self.Consultar;

//  TMotorSql.GetInstance().OpenConn;
   {  sSQL:= 'delete from HISTORICOMATERIALES ' + ' where PLN_CODIGO = ' + QuotedStr(sCodigoViejo) ;
     TMotorSql.GetInstance.ExecuteSQL(sSQL);

     if TMotorSQL.GetInstance.GetStatus = 0 then
     begin
       TMotorSQL.GetInstance.Commit;
     end
     else
     Begin
       TMotorSQL.GetInstance.Rollback;
     end;}

    // TMotorSQL.GetInstance.CloseConn;
  //end;
   end;
procedure TMaterialesBajaFrm.btnVolverMEnter(Sender:TObject);
begin
 stbPlano.SimpleText := 'Regresa a la pantalla anterior';
end;

procedure TMaterialesBajaFrm.btnVolverMClick(Sender: TObject);
begin
 { if not self.FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_MATERIALES_BAJA);
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
{procedure TMaterialesBajaFrm.FormShow(Sender: TObject);
begin
  if self.PantallaLockeada(SCR_MATERIALES_BAJA) then
  begin
    self.LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_MATERIALES_BAJA,SCR_MATERIALES_BAJA);
    self.FLocked:= False;
  end;
  end;}
procedure TMaterialesBajaFrm.edtCodigoMEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese el c�digo de la Lista de Materiales a dar de baja'
end;

procedure TMaterialesBajaFrm.DBGridMEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Listado de revisiones de la Lista de Materiales a dar de baja'
end;

end.
