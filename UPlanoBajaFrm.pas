unit UPlanoBajaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UOperacion, UPantallaFrm, UMotorSql,ADODB;

type
  TPlanoBajaFrm = class(TPantallaFrm)
    stbPlano: TStatusBar;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblCodigo: TLabel;
    ListView: TListView;
    lblTitulo: TLabel;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure LimpiarConsulta();

  private
    FOperacion: TOperacion;
    procedure Limpiar;
    procedure LockScreen;
    procedure UnLockScreen;

  published
    property Operacion: TOperacion read FOperacion write FOperacion;
  end;

var
  PlanoBajaFrm: TPlanoBajaFrm;

implementation

uses
  UPlano, UBaja, URecuperar, USistema, UPlanoDB;

{$R *.dfm}

procedure TPlanoBajaFrm.LockScreen;
begin
  lblCodigo.Enabled:= False;
  edtCodigo.Enabled:= False;
  edtCodigo.Text:= '';
  ListView.Clear;
  lblTitulo.Enabled:= False;
  ListView.Enabled:= False;
  btnBuscar.Visible:= False;
  btnConfirmar.Visible:= False;
  btnLimpiar.Visible:= False;
  btnVolver.SetFocus;
end;
procedure TPlanoBajaFrm.LimpiarConsulta;
begin
  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
 // edtCodigo.Text:= '';
  ListView.Clear;
  ListView.Enabled:= False;

  btnBuscar.Enabled:= True;
  btnConfirmar.Enabled:= False;
  edtCodigo.SetFocus;
end;
procedure TPlanoBajaFrm.UnLockScreen;
begin
  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
  lblTitulo.Enabled:= True;
  ListView.Enabled:= True;
  btnBuscar.Visible:= True;
  btnConfirmar.Visible:= True;
  btnLimpiar.Visible:= True;
end;
procedure TPlanoBajaFrm.btnBuscarClick(Sender: TObject);
var
  Plano: TPlano;
  Ret: Boolean;

begin
  Ret:= False;
  if edtCodigo.Text = '' then
  begin
    edtCodigo.Color:= clYellow;
    if Operacion is TBaja then
      ShowMessage('Debe ingresar el código correspondiente al plano que desea dar de baja')
    else if Operacion is TRecuperar then
      ShowMessage('Debe ingresar el código correspondiente al plano que desea recuperar');

    edtCodigo.Color:= clWindow;
    edtCodigo.SetFocus;
  end
  else
  begin
    edtCodigo.Text:= UpperCase(edtCodigo.Text);
    Plano:= TPlano.Create;
    Plano.Codigo:= edtCodigo.Text;

    if Operacion is TBaja then
      Ret:= TSistema.GetInstance.PlanoDB.ConsultaBaja(ListView, Plano, PLN_BAJA)
    else if Operacion is TRecuperar then
      Ret:= TSistema.GetInstance.PlanoDB.ConsultaBaja(ListView, Plano, PLN_RECUPERAR);

    if Ret then
    begin
      ListView.Enabled:= True;
      btnConfirmar.Enabled:= True;
      edtCodigo.Enabled:= False;
      btnBuscar.Enabled:= False;
      btnConfirmar.SetFocus;
    end
    else
    begin
      edtCodigo.Color:= clYellow;
      if Operacion is TBaja then
        ShowMessage('El código que ingresó no corresponde a ningún plano en la base de datos')
      else if Operacion is TRecuperar then
        ShowMessage('El código que ingresó no corresponde a ningún plano dado de baja');

      edtCodigo.Color:= clWindow;
      edtCodigo.SetFocus;
    end;
    Plano.Free;

  end;
end;

procedure TPlanoBajaFrm.btnVolverClick(Sender: TObject);
begin
  if not FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_PLANO_PURGAR);

    if Operacion is TBaja then
    begin
      TSistema.GetInstance.UnLockScreen(SCR_PLANO_BAJA);
      TSistema.GetInstance.UnLockScreen(SCR_PLANO_MODIFICAR);
      TSistema.GetInstance.UnLockScreen(SCR_PLANO_APROBAR);
      TSistema.GetInstance.UnLockScreen(SCR_PLANO_RECIBIR);
      TSistema.GetInstance.UnLockScreen(SCR_PLANO_SUPERAR);
    end
    else if Operacion is TRecuperar then
    begin
      TSistema.GetInstance.UnLockScreen(SCR_PLANO_RECUPERAR);
    end;
  end
  else
  begin
    UnLockScreen;
    FLocked:= False;
  end;
  FOperacion.Free;
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;


