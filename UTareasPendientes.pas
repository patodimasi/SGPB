unit UTareasPendientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, UPlanoDB,UListaDB, Grids, DBGrids, DB, ADODB, UMotorSql, USistema,SortIcon;
const
 Todos = 1;
 Recepcion = 2;
 Aprobacion = 3;
 TodosManuales = 4;
 RecepcionManuales = 5;
 AprobacionManuales = 6;

 { For Windows >= XP }
  {$EXTERNALSYM HDF_SORTUP}
  HDF_SORTUP              = $0400;
  {$EXTERNALSYM HDF_SORTDOWN}
  HDF_SORTDOWN            = $0200;

type
  TTareasPendientesFrm = class(TForm)
    ListView: TListView;
    stbPlano: TStatusBar;
    btnVolver: TButton;
    gbVer: TGroupBox;
    rbVer1: TRadioButton;
    rbVer2: TRadioButton;
    rbVer3: TRadioButton;
    gbAprobar: TGroupBox;
    btnAprobarTodos: TButton;
    btnAprobarSel: TButton;
    gbRecibir: TGroupBox;
    btnRecibirTodos: TButton;
    btnRecibirSel: TButton;
    btnAbrir: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    gbVerl: TGroupBox;
    gbAprobarl: TGroupBox;
    gbRecibirl: TGroupBox;
    btnAbrirl: TButton;
    btnVovlerl: TButton;
    rbVer1l: TRadioButton;
    rbVer2l: TRadioButton;
    rbVer3l: TRadioButton;
    btnAprobarSell: TButton;
    btnAprobarTodosl: TButton;
    btnRecibirSell: TButton;
    btnRecibirTodosl: TButton;
    DBGrid2: TDBGrid;
    gbVerm: TGroupBox;
    rbVer1m: TRadioButton;
    rbVer2m: TRadioButton;
    rbVer3m: TRadioButton;
    gbAprobarm: TGroupBox;
    btnAprobarSelm: TButton;
    btnAprobarTodosm: TButton;
    gbRecibirm: TGroupBox;
    btnRecibirSelm: TButton;
    btnRecibirTodosm: TButton;
    btnAbrirm: TButton;
    btnVolverm: TButton;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    ADODataSet2: TADODataSet;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    ADODataSet3: TADODataSet;
    ListViewL: TListView;
    procedure btnVolverClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnRecibirTodosEnter(Sender: TObject);
    procedure btnRecibirSelEnter(Sender: TObject);
    procedure btnAprobarTodosEnter(Sender: TObject);
    procedure btnAprobarSelEnter(Sender: TObject);
    procedure rbVer1Enter(Sender: TObject);
    procedure rbVer2Enter(Sender: TObject);
    procedure rbVer3Enter(Sender: TObject);
    procedure btnAprobarTodosClick(Sender: TObject);
    procedure btnRecibirTodosClick(Sender: TObject);
    procedure btnAprobarSelClick(Sender: TObject);
    procedure btnRecibirSelClick(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
    procedure ListViewKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnAbrirEnter(Sender: TObject);
    procedure btnVovlerlClick(Sender: TObject);
    procedure btnVolvermClick(Sender: TObject);
    procedure btnVovlerlEnter(Sender: TObject);
    procedure btnVolvermEnter(Sender: TObject);
    procedure btnAprobarSellClick(Sender: TObject);
    procedure btnAprobarTodoslClick(Sender: TObject);
    procedure btnRecibirSellClick(Sender: TObject);
    procedure btnRecibirTodoslClick(Sender: TObject);
    procedure rbVer1mClick(Sender: TObject);
    procedure rbVer2mClick(Sender: TObject);
    procedure rbVer3mClick(Sender: TObject);
    procedure btnAprobarSelmClick(Sender: TObject);
    procedure btnAprobarTodosmClick(Sender: TObject);
    procedure btnRecibirTodosmClick(Sender: TObject);
    procedure btnRecibirSelmClick(Sender: TObject);
    procedure btnAbrirlClick(Sender: TObject);
    procedure btnAbrirmClick(Sender: TObject);
    procedure btnAbrirmEnter(Sender: TObject);
    procedure btnAbrirlEnter(Sender: TObject);
    procedure btnRecibirTodoslEnter(Sender: TObject);
    procedure btnRecibirTodosmEnter(Sender: TObject);
    procedure btnRecibirSelmEnter(Sender: TObject);
    procedure btnRecibirSellEnter(Sender: TObject);
    procedure btnAprobarTodosmEnter(Sender: TObject);
    procedure btnAprobarTodoslEnter(Sender: TObject);
    procedure btnAprobarSelmEnter(Sender: TObject);
    procedure btnAprobarSellEnter(Sender: TObject);
  //  procedure rbVer1DvClick(Sender: TObject);
    procedure btnVolverDvClick(Sender: TObject);
    procedure rbVer1DvEnter(Sender: TObject);
    procedure rbVer1lEnter(Sender: TObject);
    procedure rbVer2lEnter(Sender: TObject);
    procedure rbVer2mEnter(Sender: TObject);
    procedure rbVer3mEnter(Sender: TObject);
    procedure rbVer3DvEnter(Sender: TObject);
    procedure PageControl1Enter(Sender: TObject);
//    procedure Consultar(TipoConsulta:integer);
    procedure ConsultarManuales(TipoConsulta:integer);
    procedure rbVer3lEnter(Sender: TObject);
    procedure ListViewLDblClick(Sender: TObject);
    procedure ListViewLSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListViewLKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewLColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewLCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ShowArrowOfListViewColumn(ListView1: TListView; ColumnIdx: integer; Descending: boolean);

  private
    FMainForm: TForm;
    FPlanoDB: TPlanoDB;
    FListaDB: TListaDB;
    procedure AnularPantalla;
    procedure AnularPantallaLM;
    procedure HabilitarPantalla;
    procedure HabilitarPantallaLM;
    procedure HabilitarPantallaM;


  published
    property MainForm: TForm read FMainForm write FMainForm;
  end;

var
  TareasPendientesFrm: TTareasPendientesFrm;
  Descending: Boolean;
  SortedColumn: Integer;

  DescendingP: Boolean;
  SortedColumnP: Integer;

implementation
uses
  ShellAPI,CommCtrl;

{$R *.dfm}

procedure TTareasPendientesFrm.ShowArrowOfListViewColumn(ListView1: TListView; ColumnIdx: integer; Descending: boolean);
var
  Header: HWND;
  Item: THDItem;
begin
  Header := ListView_GetHeader(ListView1.Handle);
  ZeroMemory(@Item, SizeOf(Item));
  Item.Mask := HDI_FORMAT;
  Header_GetItem(Header, ColumnIdx, Item);
  Item.fmt := Item.fmt and not (HDF_SORTUP or HDF_SORTDOWN);//remove both flags
  if Descending then
    Item.fmt := Item.fmt or HDF_SORTDOWN
  else
    Item.fmt := Item.fmt or HDF_SORTUP;//include the sort ascending flag
  Header_SetItem(Header, ColumnIdx, Item);
end;

procedure TTareasPendientesFrm.ConsultarManuales(TipoConsulta:integer);
var
 SSql: string;
begin
 case TipoConsulta of
 TodosManuales:
 begin
   self.HabilitarPantallaM;
   self.ADODataSet2.Close;
   self.ADODataSet2.Connection:= TMotorSql.getInstance.GetConn;
   TMotorSql.GetInstance.OpenConn;
   sSql:= 'Select PLN_CODIGO as Codigo, PLN_NRO_REV as Rev, PLN_DESCRIPCION as Descripcion , PLN_UBICACION as Ubicacion, '+QuotedStr('Pendiente de Aprobacion')+' as Tarea_Pendiente ' +
           ' from MANUALESPRODUCTO where PLN_ESTADO = '+QuotedStr('PA')+
           ' union Select PLN_CODIGO as Codigo, PLN_NRO_REV as Rev, PLN_DESCRIPCION as Descripcion , PLN_UBICACION as Ubicacion, '+QuotedStr('Pendiente de Recepci�n')+' as Tarea_Pendiente ' +
           ' from MANUALESPRODUCTO where PLN_ESTADO = '+QuotedStr('PR');

    self.ADODataSet2.CommandText:= sSQL;
    self.ADODataSet2.Close;
    self.ADODataSet2.Open;
    //TMotorSql.GetInstance.CloseConn;
 end;
 RecepcionManuales:
 begin
  self.btnRecibirSelm.Enabled:= true;
  self.btnRecibirTodosm.Enabled:= True;
  self.btnAprobarSelm.Enabled:= False;
  self.btnAprobarTodosm.Enabled:= false;
  self.ADODataSet2.Close;
  self.ADODataSet2.Connection:= TMotorSql.getInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;
  self.ADODataSet2.CommandText:= 'Select PLN_CODIGO as Codigo , PLN_NRO_REV as Rev, PLN_DESCRIPCION as Descripcion, PLN_UBICACION as Ubicacion,'+QuotedStr('Pendiente de Recepci�n')+' as Tarea_Pendiente ' +
                                 ' from MANUALESPRODUCTO where PLN_ESTADO in (''PR'')' ;

    self.ADODataSet2.Close;
    self.ADODataSet2.Open;
    self.DataSource2.DataSet:= self.ADODataSet2;
 end;
   AprobacionManuales:
   begin
    self.btnAprobarSelm.Enabled:= True;
    self.btnAprobarTodosm.Enabled:= True;
    self.btnRecibirSelm.Enabled:= False;
    self.btnRecibirTodosm.Enabled:= False;
    self.ADODataSet2.Close;
    self.ADODataSet2.Connection:= TMotorSql.getInstance.GetConn;
    TMotorSql.GetInstance.OpenConn;
    self.ADODataSet2.CommandText:= 'Select PLN_CODIGO as Codigo , PLN_NRO_REV as Rev, PLN_DESCRIPCION as Descripcion, PLN_UBICACION as Ubicacion, '+QuotedStr('Pendiente de Aprobacion')+' as Tarea_Pendiente ' +
                                   ' from MANUALESPRODUCTO where PLN_ESTADO in (''PA'')' ;

    self.ADODataSet2.Close;
    self.ADODataSet2.Open;
    self.DataSource2.DataSet:= self.ADODataSet2;
  end;
 end;
end;

procedure TTareasPendientesFrm.btnVolverClick(Sender: TObject);
begin
  FPlanoDB.Free;
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TTareasPendientesFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TTareasPendientesFrm.FormShow(Sender: TObject);
begin
  HabilitarPantalla;
  ListView.Clear;
  self.rbVer1lEnter(Sender);
  self.rbVer1mClick(Sender);
  if not FPlanoDB.ConsultaPendientes(ListView, PLN_PEND_TODOS) then
  begin
    ShowMessage('No hay ninguna tarea pendiente');
    AnularPantalla;
  end;
end;

procedure TTareasPendientesFrm.AnularPantalla;
begin
  ListView.Enabled:= False;
  btnAprobarSel.Enabled:= False;
  btnAprobarTodos.Enabled:= False;
  btnRecibirSel.Enabled:= False;
  btnRecibirTodos.Enabled:= False;
  gbVer.Enabled:= False;
end;

procedure TTareasPendientesFrm.AnularPantallaLM;
begin
  ListViewL.Enabled:= False;
  btnAprobarSell.Enabled:= False;
  btnAprobarTodosl.Enabled:= False;
  btnRecibirSell.Enabled:= False;
  btnRecibirTodosl.Enabled:= False;
  gbVerl.Enabled:= False;
end;

procedure TTareasPendientesFrm.HabilitarPantalla;
begin
  ListView.Enabled:= True;
  btnAprobarSel.Enabled:= True;
  btnAprobarTodos.Enabled:= True;
  btnRecibirSel.Enabled:= True;
  btnRecibirTodos.Enabled:= True;
  gbVer.Enabled:= True;
end;

procedure TTareasPendientesFrm.HabilitarPantallaLM;
begin
  ListViewL.Enabled:= True;
  btnAprobarSell.Enabled:= True;
  btnAprobarTodosl.Enabled:= True;
  btnRecibirSell.Enabled:= True;
  btnRecibirTodosl.Enabled:= True;
  gbVerl.Enabled:= True;
end;

procedure TTareasPendientesFrm.HabilitarPantallaM;
begin
 self.DBGrid2.Enabled:= true;
 self.btnAprobarSelm.Enabled:= True;
 self.btnAprobarTodosm.Enabled:= True;
 self.btnRecibirSelm.Enabled:= True;
 self.btnRecibirTodosm.Enabled:= true;
 self.gbVerm.Enabled:= true;
 self.rbVer1m.Checked:= true;
end;

procedure TTareasPendientesFrm.btnVolverEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TTareasPendientesFrm.btnRecibirTodosEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Recibir todos los planos listados';
end;

procedure TTareasPendientesFrm.btnRecibirSelEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Recibir todos los planos seleccionados del listado';
end;

procedure TTareasPendientesFrm.btnAprobarTodosEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Aprobar todos los planos listados';
end;

procedure TTareasPendientesFrm.btnAprobarSelEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Aprobar todos los planos seleccionados del listado';
end;

procedure TTareasPendientesFrm.rbVer1Enter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Muestra en el listado todas las tareas pendientes';
  HabilitarPantalla;

  ListView.Clear;
  if not FPlanoDB.ConsultaPendientes(ListView, PLN_PEND_TODOS) then
  begin
    ShowMessage('No hay ninguna tarea pendiente');
    AnularPantalla;
  end;
end;

procedure TTareasPendientesFrm.rbVer2Enter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Muestra en el listado solo los planos pendientes de aprobaci�n';
  btnAprobarSel.Enabled:= True;
  btnAprobarTodos.Enabled:= True;
  btnRecibirSel.Enabled:= False;
  btnRecibirTodos.Enabled:= False;

  ListView.Clear;
  if not FPlanoDB.ConsultaPendientes(ListView, PLN_PEND_APR) then
  begin
    ShowMessage('No hay ning�n plano pendiente de aprobaci�n');
    btnAprobarSel.Enabled:= False;
    btnAprobarTodos.Enabled:= False;
    rbVer1.SetFocus;
  end;

end;

procedure TTareasPendientesFrm.rbVer3Enter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Muestra en el listado solo los planos pendientes de recepci�n';
  btnRecibirSel.Enabled:= True;
  btnRecibirTodos.Enabled:= True;
  btnAprobarSel.Enabled:= False;
  btnAprobarTodos.Enabled:= False;

  ListView.Clear;
  if not FPlanoDB.ConsultaPendientes(ListView, PLN_PEND_REC) then
  begin
    ShowMessage('No hay ning�n plano pendiente de recepci�n');
    btnRecibirSel.Enabled:= False;
    btnRecibirTodos.Enabled:= False;
    rbVer1.SetFocus;
  end;

end;

procedure TTareasPendientesFrm.btnAprobarTodosClick(Sender: TObject);
begin
  if MessageDlg('� Esta seguro que desea aprobar todos los planos ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    if FPlanoDB.CumplirTareasTodos(PLN_PEND_APR) = PLN_APR_OK then
      ShowMessage('Los planos se aprobaron satisfactoriamente')
    else
      ShowMessage('Los planos no se pudieron aprobar');
  end;
  ListView.Clear;
  if not FPlanoDB.ConsultaPendientes(ListView, PLN_PEND_TODOS) then
  begin
    ShowMessage('No hay ninguna tarea pendiente');
    AnularPantalla;
  end;
end;

procedure TTareasPendientesFrm.btnRecibirTodosClick(Sender: TObject);
begin
  if MessageDlg('� Esta seguro que desea recibir todos los planos ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    if FPlanoDB.CumplirTareasTodos(PLN_PEND_REC) = PLN_REC_OK then
      ShowMessage('Los planos se recibieron satisfactoriamente')
    else
      ShowMessage('Los planos no se pudieron recibir');
  end;
  ListView.Clear;
  if not FPlanoDB.ConsultaPendientes(ListView, PLN_PEND_TODOS) then
  begin
    ShowMessage('No hay ninguna tarea pendiente');
    AnularPantalla;
  end;
end;

procedure TTareasPendientesFrm.btnAprobarSelClick(Sender: TObject);
var
  sCodigos: string;
  Item: TListItem;
  CodRet: Integer;

begin
  sCodigos:= '';

  if ListView.SelCount > 0 then
  begin
    Item := ListView.Selected;
    while Item <> nil do
    begin
      if sCodigos = '' then
        sCodigos:= '''' + Item.Caption + ''''
      else
        sCodigos:= sCodigos + ', ''' + Item.Caption + '''';

      Item := ListView.GetNextItem(Item, sdAll, [isSelected]);
    end;

    if MessageDlg('� Esta seguro que desea aprobar los planos seleccionados ?', mtConfirmation, mbOKCancel, 0) = mrOK then
    begin
      CodRet:= FPlanoDB.CumplirTareasSel(PLN_PEND_APR, sCodigos);
      if CodRet = PLN_APR_OK then
        ShowMessage('Los planos seleccionados se aprobaron satisfactoriamente')
      else if CodRet = PLN_SEL_ERRONEA then
        ShowMessage('Est� intentando aprobar planos ya aprobados')
      else
        ShowMessage('Los planos seleccionados no se pudieron aprobar');
    //pongo el RadioButton checked en todos sino me muestra el de aprobados
      self.rbVer1.Checked:= true;
    end;
    ListView.Clear;
    if not FPlanoDB.ConsultaPendientes(ListView, PLN_PEND_TODOS) then
    begin
      ShowMessage('No hay ninguna tarea pendiente');
      AnularPantalla;
    end;
  end
  else
    ShowMessage('Debe seleccionar primero de listado los planos que desea aprobar');

end;

procedure TTareasPendientesFrm.btnRecibirSelClick(Sender: TObject);
var
  sCodigos: string;
  Item: TListItem;
  CodRet: Integer;

begin
  sCodigos:= '';

  if ListView.SelCount > 0 then
  begin
    Item := ListView.Selected;
    while Item <> nil do
    begin
      if sCodigos = '' then
        sCodigos:= '''' + Item.Caption + ''''
      else
        sCodigos:= sCodigos + ', ''' + Item.Caption + '''';

      Item := ListView.GetNextItem(Item, sdAll, [isSelected]);
    end;


    if MessageDlg('� Esta seguro que desea recibir los planos seleccionados ?', mtConfirmation, mbOKCancel, 0) = mrOK then
    begin
      CodRet:= FPlanoDB.CumplirTareasSel(PLN_PEND_REC, sCodigos);
      if CodRet = PLN_REC_OK then
        ShowMessage('Los planos seleccionados se recibieron satisfactoriamente')
      else if CodRet = PLN_SEL_ERRONEA then
        ShowMessage('Est� intentando recibir planos que a�n no fueron aprobados')
      else
        ShowMessage('Los planos seleccionados no se pudieron recibir');
    self.rbVer1.Checked:= true;
    end;

    ListView.Clear;
    if not FPlanoDB.ConsultaPendientes(ListView, PLN_PEND_TODOS) then
    begin
      ShowMessage('No hay ninguna tarea pendiente');
      AnularPantalla;
    end;
  end
  else
    ShowMessage('Debe seleccionar primero de listado los planos que desea recibir');
end;

procedure TTareasPendientesFrm.ListViewDblClick(Sender: TObject);
begin
  btnAbrir.Click;
end;

procedure TTareasPendientesFrm.ListViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
    btnAbrir.Click;
end;

procedure TTareasPendientesFrm.ListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  btnAbrir.Enabled:= False;
  if Selected then
    btnAbrir.Enabled:= ListView.Selected.SubItems[3] <> '';
end;

procedure TTareasPendientesFrm.btnAbrirClick(Sender: TObject);
begin
    if ListView.Selected.SubItems[3] <> '' then
    begin
      if ShellExecute( Self.Handle, 'explore'
                     , PChar(ListView.Selected.SubItems[3])
                     , nil, nil, SW_SHOWMAXIMIZED) <= 32 then
        Application.MessageBox('La ubicaci�n del plano no es correcta', 'SGPB', MB_ICONEXCLAMATION);
    end
    else
      Application.MessageBox('El registro del plano seleccionado no tiene ingresada la ubicaci�n del mismo', 'SGPB', MB_ICONINFORMATION,);
end;

procedure TTareasPendientesFrm.btnAbrirEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Abra la carpeta que contiene el archivo del plano seleccionado';
end;

procedure TTareasPendientesFrm.btnVovlerlClick(Sender: TObject);
begin
  self.Close;
end;

procedure TTareasPendientesFrm.btnVolvermClick(Sender: TObject);
begin
  self.Close;
end;

procedure TTareasPendientesFrm.btnVovlerlEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TTareasPendientesFrm.btnVolvermEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TTareasPendientesFrm.btnAprobarSellClick(Sender: TObject);
var
  sCodigos: string;
  Item: TListItem;
  CodRet: Integer;

begin
  sCodigos:= '';

  if ListViewL.SelCount > 0 then
  begin
    Item := ListViewL.Selected;
    while Item <> nil do
    begin
      if sCodigos = '' then
        sCodigos:= '''' + Item.Caption + ''''
      else
        sCodigos:= sCodigos + ', ''' + Item.Caption + '''';

      Item := ListViewL.GetNextItem(Item, sdAll, [isSelected]);
    end;

    if MessageDlg('� Esta seguro que desea aprobar las Listas de Materiales seleccionadas ?', mtConfirmation, mbOKCancel, 0) = mrOK then
    begin
      CodRet:= FListaDB.CumplirTareasSel(PLN_PEND_APR, sCodigos);
      if CodRet = PLN_APR_OK then
        ShowMessage('Las Listas de Materiales seleccionadas se aprobaron satisfactoriamente')
      else if CodRet = PLN_SEL_ERRONEA then
        ShowMessage('Est� intentando aprobar Listas de Materiales mediante el recibir')
      else
        ShowMessage('Las Listas de Materiales seleccionadas no se pudieron aprobar');
    //activo el chequeado en las listas de materiales
    self.rbVer1l.Checked:= true;
    end;
    ListViewL.Clear;
    if not FListaDB.ConsultaPendientes(ListViewL, PLN_PEND_TODOS) then
    begin
      ShowMessage('No hay ninguna tarea pendiente');
      AnularPantallaLM;
    end;
  end
  else
    ShowMessage('Debe seleccionar primero del listado las Listas de Materiales que desea aprobar');

end;

procedure TTareasPendientesFrm.btnAprobarTodoslClick(Sender: TObject);
begin
  if MessageDlg('� Esta seguro que desea aprobar todas las Listas de Materiales  ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    if FListaDB.CumplirTareasTodos(PLN_PEND_APR) = PLN_APR_OK then
      ShowMessage('Las Listas de Materiales se aprobaron satisfactoriamente')
    else
      ShowMessage('Las Listas de Materiales no se pudieron aprobar');
  end;
  ListViewL.Clear;
  if not FListaDB.ConsultaPendientes(ListViewL, PLN_PEND_TODOS) then
  begin
    ShowMessage('No hay ninguna tarea pendiente');
    AnularPantallaLM;
  end;
end;

procedure TTareasPendientesFrm.btnRecibirSellClick(Sender: TObject);
var
  sCodigos: string;
  Item: TListItem;
  CodRet: Integer;

begin
  sCodigos:= '';

  if ListViewL.SelCount > 0 then
  begin
    Item := ListViewL.Selected;
    while Item <> nil do
    begin
      if sCodigos = '' then
        sCodigos:= '''' + Item.Caption + ''''
      else
        sCodigos:= sCodigos + ', ''' + Item.Caption + '''';

      Item := ListViewL.GetNextItem(Item, sdAll, [isSelected]);
    end;

    if MessageDlg('� Esta seguro que desea recibir las Listas de Materiales seleccionadas ?', mtConfirmation, mbOKCancel, 0) = mrOK then
    begin
      CodRet:= FListaDB.CumplirTareasSel(PLN_PEND_REC, sCodigos);
      if CodRet = PLN_REC_OK then
        ShowMessage('Las Listas de Materiales seleccionadas se recibieron satisfactoriamente')
      else if CodRet = PLN_SEL_ERRONEA then
        ShowMessage('Est� intentando recibir Listas de Materiales que a�n no fueron aprobados')
      else
        ShowMessage('Las Listas de Materiales seleccionadas no se pudieron recibir');
    self.rbVer1l.Checked:= true;    
    end;

    ListViewL.Clear;
    if not FListaDB.ConsultaPendientes(ListViewL, PLN_PEND_TODOS) then
    begin
      ShowMessage('No hay ninguna tarea pendiente');
      AnularPantallaLM;
    end;
  end
  else
    ShowMessage('Debe seleccionar primero del listado las Listas de Materiales que desea recibir');
end;

procedure TTareasPendientesFrm.btnRecibirTodoslClick(Sender: TObject);
begin
  if MessageDlg('� Esta seguro que desea recibir todas las Listas de Materiales ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    if FListaDB.CumplirTareasTodos(PLN_PEND_REC) = PLN_REC_OK then
      ShowMessage('Las Listas de Materiales se recibieron satisfactoriamente')
    else
      ShowMessage('Las Listas de Materiales no se pudieron recibir');
  end;
  ListViewL.Clear;
  if not FListaDB.ConsultaPendientes(ListViewL, PLN_PEND_TODOS) then
  begin
    ShowMessage('No hay ninguna tarea pendiente');
    AnularPantallaLM;
  end;
end;

procedure TTareasPendientesFrm.rbVer1mClick(Sender: TObject);
begin
 self.ConsultarManuales(4);
end;

procedure TTareasPendientesFrm.rbVer2mClick(Sender: TObject);
begin
   self.ConsultarManuales(6);
 end;
procedure TTareasPendientesFrm.rbVer3mClick(Sender: TObject);
begin
   self.ConsultarManuales(5);
 end;

procedure TTareasPendientesFrm.btnAprobarSelmClick(Sender: TObject);
var
 sSQL: string;
 sCodigo : string;
 usuario: string;
 lista: TStringList;
 i,j: integer;
begin
 try
  lista:= TStringList.Create;
  usuario:= TSistema.getInstance.getUsuario.Logon;
 for i:= 1 to self.DBGrid2.SelectedRows.Count do
 begin
  sCodigo:=  self.DBGrid2.SelectedField.AsString;
  lista.Add(sCodigo);
  self.DBGrid2.SelectedField.DataSet.Prior;
 end;
 for j:= 0 to lista.Count -1 do
 begin
  self.ADODataSet2.Close;
  self.ADODataSet2.Connection:= TMotorSql.GetInstance().GetConn;
  TMotorSql.GetInstance().OpenConn;

  sSQL:= 'update MANUALESPRODUCTO '+
         'set PLN_USUARIO_APR = ' + QuotedStr(usuario)+
         ',PLN_FECHA_APR = ' + QuotedStr(DateToStr(Date))+
         ',PLN_ESTADO = ' +  QuotedStr('PR') +
         ' where PLN_CODIGO = (' + QuotedStr(lista[j]) + ')'+
         ' and PLN_ESTADO = ' +QuotedStr('PA');
   TMotorSql.GetInstance.ExecuteSQL(sSQL);
     if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
    else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
   //self.Consultar(4);
 end;
  finally
 lista.Destroy;
end;
  self.ConsultarManuales(4);
end;

procedure TTareasPendientesFrm.btnAprobarTodosmClick(Sender: TObject);
var
 sSQL: string;
 sCodigo : string;
 usuario: string;
begin
  usuario:= TSistema.getInstance.getUsuario.Logon;
  SCodigo:= '';
  self.ADODataSet2.Close;
  self.ADODataSet2.Connection:= TMotorSql.GetInstance().GetConn;
  TMotorSql.GetInstance().OpenConn;

  sSQL:= 'update MANUALESPRODUCTO '+
         'set PLN_USUARIO_APR = ' + QuotedStr(usuario)+
         ',PLN_FECHA_APR = ' + QuotedStr(DateToStr(Date))+
         ',PLN_ESTADO = ' +  QuotedStr('PR') +
         ' where PLN_ESTADO =  ''PA''';

   TMotorSql.GetInstance.ExecuteSQL(sSQL);
     if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
    else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
 //  self.FormShow(Sender);
 self.ConsultarManuales(4);
end;
procedure TTareasPendientesFrm.btnRecibirTodosmClick(Sender: TObject);
var
 sSQL: string;
 sCodigo : string;
 usuario: string;
begin
  usuario:= TSistema.getInstance.getUsuario.Logon;
  SCodigo:= '';
  self.ADODataSet2.Close;
  self.ADODataSet2.Connection:= TMotorSql.GetInstance().GetConn;
  TMotorSql.GetInstance().OpenConn;

  sSQL:= 'update MANUALESPRODUCTO '+
         'set PLN_USUARIO_REC = ' + QuotedStr(usuario)+
         ',PLN_FECHA_REC = ' + QuotedStr(DateToStr(Date))+
         ',PLN_ESTADO = ' +  QuotedStr('AC') +
         ' where PLN_ESTADO =  ''PR''';

   TMotorSql.GetInstance.ExecuteSQL(sSQL);
     if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
    else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
 //  self.FormShow(Sender);
 self.ConsultarManuales(4);
end;

procedure TTareasPendientesFrm.btnRecibirSelmClick(Sender: TObject);
var
 sSQL: string;
 sCodigo : string;
 usuario: string;
 lista: TStringList;
 i,j: integer;
begin
 try
  lista:= TStringList.Create;
  usuario:= TSistema.getInstance.getUsuario.Logon;
  for i:= 1 to self.DBGrid2.SelectedRows.Count do
  begin
   sCodigo:=  self.DBGrid2.SelectedField.AsString;
   lista.Add(sCodigo);
   self.DBGrid2.SelectedField.DataSet.Prior;
  end;
  for j:= 0 to lista.Count -1 do
  begin
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance().GetConn;
  TMotorSql.GetInstance().OpenConn;

  sSQL:= 'update MANUALESPRODUCTO '+
         'set PLN_USUARIO_REC = ' + QuotedStr(usuario)+
         ',PLN_FECHA_REC = ' + QuotedStr(DateToStr(Date))+
         ',PLN_ESTADO = ' +  QuotedStr('AC') +
         ' where PLN_CODIGO = (' + QuotedStr(lista[j]) + ')'+
         ' and PLN_ESTADO = ' +QuotedStr('PR');
   TMotorSql.GetInstance.ExecuteSQL(sSQL);
     if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
    else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
 end;
  finally
   lista.Destroy;
  end;
   self.ConsultarManuales(4);
end;

procedure TTareasPendientesFrm.btnAbrirlClick(Sender: TObject);
begin
    if ListViewL.Selected.SubItems[3] <> '' then
    begin
      if ShellExecute( Self.Handle, 'explore'
                     , PChar(ListView.Selected.SubItems[3])
                     , nil, nil, SW_SHOWMAXIMIZED) <= 32 then
        Application.MessageBox('La ubicaci�n de la Lista de Materiales no es correcta', 'SGPB', MB_ICONEXCLAMATION);
    end
    else
      Application.MessageBox('El registro de la Lista de Materiales seleccionada no tiene ingresada la ubicaci�n de la misma', 'SGPB', MB_ICONINFORMATION,);
end;

procedure TTareasPendientesFrm.btnAbrirmClick(Sender: TObject);
var
  UbicacionPlano : string;
begin
  if self.DBGrid2.DataSource.DataSet<>nil then
  Begin

    UbicacionPlano := self.DBGrid2.DataSource.DataSet.fieldByName('Ubicacion').AsString;

          if UbicacionPlano<>'' then
          begin
            if ShellExecute( Self.Handle, 'explore'
                   , PChar(UbicacionPlano)
                   , nil, nil, SW_SHOWMAXIMIZED) <= 32 then
                    Application.MessageBox('La ubicaci�n del Manual no existe', 'SGPB', MB_ICONEXCLAMATION);
          end;

  end;
end;

procedure TTareasPendientesFrm.btnAbrirmEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Abra la carpeta que contiene el archivo del Manual seleccionado';
end;

procedure TTareasPendientesFrm.btnAbrirlEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Abra la carpeta que contiene el archivo de la Lista de Materiales seleccionado';
end;

procedure TTareasPendientesFrm.btnRecibirTodoslEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Recibir todas las Listas de Materiales listadas';
end;

procedure TTareasPendientesFrm.btnRecibirTodosmEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Recibir todos los Manuales listados';
end;

procedure TTareasPendientesFrm.btnRecibirSelmEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Recibir todos los Manuales seleccionados del listado';
end;

procedure TTareasPendientesFrm.btnRecibirSellEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Recibir todas las Listas de Materiales seleccionadas del listado';
end;

procedure TTareasPendientesFrm.btnAprobarTodosmEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Aprobar todos los Manuales listados';
end;

procedure TTareasPendientesFrm.btnAprobarTodoslEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Aprobar todas las Listas de Materiales listadas';
end;

procedure TTareasPendientesFrm.btnAprobarSelmEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Aprobar todos los Manuales seleccionados del listado';
end;

procedure TTareasPendientesFrm.btnAprobarSellEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Aprobar todas las Listas de Materiales seleccionadas del listado';
end;

procedure TTareasPendientesFrm.btnVolverDvClick(Sender: TObject);
begin
  self.Close;
end;

procedure TTareasPendientesFrm.rbVer1DvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Muestra en el listado todas las tareas pendientes';
end;

procedure TTareasPendientesFrm.rbVer1lEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Muestra en el listado todas las tareas pendientes';
  HabilitarPantallaLM;
  self.ListViewL.Clear;

  if not FListaDB.ConsultaPendientes(ListViewL, PLN_PEND_TODOS) then
  begin
    self.AnularPantallaLM;
  end;
end;

procedure TTareasPendientesFrm.rbVer2lEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Muestra en el listado solo las Listas de Materiales pendientes de aprobaci�n';
  btnAprobarSell.Enabled:= True;
  btnAprobarTodosl.Enabled:= True;
  btnRecibirSell.Enabled:= False;
  btnRecibirTodosl.Enabled:= False;

  self.ListViewL.Clear;
  if not FListaDB.ConsultaPendientes(ListViewL, PLN_PEND_APR) then
  begin
    ShowMessage('No hay ning�na Lista de Materiales pendiente de aprobaci�n');
    btnAprobarSell.Enabled:= False;
    btnAprobarTodosl.Enabled:= False;
    rbVer1l.SetFocus;
  end;
end;

procedure TTareasPendientesFrm.rbVer2mEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Muestra en el listado solo los Manuales pendientes de aprobaci�n';
end;

procedure TTareasPendientesFrm.rbVer3mEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Muestra en el listado solo los Manuales pendientes de recepci�n'
end;

procedure TTareasPendientesFrm.rbVer3DvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Muestra en el listado solo los Documentos pendientes de recepci�n'
end;

procedure TTareasPendientesFrm.PageControl1Enter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Muestra en el listado solo las Listas de Materiales pendientes de recepci�n'
end;

procedure TTareasPendientesFrm.rbVer3lEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Muestra en el listado solo las Listas de Materiales pendientes de recepci�n';
  btnRecibirSell.Enabled:= True;
  btnRecibirTodosl.Enabled:= True;
  btnAprobarSell.Enabled:= False;
  btnAprobarTodosl.Enabled:= False;

  ListViewL.Clear;
  if not FListaDB.ConsultaPendientes(ListViewL, PLN_PEND_REC) then
  begin
    ShowMessage('No hay ning�na Lista de Materiales pendiente de recepci�n');
    btnRecibirSell.Enabled:= False;
    btnRecibirTodosl.Enabled:= False;
    rbVer1l.SetFocus;
  end;
end;

procedure TTareasPendientesFrm.ListViewLDblClick(Sender: TObject);
begin
    btnAbrirl.Click;
end;

procedure TTareasPendientesFrm.ListViewLSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  btnAbrirl.Enabled:= False;
  if Selected then
    btnAbrirl.Enabled:= ListViewL.Selected.SubItems[3] <> '';
end;

procedure TTareasPendientesFrm.ListViewLKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
    btnAbrirl.Click;
end;

procedure TTareasPendientesFrm.ListViewLColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index<>SortedColumn then
begin
  SortedColumn := Column.Index;
  Descending := False;
end
else
  Descending := not Descending;
  TListView(Sender).SortType := stText;
end;

procedure TTareasPendientesFrm.ListViewLCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);

begin
  if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)
  else
   if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
  if Descending then Compare := -Compare;
end;

procedure TTareasPendientesFrm.ListViewColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index<>SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end
  else
    Descending := not Descending;
    TListView(Sender).SortType := stText;
end;

procedure TTareasPendientesFrm.ListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)
  else
    if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
    if Descending then Compare := -Compare;
end;

end.