procedure TPlanoBajaFrm.btnVolverEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TPlanoBajaFrm.btnLimpiarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TPlanoBajaFrm.btnLimpiarClick(Sender: TObject);
begin
  Limpiar;
end;

procedure TPlanoBajaFrm.Limpiar;
begin
  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
  edtCodigo.Text:= '';
  ListView.Clear;
  ListView.Enabled:= False;

  btnBuscar.Enabled:= True;
  btnConfirmar.Enabled:= False;
  edtCodigo.SetFocus;

end;

procedure TPlanoBajaFrm.btnConfirmarEnter(Sender: TObject);
begin
  if Operacion is TBaja then
    stbPlano.SimpleText:= 'Dar de baja el plano'
  else if Operacion is TRecuperar then
    stbPlano.SimpleText:= 'Recupera el plano dado de baja';

end;

procedure TPlanoBajaFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TPlanoBajaFrm.FormShow(Sender: TObject);
var
  L: Boolean;
begin
  L:= False;
  if Operacion is TBaja then
  begin
    PlanoBajaFrm.Caption:= 'Baja de Plano';
    lblTitulo.Caption:= 'Todas las revisiones del plano que se darían de baja';
    if PantallaLockeada(SCR_PLANO_BAJA) then
      L:= True
    else if PantallaLockeada(SCR_PLANO_MODIFICAR) then
      L:= True
    else if PantallaLockeada(SCR_PLANO_APROBAR) then
      L:= True
    else if PantallaLockeada(SCR_PLANO_RECIBIR) then
      L:= True
    else if PantallaLockeada(SCR_PLANO_SUPERAR) then
      L:= True
    else if PantallaLockeada(SCR_PLANO_PURGAR) then
      L:= True;

    if L then
      LockScreen
    else
    begin
      TSistema.GetInstance.LockScreen(SCR_PLANO_BAJA, SCR_PLANO_BAJA);
      TSistema.GetInstance.LockScreen(SCR_PLANO_MODIFICAR, SCR_PLANO_BAJA);
      TSistema.GetInstance.LockScreen(SCR_PLANO_APROBAR, SCR_PLANO_BAJA);
      TSistema.GetInstance.LockScreen(SCR_PLANO_RECIBIR, SCR_PLANO_BAJA);
      TSistema.GetInstance.LockScreen(SCR_PLANO_SUPERAR, SCR_PLANO_BAJA);
      TSistema.GetInstance.LockScreen(SCR_PLANO_PURGAR, SCR_PLANO_BAJA);
    end;
  end
  else if Operacion is TRecuperar then
  begin
    PlanoBajaFrm.Caption:= 'Recuperar Plano';
    lblTitulo.Caption:= 'Todas las revisiones del plano que se recuperarían';
    if PantallaLockeada(SCR_PLANO_RECUPERAR) then
      L:= True
    else if PantallaLockeada(SCR_PLANO_PURGAR) then
      L:= True;

    if L then
      LockScreen
    else
    begin
      TSistema.GetInstance.LockScreen(SCR_PLANO_RECUPERAR, SCR_PLANO_BAJA);
      TSistema.GetInstance.LockScreen(SCR_PLANO_PURGAR, SCR_PLANO_BAJA);
    end;
  end;

  if not L then
  begin
    Limpiar;
  end;
end;

procedure TPlanoBajaFrm.btnConfirmarClick(Sender: TObject);
var
  Plano: TPlano;
  CodRet: Integer;
  MSQL: TMotorSQL;
  Dst: TADODataset;
  sSQL: string;
  i: integer;
  ItemPl: TListItem;
begin
  CodRet:= 0;

  if Operacion is TBaja then
    CodRet:= MessageDlg('¿ Esta seguro que desea dar de baja el plano con todas sus revisiones ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TRecuperar then
    CodRet:= MessageDlg('¿ Esta seguro que desea recuperar el plano con todas sus revisiones ?', mtConfirmation, mbOKCancel, 0);

  if CodRet = mrOK then
  begin
    Plano:= TPlano.Create;
    Plano.Codigo:= edtCodigo.Text;
    ItemPl:= TListItem.Create(nil);
    if Operacion is TBaja then
    begin
      MSQL:= TMotorSQL.GetInstance();
      MSQL.OpenConn;
  // Si se pudo realizar...
   if MSQL.GetStatus = 0 then
   begin
    Dst:= TADODataset.Create(nil);
   // try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
   //   begin

     for i:= 0 to self.ListView.Items.Count-1 do
     begin
      if  self.ListView.Items.Item[i].Selected = true then
     begin
       plano.Codigo:= self.ListView.Selected.Caption;
       plano.Revision:= StrToInt(self.ListView.Items[i].SubItems[0]);
       plano.Descripcion:= self.ListView.Items[i].SubItems[1];
       dst.Close;
        sSQL:= 'select PLN_CODIGO , PLN_NRO_REV , PLN_DESCRIPCION ' +
               'from PLANO where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text) + 'and PLN_NRO_REV = ' + IntToStr(plano.Revision) +
               ' and PLN_DESCRIPCION = ' + QuotedStr(Plano.Descripcion)+
               ' union ' +
               'select PLN_CODIGO , PLN_NRO_REV , PLN_DESCRIPCION from HISTORICO where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text)+ 'and PLN_NRO_REV = ' +IntToStr(plano.Revision) +
               'and PLN_DESCRIPCION = ' + QuotedStr(plano.Descripcion);
       Dst.CommandText:= sSQL;
       Dst.Open;
  //    ItemPl:= ListView.Items.Add;

       Plano.Codigo:= dst.fieldByName('PLN_CODIGO').AsString;
       Plano.Revision:= dst.fieldByName('PLN_NRO_REV').AsInteger;
       Plano.Descripcion:= dst.fieldByName('PLN_DESCRIPCION').AsString;

       CodRet:= TSistema.GetInstance.PlanoDB.MigrarBaja(Plano);
     end
     else
     end;
      if CodRet = PLN_MIG_OK then
      begin
        ShowMessage('El plano ' + Plano.Codigo + ' se dió de baja satisfactoriamente');
        self.LimpiarConsulta;
      end;
       TSistema.GetInstance.PlanoDB.ConsultaBaja(ListView,Plano,PLN_BAJA);
        if MessageDlg('¿ Desea dar de baja otro plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El plano ' + Plano.Codigo + ' no se pudo dar de baja');
    end
    else if Operacion is TRecuperar then
    begin
      CodRet:= TSistema.GetInstance.PlanoDB.Recuperar(Plano);
      if CodRet = PLN_MIG_OK then
      begin
        ShowMessage('El plano ' + Plano.Codigo + ' se recuperó satisfactoriamente');
        Plano.Free;

        if MessageDlg('¿ Desea recuperar otro plano ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiar.Click
        else
          btnVolver.Click;
      end
      else
        ShowMessage('El plano ' + Plano.Codigo + ' no se pudo recuperar');
    end;
  end;
  end;
procedure TPlanoBajaFrm.edtCodigoEnter(Sender: TObject);
begin
  if Operacion is TBaja then
    stbPlano.SimpleText:= 'Ingrese el código del plano a dar de baja'
  else if Operacion is TRecuperar then
    stbPlano.SimpleText:= 'Ingrese el código del plano a recuperar';
end;

procedure TPlanoBajaFrm.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    btnBuscar.Click;
end;

procedure TPlanoBajaFrm.ListViewEnter(Sender: TObject);
begin
  if Operacion is TBaja then
    stbPlano.SimpleText:= 'Listado de revisiones del plano a dar de baja'
  else if Operacion is TRecuperar then
    stbPlano.SimpleText:= 'Listado de revisiones del plano a recuperar';
end;

procedure TPlanoBajaFrm.btnBuscarEnter(Sender: TObject);
begin
  if Operacion is TBaja then
    stbPlano.SimpleText:= 'Busca el código del plano a dar de baja'
  else if Operacion is TRecuperar then
    stbPlano.SimpleText:= 'Busca el código del plano a recuperar';
end;


end.
