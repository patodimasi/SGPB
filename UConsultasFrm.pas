unit UConsultasFrm;

interface

uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, UPantallaFrm, DB, ADODB, UMotorSQL, Grids,
  DBGrids, ImgList, UMateriales, ContNrs,shlobj, ExtCtrls;
const
  { For Windows >= XP }
  {$EXTERNALSYM HDF_SORTUP}
  HDF_SORTUP              = $0400;
  {$EXTERNALSYM HDF_SORTDOWN}
  HDF_SORTDOWN            = $0200;

type

  TProducto = class
  private
    FNombre:string;
    FListaMateriales:TObjectList;
  public
    property Nombre:string read FNombre write FNombre;
    property ListaMateriales:TObjectList read FListaMateriales write FListaMateriales;
    Constructor Create;
    destructor Destroy;
  end;

  TConsultasFrm = class(TPantallaFrm)
    stbPlano: TStatusBar;
    btnLimpiar: TButton;
    btnVolver: TButton;
    ListView: TListView;
    btnBuscar: TButton;
    btnTodos: TButton;
    lblCodigo: TLabel;
    lblDescripcion: TLabel;
    lblNroRev: TLabel;
    edtCodigo: TEdit;
    edtDescripcion: TEdit;
    lblCodigoDesde: TLabel;
    edtCodigoDesde: TEdit;
    lblCodigoHasta: TLabel;
    edtCodigoHasta: TEdit;
    lblNroRevDesde: TLabel;
    lblNroRevHasta: TLabel;
    gbTabla: TGroupBox;
    rbUltRev: TRadioButton;
    rbHist: TRadioButton;
    rbTodos: TRadioButton;
    edtNroRev: TEdit;
    edtNroRevDesde: TEdit;
    edtNroRevHasta: TEdit;
    lblLogon: TLabel;
    edtAlta: TEdit;
    Label1: TLabel;
    edtAprobacion: TEdit;
    Label2: TLabel;
    edtRecepcion: TEdit;
    btnAbrir: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    lblCodigolm: TLabel;
    edtCodigolm: TEdit;
    lblCodigoDesdelm: TLabel;
    edtCodigoDesdelm: TEdit;
    lblCodigoHastalm: TLabel;
    edtCodigoHastalm: TEdit;
    gbTablalm: TGroupBox;
    rbUltRevlm: TRadioButton;
    rbHistlm: TRadioButton;
    rbTodoslm: TRadioButton;
    lblNroRevlm: TLabel;
    edtNroRevlm: TEdit;
    lblNroRevDesdelm: TLabel;
    edtNroRevDesdelm: TEdit;
    lblNroRevHastalm: TLabel;
    edtNroRevHastalm: TEdit;
    btnBuscarlm: TButton;
    btnAbrirlm: TButton;
    btnTodoslm: TButton;
    btnLimpiarlm: TButton;
    btnVolverlm: TButton;
    Label8: TLabel;
    lblDescripcionlm: TLabel;
    edtDescripcionlm: TEdit;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    TabSheet3: TTabSheet;
    lblCodigomp: TLabel;
    edtCodigomp: TEdit;
    lblCodigoDesdemp: TLabel;
    edtCodigoDesdemp: TEdit;
    lblCodigoHastamp: TLabel;
    edtCodigoHastamp: TEdit;
    lblNroRevmp: TLabel;
    edtNroRevmp: TEdit;
    Label3: TLabel;
    edtNroRevDesdemp: TEdit;
    lblNroRevHastamp: TLabel;
    edtNroRevHastamp: TEdit;
    lblDescripcionmp: TLabel;
    edtDescripcionmp: TEdit;
    lbllogonmp: TLabel;
    edtAltamp: TEdit;
    Label1mp: TLabel;
    edtAprobacionmp: TEdit;
    Label2mp: TLabel;
    edtRecepcionmp: TEdit;
    btnAbrirmp: TButton;
    btnBuscarmp: TButton;
    btnTodosmp: TButton;
    btnLimpiarmp: TButton;
    btnVolvermp: TButton;
    ADODataSet2: TADODataSet;
    DataSource3: TDataSource;
    ADODataSet3: TADODataSet;
    gbTablamp: TGroupBox;
    rbUltRevmp: TRadioButton;
    rbHismp: TRadioButton;
    rbTodosmp: TRadioButton;
    TreeView1: TTreeView;
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label7: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TabSheet5: TTabSheet;
    lblCodigosp: TLabel;
    lblNroRevsp: TLabel;
    lblDescripcionsp: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtCodigosp: TEdit;
    edtNroRevsp: TEdit;
    edtDescripcionsp: TEdit;
    edtAltasp: TEdit;
    edtAprobacionsp: TEdit;
    edtRecepcionsp: TEdit;
    lblCodigoDesdesp: TLabel;
    edtCodigoDesdesp: TEdit;
    lblCodigoHastasp: TLabel;
    edtCodigoHastasp: TEdit;
    lblNroRevDesdesp: TLabel;
    edtNroRevDesdesp: TEdit;
    lblNroRevHastasp: TLabel;
    edtNroRevHastasp: TEdit;
    GroupBox2: TGroupBox;
    rbUltRevsp: TRadioButton;
    rbHistsp: TRadioButton;
    rbTodossp: TRadioButton;
    ListViewsp: TListView;
    btnAbrirsp: TButton;
    btnBuscarsp: TButton;
    btnTodossp: TButton;
    btnLimpiarsp: TButton;
    btnVolversp: TButton;
    GroupBox3: TGroupBox;
    Image4: TImage;
    Label11: TLabel;
    Image5: TImage;
    Label12: TLabel;
    Image6: TImage;
    Label13: TLabel;
    Label17: TLabel;
    GroupBox4: TGroupBox;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label4: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    ListViewlm: TListView;
    ListViewmp: TListView;
    TabSheet4: TTabSheet;
    lblCodigoip: TLabel;
    lblNroRevip: TLabel;
    lblDescripcionip: TLabel;
    lblLogonip: TLabel;
    Label22ip: TLabel;
    Label10ip: TLabel;
    edtCodigoip: TEdit;
    edtNroRevip: TEdit;
    edtDescripcionip: TEdit;
    edtAltaip: TEdit;
    edtAprobacionip: TEdit;
    edtRecepcionip: TEdit;
    lblCodigoDesdeip: TLabel;
    edtCodigoDesdeip: TEdit;
    Label10: TLabel;
    lblCodigoHastaip: TLabel;
    edtCodigoHastaip: TEdit;
    lblNroRevDesdeip: TLabel;
    edtNroRevDesdeip: TEdit;
    lblNroRevHastaip: TLabel;
    edtNroRevHastaip: TEdit;
    gbTablaip: TGroupBox;
    rbHistip: TRadioButton;
    rbUltRevip: TRadioButton;
    rbTodosip: TRadioButton;
    ListViewip: TListView;
    GroupBox5: TGroupBox;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    btnAbririp: TButton;
    btnBuscarip: TButton;
    btnTodosip: TButton;
    btnLimpiarip: TButton;
    btnVolverip: TButton;
    GroupBox6: TGroupBox;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    procedure btnVolverEnter(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnVolverlmEnter(Sender: TObject);
    procedure btnVovlerlmClick(Sender: TObject);
    procedure btnVolvermpClick(Sender: TObject);
    procedure btnVolvermpEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnLimpiarlmEnter(Sender: TObject);
    procedure btnLimpiarmpEnter(Sender: TObject);
    procedure btnTodosEnter(Sender: TObject);
    procedure btnTodoslmEnter(Sender: TObject);
    procedure btnTodosmpEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure btnBuscarlmEnter(Sender: TObject);
    procedure btnBuscarmpEnter(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnTodoslmClick(Sender: TObject);
    procedure btnTodosmpClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnLimpiarlmClick(Sender: TObject);
    procedure btnLimpiarmpClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnBuscarlmClick(Sender: TObject);
    procedure btnBuscarmpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListViewDblClick(Sender: TObject);
    procedure ListViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    //procedure btnAbrirlmClick(Sender: TObject);
    procedure btnAbrirEnter(Sender: TObject);
    procedure btnAbrirlmEnter(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigolmEnter(Sender: TObject);
    procedure edtCodigompEnter(Sender: TObject);
    procedure edtCodigoDesdeEnter(Sender: TObject);
    procedure edtCodigoDesdelmEnter(Sender: TObject);
    procedure edtCodigoDesdempEnter(Sender: TObject);
    procedure edtCodigoHastaEnter(Sender: TObject);
    procedure edtCodigoHastalmEnter(Sender: TObject);
    procedure edtCodigoHastampEnter(Sender: TObject);
    procedure edtNroRevEnter(Sender: TObject);
    procedure edtNroRevlmEnter(Sender: TObject);
    procedure edtNroRevmpEnter(Sender: TObject);
    procedure edtNroRevDesdeEnter(Sender: TObject);
    procedure edtNroRevDesdelmEnter(Sender: TObject);
    procedure edtNroRevDesdempEnter(Sender: TObject);
    procedure edtNroRevHastaEnter(Sender: TObject);
    procedure edtNroRevHastalmEnter(Sender: TObject);
    procedure edtNroRevHastampEnter(Sender: TObject);
    procedure edtDescripcionEnter(Sender: TObject);
    procedure edtDescripcionlmEnter(Sender: TObject);
    procedure edtDescripcionmpEnter(Sender: TObject);
    procedure edtAltaEnter(Sender: TObject);
    procedure edtAltalmEnter(Sender: TObject);
    procedure edtAltampEnter(Sender: TObject);
    procedure edtRecepcionEnter(Sender: TObject);
    procedure edtRecepcionlmEnter(Sender: TObject);
    procedure edtRecepcionmpEnter(Sender: TObject);
    procedure rbUltRevEnter(Sender: TObject);
    procedure rbHistEnter(Sender: TObject);
    procedure rbTodosEnter(Sender: TObject);
    procedure cbDiaDAltaEnter(Sender: TObject);
    procedure cbMesDAltaEnter(Sender: TObject);
    procedure cbDiaHAltaEnter(Sender: TObject);
    procedure cbMesHAltaEnter(Sender: TObject);
    procedure cbAnioHAltaEnter(Sender: TObject);
    procedure cbDiaDAprEnter(Sender: TObject);
    procedure cbMesDAprEnter(Sender: TObject);
    procedure cbAnioDAprEnter(Sender: TObject);
    procedure cbDiaHAprEnter(Sender: TObject);
    procedure cbMesHAprEnter(Sender: TObject);
    procedure cbAnioHAprEnter(Sender: TObject);
    procedure cbDiaDRecEnter(Sender: TObject);
    procedure cbMesDRecEnter(Sender: TObject);
    procedure cbAnioDRecEnter(Sender: TObject);
    procedure cbDiaHRecEnter(Sender: TObject);
    procedure cbMesHRecEnter(Sender: TObject);
    procedure cbAnioHRecEnter(Sender: TObject);
    procedure cbAnioDAltaEnter(Sender: TObject);
    procedure edtAprobacionEnter(Sender: TObject);
    procedure edtAprobacionlmEnter(Sender:TObject);
    procedure edtAprobacionmpEnter(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirmpClick(Sender: TObject);
    procedure DBGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirmpEnter(Sender: TObject);
    procedure edtCodigodvEnter(Sender: TObject);
    procedure edtNroRevdvEnter(Sender: TObject);
    procedure edtNroRevDesdedvEnter(Sender: TObject);
    procedure edtNroRevHastadvEnter(Sender: TObject);
    procedure edtDescrpciondvEnter(Sender: TObject);
    procedure edtAltadvEnter(Sender: TObject);
    procedure edtAprobaciondvEnter(Sender: TObject);
    procedure edtRecepciondvEnter(Sender: TObject);
    procedure btnAbrirdvEnter(Sender: TObject);
    procedure btnBuscardvEnter(Sender: TObject);
    procedure btnTodosdvEnter(Sender: TObject);
    procedure btnLimpiardvEnter(Sender: TObject);
    procedure btnVolverdvEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1CustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Lista;
    procedure TreeView1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
   // procedure TreeView1Compare(Sender: TObject; Node1, Node2: TTreeNode;
   //   Data: Integer; var Compare: Integer);
    procedure ConsultarCodigo(Codigo: string);
    procedure Button1Click(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigolmKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigompKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescripcionKeyPress(Sender: TObject; var Key: Char);
    procedure edtAltaKeyPress(Sender: TObject; var Key: Char);
    procedure edtAprobacionKeyPress(Sender: TObject; var Key: Char);
    procedure edtRecepcionKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoDesdeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoHastaKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescripcionmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtAltampKeyPress(Sender: TObject; var Key: Char);
    procedure edtAprobacionmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtRecepcionmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnVolverspClick(Sender: TObject);
    procedure btnLimpiarspClick(Sender: TObject);
    procedure btnBuscarspClick(Sender: TObject);
    procedure edtCodigospEnter(Sender: TObject);
    procedure btnLimpiarspEnter(Sender: TObject);
    procedure edtCodigoDesdespEnter(Sender: TObject);
    procedure edtCodigoHastaspEnter(Sender: TObject);
    procedure edtNroRevspEnter(Sender: TObject);
    procedure edtNroRevDesdespEnter(Sender: TObject);
    procedure edtNroRevHastaspEnter(Sender: TObject);
    procedure edtDescripcionspEnter(Sender: TObject);
    procedure edtAltaspEnter(Sender: TObject);
    procedure edtAprobacionspEnter(Sender: TObject);
    procedure edtRecepcionspEnter(Sender: TObject);
    procedure ListViewspCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnTodosspClick(Sender: TObject);
    procedure btnAbrirspClick(Sender: TObject);
    procedure edtCodigospKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescripcionspKeyPress(Sender: TObject; var Key: Char);
    procedure edtNroRevspKeyPress(Sender: TObject; var Key: Char);
    procedure edtNroRevKeyPress(Sender: TObject; var Key: Char);
    procedure edtAltaspKeyPress(Sender: TObject; var Key: Char);
    procedure edtAprobacionspKeyPress(Sender: TObject; var Key: Char);
    procedure edtRecepcionspKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListViewspColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewspCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListViewlmCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListViewlmColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewlmCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ShowArrowOfListViewColumn(ListView1: TListView; ColumnIdx: integer; Descending: boolean);
    procedure ListViewmpCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnBuscaripClick(Sender: TObject);
    procedure btnLimpiaripClick(Sender: TObject);
    procedure btnTodosipClick(Sender: TObject);
    procedure ListViewipCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnVolveripClick(Sender: TObject);
    procedure btnAbriripClick(Sender: TObject);
    procedure edtCodigoipKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewmpDblClick(Sender: TObject);
    procedure ListViewspDblClick(Sender: TObject);
    procedure ListViewipDblClick(Sender: TObject);
    procedure btnAbrirlmClick(Sender: TObject);
    procedure ListViewlmDblClick(Sender: TObject);

  private
    FSQL: string;
    procedure Consultar;
    procedure Consultarsp;
    procedure Consultarlm;
    procedure Consultarmp;
    procedure Consultarip;
    function SonDatosValidos(): Boolean;
    function SonDatosValidoslm(): Boolean;
    function SonDatosValidosmp(): Boolean;
    function SonDatosValidossp(): Boolean;
    function SonDatosValidosip(): Boolean;
    function Where(var W: Boolean): string;
  end;

var
  ConsultasFrm: TConsultasFrm;
  nodeverde: TTreenode;
  TvectorCliente : Array [1..18] of TProducto;

  Descending: Boolean;
  SortedColumn: Integer;

implementation
uses
  UPlano,ULista, USistema, UUtiles, ShellAPI,SysUtils,CommCtrl;
{$R *.dfm}

procedure TConsultasFrm.ShowArrowOfListViewColumn(ListView1: TListView; ColumnIdx: integer; Descending: boolean);
var
  Header: HWND;
  Item: THDItem;
begin
  Header := ListView_GetHeader(ListView1.Handle);
  ZeroMemory(@Item, SizeOf(Item));
  Item.Mask := HDI_FORMAT;
  Header_GetItem(Header, ColumnIdx, Item);
//  Item.fmt := Item.fmt and not (HDF_SORTUP or HDF_SORTDOWN);//remove both flags
  if Descending then
//    Item.fmt := Item.fmt or HDF_SORTDOWN
  else
 //   Item.fmt := Item.fmt or HDF_SORTUP;//include the sort ascending flag
  Header_SetItem(Header, ColumnIdx, Item);
end;

procedure TConsultasFrm.Lista;
var i: integer;
 sSQL: string;
 materiales: TMateriales;
 ADOConeccion: TADOConnection;
 ADO_QUERY: TADOQuery;
 nodohijo: TTreenode;
 archivo: string;
 contador: integer;
 DstRPO,DstDMC: TADODataset;
 DstABo,DstPLSC,DstPL1001: TADODataset;
 DstDCF,DstMO2,DstMOD,DstPL1,DstSA: TADODataset;
 DstDPT,DstMAI2,DstMB04,DstRec,DstRsc: TADODataset;
 DstSi,DstSA4: TADODataset;
 begin

  ADO_QUERY:= TADOQuery.Create(ConsultasFrm);
 if Tsistema.GetInstance.DataBaseExists then
 begin
  archivo:= Tsistema.GetInstance.GetDataBaseFilename;
  ADOConeccion:= TADOConnection.Create(nil);
  ADOConeccion.ConnectionString:= 'Provider=Microsoft.Jet.OLEDB.4.0;'
                                 +'Data Source='
                                 + archivo
                                 + ';'
                                 + 'Persist Security Info=False';
  ADOConeccion.LoginPrompt:= False;
  ADO_QUERY.Connection:= ADOConeccion;
  ADO_QUERY.SQL.Clear;
  ADO_QUERY.SQL.Add('select PLN_CODIGO,PLN_ESTADO from MATERIALES where PLN_CODIGO like'+ quotedStr('LB9-012'+'%'));
  ADO_QUERY.Open;

  TvectorCliente[1].Nombre:= 'CV2000';

  while not (ADO_QUERY.Eof) do
  begin
   Materiales:= TMateriales.Create;
   materiales.Codigol:= ADO_QUERY.fieldByName('PLN_CODIGO').AsString;
   materiales.Estado:=  ADO_QUERY.fieldByName('PLN_ESTADO').AsString;
   TvectorCliente[1].ListaMateriales.Add(materiales);
   ADO_QUERY.Next;
  end;
    DstRPO:=  TADODataset.Create(nil);
    DstRPO.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-003'+'%');
    DstRPO.CommandText:= sSQL;
    DstRPO.Close;
    DstRPO.Open;
   while not (DstRPO.Eof) do
   begin
     Materiales:= TMateriales.Create;
     materiales.Codigol:= DstRPO.fieldByName('PLN_CODIGO').AsString;
     materiales.Estado:= DstRPO.fieldByName('PLN_ESTADO').AsString;
     TvectorCliente[2].ListaMateriales.Add(materiales);
     DstRPO.Next;
   end;
    DstDMC:=  TADODataset.Create(nil);
    DstDMC.Connection:=  ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-004'+'%');
    DstDMC.CommandText:= sSQL;
    DstDMc.Close;
    DstDMC.Open;
   while not (DstDMC.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstDMC.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstDMC.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[3].ListaMateriales.Add(materiales);
    DstDMC.Next;
   end;
    DstABo:=  TADODataset.Create(nil);
    DstABo.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-002'+'%');
    DstABo.CommandText:= sSQL;
    DstABo.Close;
    DstABo.Open;
  while not (DstABo.Eof) do
  begin
   Materiales:= TMateriales.Create;
   materiales.Codigol:= DstABo.fieldByName('PLN_CODIGO').AsString;
   materiales.Estado:=  DstABo.fieldByName('PLN_ESTADO').AsString;
   TvectorCliente[4].ListaMateriales.Add(materiales);
   DstABo.Next;
  end;
    DstDCF:=  TADODataset.Create(nil);
    DstDCF.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-014'+'%');
    DstDCF.CommandText:= sSQL;
    DstDCF.Close;
    DstDCF.Open;
   while not (DstDCF.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstDCF.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstDCF.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[5].ListaMateriales.Add(materiales);
    DstDCF.Next;
   end;
    DstDPT:=  TADODataset.Create(nil);
    DstDPT.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-013'+'%');
    DstDPT.CommandText:= sSQL;
    DstDPT.Close;
    DstDPT.Open;
   while not (DstDPT.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstDPT.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstDPT.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[6].ListaMateriales.Add(materiales);
    DstDPT.Next;
   end;
    DstMAI2:=  TADODataset.Create(nil);
    DstMAI2.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-007'+'%');
    DstMAI2.CommandText:= sSQL;
    DstMAI2.Close;
    DstMAI2.Open;
   while not (DstMAI2.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstMAI2.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstMAI2.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[7].ListaMateriales.Add(materiales);
    DstMAI2.Next;
   end;
    DstMB04:=  TADODataset.Create(nil);
    DstMB04.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-018'+'%');
    DstMB04.CommandText:= sSQL;
    DstMB04.Close;
    DstMB04.Open;
   while not (DstMB04.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstMB04.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstMB04.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[8].ListaMateriales.Add(materiales);
    DstMB04.Next;
   end;
    DstMO2:=  TADODataset.Create(nil);
    DstMO2.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-008'+'%');
    DstMO2.CommandText:= sSQL;
    DstMO2.Close;
    DstMO2.Open;
   while not (DstMO2.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstMO2.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstMO2.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[9].ListaMateriales.Add(materiales);
    DstMO2.Next;
   end;
    DstMOD:=  TADODataset.Create(nil);
    DstMOD.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-019'+'%');
    DstMOD.CommandText:= sSQL;
    DstMOD.Close;
    DstMOD.Open;
   while not (DstMOD.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstMOD.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstMOD.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[10].ListaMateriales.Add(materiales);
    DstMOD.Next;
   end;
    DstPLSC:=  TADODataset.Create(nil);
    DstPLSC.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-015'+'%');
    DstPLSC.CommandText:= sSQL;
    DstPLSC.Close;
    DstPLSC.Open;
   while not (DstPLSC.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstPLSC.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstPLSC.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[11].ListaMateriales.Add(materiales);
    DstPLSC.Next;
   end;
    DstPL1001:=  TADODataset.Create(nil);
    DstPL1001.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-001'+'%');
    DstPL1001.CommandText:= sSQL;
    DstPL1001.Close;
    DstPL1001.Open;
   while not (DstPL1001.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstPL1001.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstPL1001.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[12].ListaMateriales.Add(materiales);
    DstPL1001.Next;
   end;
    DstPL1:=  TADODataset.Create(nil);
    DstPL1.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-016'+'%');
    DstPL1.CommandText:= sSQL;
    DstPL1.Close;
    DstPL1.Open;
   while not (DstPL1.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstPL1.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstPL1.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[13].ListaMateriales.Add(materiales);
    DstPL1.Next;
   end;
    DstRec:=  TADODataset.Create(nil);
    DstRec.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-011'+'%');
    DstRec.CommandText:= sSQL;
    DstRec.Close;
    DstRec.Open;
   while not (DstRec.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstRec.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstRec.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[14].ListaMateriales.Add(materiales);
    DstRec.Next;
   end;
    DstRsc:=  TADODataset.Create(nil);
    DstRsc.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-009'+'%');
    DstRsc.CommandText:= sSQL;
    DstRsc.Close;
    DstRsc.Open;
   while not (DstRsc.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstRsc.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstRsc.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[15].ListaMateriales.Add(materiales);
    DstRsc.Next;
   end;
    DstSA:=  TADODataset.Create(nil);
    DstSA.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-005'+'%');
    DstSA.CommandText:= sSQL;
    DstSA.Close;
    DstSA.Open;
   while not (DstSA.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstSA.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstSA.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[16].ListaMateriales.Add(materiales);
    DstSA.Next;
   end;
    DstSi:=  TADODataset.Create(nil);
    DstSi.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-006'+'%');
    DstSi.CommandText:= sSQL;
    DstSi.Close;
    DstSi.Open;
   while not (DstSi.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstSi.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstSi.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[17].ListaMateriales.Add(materiales);
    DstSi.Next;
   end;
    DstSA4:=  TADODataset.Create(nil);
    DstSA4.Connection:= ADOConeccion ;
    sSQL:= 'select PLN_CODIGO,PLN_ESTADO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-017'+'%');
    DstSA4.CommandText:= sSQL;
    DstSA4.Close;
    DstSA4.Open;
   while not (DstSA4.Eof) do
   begin
    Materiales:= TMateriales.Create;
    materiales.Codigol:= DstSA4.fieldByName('PLN_CODIGO').AsString;
    materiales.Estado:=  DstSA4.fieldByName('PLN_ESTADO').AsString;
    TvectorCliente[18].ListaMateriales.Add(materiales);
    DstSA4.Next;
   end;
end;
end;

procedure TConsultasFrm.btnVolverEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TConsultasFrm.btnVolverlmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TConsultasFrm.btnVolvermpEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TConsultasFrm.btnVolverClick(Sender: TObject);
begin
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TConsultasFrm.btnVolvermpClick(Sender: TObject);
begin
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TConsultasFrm.btnVovlerlmClick(Sender: TObject);
begin
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TConsultasFrm.btnLimpiarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla para '
                        + 'poder realizar una nueva consulta';
end;
procedure TConsultasFrm.btnLimpiarlmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla para '
                        + 'poder realizar una nueva consulta';
end;
procedure TConsultasFrm.btnLimpiarmpEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla para '
                        + 'poder realizar una nueva consulta';
end;
procedure TConsultasFrm.btnTodosEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Devuelve el listado de todos los planos que '
                      + 'existen en la base de datos';
end;
procedure TConsultasFrm.btnTodoslmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Devuelve el listado de todas las Listas de Materiales que '
                      + 'existen en la base de datos';
end;
procedure TConsultasFrm.btnTodosmpEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Devuelve el listado de todos los Manuales que '
                      + 'existen en la base de datos';
end;
procedure TConsultasFrm.btnBuscarEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Busca todos los planos que cumplan '
                      + 'con el criterio de búsqueda ingresado';
end;
procedure TConsultasFrm.btnBuscarlmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Busca todos los planos que cumplan '
                       + 'con el criterio de búsqueda ingresado';
end;
procedure TConsultasFrm.btnBuscarmpEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Busca todos los planos que cumplan '
                       + 'con el criterio de búsqueda ingresado';
end;
procedure TConsultasFrm.btnTodosClick(Sender: TObject);
begin
  if rbUltRev.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO, PLN_SUPERADO ' +
           ' from PLANO order by 2,3,1'
  else if rbHist.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from HISTORICO order by 2,3,1'
  else if rbTodos.Checked then
    FSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from PLANO ' +
           ' union ' +
           'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from HISTORICO ';

  Consultar;
end;

procedure TConsultasFrm.btnTodoslmClick(Sender: TObject);
begin
  if rbUltRev.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO, PLN_SUPERADO ' +
           ' from MATERIALES order by 2,3,1'
  else if rbHist.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from HISTORICOMATERIALES order by 2,3,1'
  else if rbTodos.Checked then
    FSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from MATERIALES ' +
           ' union ' +
           'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from HISTORICOMATERIALES ';

  Consultarlm;
end;

procedure TConsultasFrm.btnTodosmpClick(Sender: TObject);
begin
  if rbUltRevmp.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO, PLN_SUPERADO ' +
           ' from MANUALESPRODUCTO order by 2,3,1'
  else if rbHismp.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from HISTORICOMANUALES order by 2,3,1'
  else if rbTodosmp.Checked then
    FSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from MANUALESPRODUCTO ' +
           ' union ' +
           'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from HISTORICOMANUALES ';

  Consultarmp;
end;

procedure TConsultasFrm.btnLimpiarClick(Sender: TObject);
begin
  edtCodigo.Text:= '';
  edtCodigoDesde.Text:= '';
  edtCodigoHasta.Text:= '';
  edtNroRev.Text:= '';
  edtNroRevDesde.Text:= '';
  edtNroRevHasta.Text:= '';
  edtDescripcion.Text:= '';
  edtAlta.Text:= '';
  edtAprobacion.Text:= '';
  edtRecepcion.Text:= '';

  rbUltRev.Checked:= True;
  ListView.Clear;
  ListView.Enabled:= False;
  btnAbrir.Enabled:= False;
  btnBuscar.Enabled:= True;
  btnTodos.Enabled:= True;

end;

procedure TConsultasFrm.btnLimpiarlmClick(Sender: TObject);
begin
  edtCodigolm.Text:= '';
  edtCodigoDesdelm.Text:= '';
  edtCodigoHastalm.Text:= '';
  edtNroRevlm.Text:= '';
  edtNroRevDesdelm.Text:= '';
  edtNroRevHastalm.Text:= '';
  edtDescripcionlm.Text:= '';

  rbUltRevlm.Checked:= True;
  ListViewlm.Clear;
  ListViewlm.Enabled:= False;
  btnAbrirlm.Enabled:= False;
  btnBuscarlm.Enabled:= True;
  btnTodoslm.Enabled:= True;
end;

procedure TConsultasFrm.btnLimpiarmpClick(Sender: TObject);
begin
   self.edtCodigomp.Text:= '';
   self.edtCodigoDesdemp.Text:= '';
   self.edtCodigoHastamp.Text:= '';
   self.edtNroRevmp.Text:= '';
   self.edtNroRevDesdemp.Text:= '';
   self.edtNroRevHastamp.Text:= '';
   self.edtDescripcionmp.Text:= '';
   self.edtAltamp.Text:= '';
   self.edtAprobacionmp.Text:= '';
   self.edtRecepcionmp.Text:= '';

   self.btnAbrirmp.Enabled:= False;
   self.btnBuscarmp.Enabled:= True;
   self.btnTodosmp.Enabled:= True;
   ListViewmp.Clear;
   ListViewmp.Enabled:= False;

end;

procedure TConsultasFrm.Consultarip;
begin
  stbPlano.SimpleText:= 'Se está realizando la consulta solicitada, por favor aguarde unos segundos...';

  self.ListViewip.Clear;
  TSistema.GetInstance.InstructivoDB.Consulta(ListViewip, FSQL);

  if self.ListViewip.Items.Count > 0 then
  begin
    stbPlano.SimpleText:= 'Se encontraron ' + IntToStr(ListViewip.Items.Count) + ' Instructivos de Producción que coinciden con el criterio de búsqueda ingresado';
    ListViewip.Enabled:= True;
    ListViewip.ItemIndex:= 0;
    self.btnAbririp.Enabled:= true;
    ListViewip.SetFocus;
  end
  else
  begin
    stbPlano.SimpleText:= 'No se encontraron Instructivos de Producción que coincidan con el criterio de búsqueda ingresado';
  end;
end;

procedure TConsultasFrm.Consultarsp;
begin
  stbPlano.SimpleText:= 'Se está realizando la consulta solicitada, por favor aguarde unos segundos...';

  ListViewsp.Clear;

  TSistema.GetInstance.SubinstructivoDB.Consulta(ListViewsp, FSQL);

  if ListViewsp.Items.Count > 0 then
  begin
    stbPlano.SimpleText:= 'Se encontraron ' + IntToStr(ListViewsp.Items.Count) + ' Subinstructivos de Producción que coinciden con el criterio de búsqueda ingresado';
    ListViewsp.Enabled:= True;
    ListViewsp.ItemIndex:= 0;
    self.btnAbrirsp.Enabled:= true;
    ListViewsp.SetFocus;

  end
  else
  begin
    stbPlano.SimpleText:= 'No se encontraron Subinstructivos de Producción que coincidan con el criterio de búsqueda ingresado';
  end;

end;

procedure TConsultasFrm.Consultarlm;
begin
  stbPlano.SimpleText:= 'Se está realizando la consulta solicitada, por favor aguarde unos segundos...';

  ListViewlm.Clear;

  TSistema.GetInstance.ListaDB.Consulta(ListViewlm, FSQL);

  if ListViewlm.Items.Count > 0 then
  begin
    stbPlano.SimpleText:= 'Se encontraron ' + IntToStr(ListViewlm.Items.Count) + ' Listas de Materiales que coinciden con el criterio de búsqueda ingresado';
    ListViewlm.Enabled:= True;
    self.btnAbrirlm.Enabled:= true;
    ListViewlm.ItemIndex:= 0;
    ListViewlm.SetFocus;

  end
  else
  begin
    stbPlano.SimpleText:= 'No se encontraron planos que coincidan con el criterio de búsqueda ingresado';
  end;

end;

procedure TConsultasFrm.Consultarmp;
begin
  stbPlano.SimpleText:= 'Se está realizando la consulta solicitada, por favor aguarde unos segundos...';

  ListViewmp.Clear;

  TSistema.GetInstance.ManualDB.Consulta(ListViewmp, FSQL);
  if ListViewmp.Items.Count >0 then
  begin
    stbPlano.SimpleText:= 'Se encontraron ' + IntToStr(ListViewmp.Items.Count) + ' Manuales que coinciden con el criterio de búsqueda ingresado';
    ListViewmp.Enabled:= True;
    ListViewmp.ItemIndex:= 0;
    ListViewmp.SetFocus;
    self.btnAbrirmp.Enabled:= true;
  end
  else
  begin
    stbPlano.SimpleText:= 'No se encontraron planos que coincidan con el criterio de búsqueda ingresado';
  end;

end;

procedure TConsultasFrm.Consultar;
begin
  stbPlano.SimpleText:= 'Se está realizando la consulta solicitada, por favor aguarde unos segundos...';

  ListView.Clear;

  TSistema.GetInstance.PlanoDB.Consulta(ListView, FSQL);
  if ListView.Items.Count >0 then
  begin
    stbPlano.SimpleText:= 'Se encontraron ' + IntToStr(ListView.Items.Count) + ' planos que coinciden con el criterio de búsqueda ingresado';
    ListView.Enabled:= True;
    ListView.ItemIndex:= 0;
    ListView.SetFocus;

  end
  else
  begin
    stbPlano.SimpleText:= 'No se encontraron planos que coincidan con el criterio de búsqueda ingresado';
  end;

end;

function TConsultasFrm.SonDatosValidosip(): Boolean;
var
  CodRet: Boolean;

begin
  CodRet:= True;
  if (edtNroRevip.Text <> '') and (not EsNumero(edtNroRevip.Text)) then
  begin
    edtNroRevip.Color:= clYellow;
    ShowMessage('El número de revisión no es válido');
    edtNroRevip.Color:= clWindow;
    edtNroRevip.SetFocus;
    CodRet:= False;
  end;

  if CodRet then
  begin
    if (edtNroRevDesdeip.Text <> '') and (not EsNumero(edtNroRevDesdeip.Text)) then
    begin
      edtNroRevDesdeip.Color:= clYellow;
      ShowMessage('El número de revisión desde no es válido');
      edtNroRevDesdeip.Color:= clWindow;
      edtNroRevDesdeip.SetFocus;
      CodRet:= False;
    end;
  end;

  if CodRet then
  begin
    if (edtNroRevHastaip.Text <> '') and (not EsNumero(edtNroRevHastaip.Text)) then
    begin
      edtNroRevHastaip.Color:= clYellow;
      ShowMessage('El número de revisión hasta no es válido');
      edtNroRevHastaip.Color:= clWindow;
      edtNroRevHastaip.SetFocus;
      CodRet:= False;
    end;
  end;

  Result:= CodRet;
end;

function TConsultasFrm.SonDatosValidossp(): Boolean;
var
  CodRet: Boolean;

begin
  CodRet:= True;
  if (edtNroRevsp.Text <> '') and (not EsNumero(edtNroRevsp.Text)) then
  begin
    edtNroRevsp.Color:= clYellow;
    ShowMessage('El número de revisión no es válido');
    edtNroRevsp.Color:= clWindow;
    edtNroRevsp.SetFocus;
    CodRet:= False;
  end;

  if CodRet then
  begin
    if (edtNroRevDesdesp.Text <> '') and (not EsNumero(edtNroRevDesdesp.Text)) then
    begin
      edtNroRevDesdesp.Color:= clYellow;
      ShowMessage('El número de revisión desde no es válido');
      edtNroRevDesdesp.Color:= clWindow;
      edtNroRevDesdesp.SetFocus;
      CodRet:= False;
    end;
  end;

  if CodRet then
  begin
    if (edtNroRevHastasp.Text <> '') and (not EsNumero(edtNroRevHastasp.Text)) then
    begin
      edtNroRevHastasp.Color:= clYellow;
      ShowMessage('El número de revisión hasta no es válido');
      edtNroRevHastasp.Color:= clWindow;
      edtNroRevHastasp.SetFocus;
      CodRet:= False;
    end;
  end;

  Result:= CodRet;
end;


function TConsultasFrm.SonDatosValidos(): Boolean;
var
  CodRet: Boolean;

begin
  CodRet:= True;
  if (edtNroRev.Text <> '') and (not EsNumero(edtNroRev.Text)) then
  begin
    edtNroRev.Color:= clYellow;
    ShowMessage('El número de revisión no es válido');
    edtNroRev.Color:= clWindow;
    edtNroRev.SetFocus;
    CodRet:= False;
  end;

  if CodRet then
  begin
    if (edtNroRevDesde.Text <> '') and (not EsNumero(edtNroRevDesde.Text)) then
    begin
      edtNroRevDesde.Color:= clYellow;
      ShowMessage('El número de revisión desde no es válido');
      edtNroRevDesde.Color:= clWindow;
      edtNroRevDesde.SetFocus;
      CodRet:= False;
    end;
  end;

  if CodRet then
  begin
    if (edtNroRevHasta.Text <> '') and (not EsNumero(edtNroRevHasta.Text)) then
    begin
      edtNroRevHasta.Color:= clYellow;
      ShowMessage('El número de revisión hasta no es válido');
      edtNroRevHasta.Color:= clWindow;
      edtNroRevHasta.SetFocus;
      CodRet:= False;
    end;
  end;

  Result:= CodRet;
end;

function TConsultasFrm.SonDatosValidoslm (): Boolean;
var
 CodRet: Boolean;

begin
 CodRet:=True;
   if (edtNroRevlm.Text <> '') and (not EsNumero(edtNroRevlm.Text)) then
  begin
    edtNroRevlm.Color:= clYellow;
    ShowMessage('El número de revisión no es válido');
    edtNroRevlm.Color:= clWindow;
    edtNroRevlm.SetFocus;
    CodRet:= False;
  end;
    if CodRet then
  begin
    if (edtNroRevDesdelm.Text <> '') and (not EsNumero(edtNroRevDesdelm.Text)) then
    begin
      edtNroRevDesdelm.Color:= clYellow;
      ShowMessage('El número de revisión desde no es válido');
      edtNroRevDesdelm.Color:= clWindow;
      edtNroRevDesdelm.SetFocus;
      CodRet:= False;
    end;
  end;

  if CodRet then
  begin
    if (edtNroRevHastalm.Text <> '') and (not EsNumero(edtNroRevHastalm.Text)) then
    begin
      edtNroRevHastalm.Color:= clYellow;
      ShowMessage('El número de revisión hasta no es válido');
      edtNroRevHastalm.Color:= clWindow;
      edtNroRevHastalm.SetFocus;
      CodRet:= False;
    end;
  end;


  Result:= CodRet;
end;
function TConsultasFrm.SonDatosValidosmp(): Boolean;
var
 CodRet: Boolean;
begin
 CodRet:=True;
   if (self.edtNroRevmp.Text <> '') and (not EsNumero(self.edtNroRevmp.Text)) then
  begin
    self.edtNroRevmp.Color:= clYellow;
    ShowMessage('El número de revisión no es válido');
    self.edtNroRevmp.Color:= clWindow;
    self.edtNroRevmp.SetFocus;
    CodRet:= False;
  end;
    if CodRet then
  begin
    if (self.edtNroRevDesdemp.Text <> '') and (not EsNumero(self.edtNroRevDesdemp.Text)) then
    begin
      self.edtNroRevDesdemp.Color:= clYellow;
      ShowMessage('El número de revisión desde no es válido');
      self.edtNroRevDesdemp.Color:= clWindow;
      self.edtNroRevDesdemp.SetFocus;
      CodRet:= False;
    end;
  end;

  if CodRet then
  begin
    if (self.edtNroRevHastamp.Text <> '') and (not EsNumero(self.edtNroRevHastamp.Text)) then
    begin
      self.edtNroRevHastamp.Color:= clYellow;
      ShowMessage('El número de revisión hasta no es válido');
      self.edtNroRevHastamp.Color:= clWindow;
      self.edtNroRevHastamp.SetFocus;
      CodRet:= False;
    end;
  end;

  Result:= CodRet;
end;
function TConsultasFrm.Where(var W: Boolean): string;
begin
  Result:= ' where ';
  if W then
    Result:= ' and ';
  W:= True;
end;

procedure TConsultasFrm.btnBuscarClick(Sender: TObject);
var
  W: Boolean;
  SQLWhere: string;

begin
  SQLWhere:= ' ';
  W:= False;

  if SonDatosValidos then
  begin
    if edtCodigo.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO like ''%' + edtCodigo.Text + '%''';

    if edtCodigoDesde.Text <> '' then
       SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''' + edtCodigoDesde.Text + ''' and ''DB99-999''';


    if edtCodigoHasta.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''DB4-0000'' and ''' + edtCodigoHasta.Text + '''';

    if edtNroRev.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV =' + edtNroRev.Text;

    if edtNroRevDesde.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between ' + edtNroRevDesde.Text + ' and 9999';

    if edtNroRevHasta.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between 0 and ' + edtNroRevHasta.Text;

    if edtDescripcion.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_DESCRIPCION like ''%' + edtDescripcion.Text + '%''';

    if edtAlta.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_ALTA like ''%' + edtAlta.Text + '%''';

    if edtAprobacion.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_APR like ''%' + edtAprobacion.Text + '%''';

    if edtRecepcion.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_REC like ''%' + edtRecepcion.Text + '%''';


    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ';

    if rbUltRev.Checked then
      FSQL:= FSQL + ' from PLANO ' + SQLWhere + ' order by 2,1'
    else if rbHist.Checked then
      FSQL:= FSQL + ' from HISTORICO ' + SQLWhere + ' order by 2,3,1'
    else if rbTodos.Checked then
      FSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ' +
             ' from PLANO ' + SQLWhere +
             ' union ' +
             'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ' +
             ' from HISTORICO ' + SQLWhere;

    Consultar;
  end;
end;

procedure TConsultasFrm.btnBuscarlmClick(Sender: TObject);
var
  W: Boolean;
  SQLWhere: string;

begin
  SQLWhere:= ' ';
  W:= False;

  if SonDatosValidos then
  begin
    if edtCodigolm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO like ''%' + edtCodigolm.Text + '%''';

    if edtCodigoDesdelm.Text <> '' then
       SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''' + edtCodigoDesdelm.Text + ''' and ''DB99-999''';


    if edtCodigoHastalm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''DB9-0000'' and ''' + edtCodigoHastalm.Text + '''';

    if edtNroRevlm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV =' + edtNroRevlm.Text;

    if edtNroRevDesdelm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between ' + edtNroRevDesdelm.Text + ' and 9999';

    if edtNroRevHastalm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between 0 and ' + edtNroRevHastalm.Text;

    if edtDescripcionlm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_DESCRIPCION like ''%' + edtDescripcionlm.Text + '%''';

    {if edtAltalm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_ALTA like ''%' + edtAltalm.Text + '%''';

    if edtAprobacionlm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_APR like ''%' + edtAprobacionlm.Text + '%''';

    if edtRecepcionlm.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_REC like ''%' + edtRecepcionlm.Text + '%''';
     }

    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ';

    if rbUltRevlm.Checked then
      FSQL:= FSQL + ' from MATERIALES ' + SQLWhere + ' order by 2,1'
    else if rbHistlm.Checked then
      FSQL:= FSQL + ' from HISTORICOMATERIALES ' + SQLWhere + ' order by 2,3,1'
    else if rbTodoslm.Checked then
      FSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ' +
             ' from MATERIALES ' + SQLWhere +
             ' union ' +
             'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ' +
             ' from HISTORICOMATERIALES ' + SQLWhere;

    Consultarlm;
  end;
end;

procedure TConsultasFrm.btnBuscarmpClick(Sender: TObject);
var
  W: Boolean;
  SQLWhere: string;

begin
  SQLWhere:= ' ';
  W:= False;

  if SonDatosValidosmp then
  begin
    if edtCodigomp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO like ''%' + edtCodigomp.Text + '%''';

    if edtCodigoDesdemp.Text <> '' then
       SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''' + edtCodigoDesdemp.Text + ''' and ''DB99-999''';


    if edtCodigoHastamp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''DB4-0000'' and ''' + edtCodigoHastamp.Text + '''';

    if edtNroRevmp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV =' + edtNroRevmp.Text;

    if edtNroRevDesdemp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between ' + edtNroRevDesdemp.Text + ' and 9999';

    if edtNroRevHastamp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between 0 and ' + edtNroRevHastamp.Text;

    if edtDescripcionmp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_DESCRIPCION like ''%' + edtDescripcionmp.Text + '%''';

    if edtAltamp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_ALTA like ''%' + edtAltamp.Text + '%''';

    if edtAprobacionmp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_APR like ''%' + edtAprobacionmp.Text + '%''';

    if edtRecepcionmp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_REC like ''%' + edtRecepcionmp.Text + '%''';


    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ';

    if rbUltRevmp.Checked then
      FSQL:= FSQL + ' from MANUALESPRODUCTO ' + SQLWhere + ' order by 2,1'
    else if rbHismp.Checked then
      FSQL:= FSQL + ' from HISTORICOMANUALES ' + SQLWhere + ' order by 2,3,1'
    else if rbTodosmp.Checked then
      FSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ' +
             ' from MANUALESPRODUCTO ' + SQLWhere +
             ' union ' +
             'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO ' +
             ' from HISTORICOMANUALES ' + SQLWhere;

    self.Consultarmp;
  end;
end;

procedure TConsultasFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolver.Click;
end;

procedure TConsultasFrm.ListViewDblClick(Sender: TObject);
begin
  btnAbrir.Click
end;

procedure TConsultasFrm.ListViewKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    btnAbrir.Click
end;

procedure TConsultasFrm.FormShow(Sender: TObject);
begin
  btnLimpiar.Click;
  self.btnLimpiarmp.Click;
  self.btnLimpiarsp.Click;
  self.btnLimpiarip.Click;
  self.btnLimpiarlm.Click;
end;

procedure TConsultasFrm.btnAbrirClick(Sender: TObject);
begin
  if ListView.Selected.SubItems[8] <> '' then
  begin
    if ShellExecute( Self.Handle, 'explore'
                   , PChar(ListView.Selected.SubItems[8])
                   , nil, nil, SW_SHOWMAXIMIZED) <= 32 then
      Application.MessageBox('La ubicación del plano no existe', 'SGPB', MB_ICONEXCLAMATION);
  end
  else
    Application.MessageBox('El registro del plano seleccionado no tiene ingresada la ubicación del mismo', 'SGPB', MB_ICONINFORMATION,);

end;

procedure TConsultasFrm.btnAbrirEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Abra la carpeta que contiene el archivo del plano seleccionado';
end;
procedure TConsultasFrm.btnAbrirlmEnter(Sender: TObject);
begin
   stbPlano.SimpleText:= 'Abra la carpeta que contiene el archivo de la Lista de Materiales seleccionado';
end;

procedure TConsultasFrm.edtCodigoEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del plano que desea consultar';

end;

procedure TConsultasFrm.edtCodigolmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código de la Lista de Material que desea consultar';
end;

procedure TConsultasFrm.edtCodigompEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del Manual que desea consultar';
end;

procedure TConsultasFrm.edtCodigoDesdeEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.edtCodigoDesdempEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del Manual desde el cual desea consultar';
end;

procedure TConsultasFrm.edtCodigoDesdelmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código de la Lista de Material desde el cual desea consultar';
end;
procedure TConsultasFrm.edtCodigoHastaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del plano hasta el cual desea consultar';
end;
procedure TConsultasFrm.edtCodigoHastalmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código de la Lista de Material hasta el cual desea consultar';
end;
procedure TConsultasFrm.edtCodigoHastampEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del Manual hasta el cual desea consultar';
end;
procedure TConsultasFrm.edtNroRevEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión del plano que desea consultar';
end;
procedure TConsultasFrm.edtNroRevlmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión de la Lista de Material que desea consultar';
end;
procedure TConsultasFrm.edtNroRevmpEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión del Manual que desea consultar';
end;
procedure TConsultasFrm.edtNroRevDesdeEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión del plano desde el cual desea consultar';
end;
procedure TConsultasFrm.edtNroRevDesdelmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión de la Lista de Material desde el cual desea consultar';
end;
procedure TConsultasFrm.edtNroRevDesdempEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión del Manual desde que desea consultar';
end;
procedure TConsultasFrm.edtNroRevHastaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión del plano hasta el cual desea consultar';
end;
procedure TConsultasFrm.edtNroRevHastalmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión de la Lista de Material hasta el cual desea consultar';
end;
procedure TConsultasFrm.edtNroRevHastampEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión del Manual hasta el cual desea consultar';
end;
procedure TConsultasFrm.edtDescripcionEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese la descripción de los planos que desea consultar';
end;
procedure TConsultasFrm.edtDescripcionlmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese la descripción de las Listas de Materiales que desea consultar';
end;
procedure TConsultasFrm.edtDescripcionmpEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese la descripción del Manual que desea consultar';
end;
procedure TConsultasFrm.edtAltaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de alta de los planos que desea consultar';
end;
procedure TConsultasFrm.edtAltalmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de alta de las Listas de Materiales que desea consultar';
end;
procedure TConsultasFrm.edtAltampEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de alta de los Manuales que desea consultar';
end;
procedure TConsultasFrm.edtRecepcionEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de recepción de los planos que desea consultar';
end;
procedure TConsultasFrm.edtRecepcionlmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de recepción de las Listas de Materiales que desea consultar';
end;
procedure TConsultasFrm.edtRecepcionmpEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de recepción de los Manuales que desea consultar';
end;  
procedure TConsultasFrm.rbUltRevEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Consultar sobre los planos cuya revisión es la última';
end;

procedure TConsultasFrm.rbHistEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Consultar sobre los planos cuya revisón no es la última (históricos)';
end;

procedure TConsultasFrm.rbTodosEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Consultar sobre todos los planos';
end;

procedure TConsultasFrm.cbDiaDAltaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el día de alta del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.cbMesDAltaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el mes de alta del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.cbDiaHAltaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el día de alta del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbMesHAltaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el mes de alta del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbAnioHAltaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el año de alta del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbDiaDAprEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el día de aprobación del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.cbMesDAprEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el mes de aprobación del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.cbAnioDAprEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el año de aprobación del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.cbDiaHAprEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el día de aprobación del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbMesHAprEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el mes de aprobación del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbAnioHAprEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el año de aprobación del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbDiaDRecEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el día de recepción del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.cbMesDRecEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el mes de recepción del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.cbAnioDRecEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el año de recepción del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.cbDiaHRecEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el día de recepción del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbMesHRecEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el mes de recepción del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbAnioHRecEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el año de recepción del plano hasta el cual desea consultar';
end;

procedure TConsultasFrm.cbAnioDAltaEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione el año de alta del plano desde el cual desea consultar';
end;

procedure TConsultasFrm.edtAprobacionEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de aprobación de los planos que desea consultar';
end;

procedure TConsultasFrm.edtAprobacionlmEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de aprobación de las Listas de Materiales que desea consultar';
end;
procedure TConsultasFrm.edtAprobacionmpEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de aprobación de los Manuales que desea consultar';
end;
procedure TConsultasFrm.ListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  btnAbrir.Enabled:= False;
  if Selected then
    btnAbrir.Enabled:= ListView.Selected.SubItems[8] <> '';
end;

procedure TConsultasFrm.DBGrid1DblClick(Sender: TObject);
begin
  self.btnAbrirlm.Click
end;

procedure TConsultasFrm.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(key) = 13 then
    self.btnAbrirlm.Click
end;

procedure TConsultasFrm.btnAbrirmpClick(Sender: TObject);
begin
  if ListViewmp.Selected.SubItems[8] <> '' then
  begin
    if ShellExecute( Self.Handle, 'explore'
                   , PChar(ListViewmp.Selected.SubItems[8])
                   , nil, nil, SW_SHOWMAXIMIZED) <= 32 then
      Application.MessageBox('La ubicación del manual no existe', 'SGPB', MB_ICONEXCLAMATION);
  end
  else
    Application.MessageBox('El registro del manual seleccionado no tiene ingresada la ubicación del mismo', 'SGPB', MB_ICONINFORMATION,);

end;

procedure TConsultasFrm.DBGrid2KeyPress(Sender: TObject; var Key: Char);
begin
 if Ord(key) = 13 then
    self.btnAbrirmp.Click;
end;

procedure TConsultasFrm.btnAbrirmpEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Abra la carpeta que contiene el archivo del Manual seleccionado';

 end;

procedure TConsultasFrm.edtCodigodvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese el código del Documento que desea consultar';
end;

procedure TConsultasFrm.edtNroRevdvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese el número de revisión del Documento que desea consultar';
end;

procedure TConsultasFrm.edtNroRevDesdedvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese el número de revisión del Documento desde el cual desea consultar';
end;

procedure TConsultasFrm.edtNroRevHastadvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese el número de revisión del Documento hasta el cual desea consultar';
end;

procedure TConsultasFrm.edtDescrpciondvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese la descripción de los Documentos que desea consultar';
end;

procedure TConsultasFrm.edtAltadvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese el usuario de alta de los Documentos que desea consultar';
end;

procedure TConsultasFrm.edtAprobaciondvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese el usuario de aprobación de los Documentos que desea consultar';
end;

procedure TConsultasFrm.edtRecepciondvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese el usuario de recepción de los Documentos que desea consultar';
end;


procedure TConsultasFrm.btnAbrirdvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Abra la carpeta que contiene el archivo del Documento seleccionado';
end;

procedure TConsultasFrm.btnBuscardvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Busca todos los Documentos que cumplan '
                      + 'con el criterio de búsqueda ingresado';
end;

procedure TConsultasFrm.btnTodosdvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Devuelve el listado de todos los Documentos que '
                      + 'existen en la base de datos';
end;

procedure TConsultasFrm.btnLimpiardvEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla para '
                        + 'poder realizar una nueva consulta';
end;

procedure TConsultasFrm.btnVolverdvEnter(Sender: TObject);
begin
{  self.stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;
function TConsultasFrm.SonDatosValidosdc(): Boolean;
var
 CodRet: Boolean;
begin
 CodRet:=True;
    if (self.edtNroRevdv.Text <> '') and (not EsNumero(self.edtNroRevdv.Text)) then
  begin
    self.edtNroRevdv.Color:= clYellow;
    ShowMessage('El número de revisión no es válido');
    self.edtNroRevdv.Color:= clWindow;
    self.edtNroRevdv.SetFocus;
    CodRet:= False;
  end;
  Result:= CodRet;
  }
end;

procedure TConsultasFrm.FormCreate(Sender: TObject);
  function  MySort(Node1, Node2: TTreeNode; lParam: Integer): Integer; stdcall
  begin
    Result := AnsiStrIComp(PChar(Node1.Text), PChar(Node2.Text));
  end;
const
  linea: array [1..3] of string = ('PL-1001','RPO/RNO/RCA','DMC');
var
 i: integer;
 j,w,Z:integer;
 nodoPadre,nodo,nodoDMC,nodoRPO: TTreenode;
 nodoBo,nodoDCF,nodoDPT,nodoMAI,nodoPl: TTreenode;
 nodoMB04,nodoMO2,nodoMOD,nodoPLSC,nodoPll1: TTreenode;
 nodoRec,nodoRsc,nodoSA,nodoSi,nodoSA4: TTreenode;
begin
SortedColumn := 0;
    Descending := True;
 for i:=low(TvectorCliente) to high(TvectorCliente) do
 Begin
   TvectorCliente[i] := TProducto.Create;
 end;

  nodoPadre:= self.TreeView1.Items.AddChild(nil,'Productos');
// for i:= Low(linea) to High(linea) do
 for i:= low(TvectorCliente) to high(TvectorCliente) do
 begin
   TvectorCliente[1].Nombre:= 'CV2000';
   TvectorCliente[2].Nombre:= 'RPO/RNO/RCA';
   TvectorCliente[3].Nombre:= 'DMC';
   TvectorCliente[4].Nombre:= 'Bocina2002';
   TvectorCliente[5].Nombre:= 'DCF';
   TvectorCliente[6].Nombre:= 'DPT';
   TvectorCliente[7].Nombre:= 'MAI-2';
   TvectorCliente[8].Nombre:= 'MB04';
   TvectorCliente[9].Nombre:= 'MO2';
   TvectorCliente[10].Nombre:= 'MOD';
   TvectorCliente[11].Nombre:= 'PL/SC2';
   TvectorCliente[12].Nombre:= 'PL-1001 Señalizacion Optica';
   TvectorCliente[13].Nombre:= 'PL-L1';
   TvectorCliente[14].Nombre:= 'Rectificador';
   TvectorCliente[15].Nombre:= 'RSCBDS';
   TvectorCliente[16].Nombre:= 'SA3002N';
   TvectorCliente[17].Nombre:= 'SI-96';
   TvectorCliente[18].Nombre:= 'Sistema de Alarma SA4003';

 end;
    nodo:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[1].Nombre);
    nodoRPO:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[2].Nombre);
    nodoDMC:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[3].Nombre);
    nodoBo:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[4].Nombre);
    nodoDCF:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[5].Nombre);
    nodoDPT:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[6].Nombre);
    nodoMAI:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[7].Nombre);
    nodoMB04:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[8].Nombre);
    nodoMO2:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[9].Nombre);
    nodoMOD:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[10].Nombre);
    nodoPLSC:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[11].Nombre);
    nodoPll1:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[12].Nombre);
    nodoPl:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[13].Nombre);
    nodoRec:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[14].Nombre);
    nodoRsc:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[15].Nombre);
    nodoSA:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[16].Nombre);
    nodoSi:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[17].Nombre);
    nodoSA4:= self.TreeView1.Items.AddChild(nodoPadre,TvectorCliente[18].Nombre);
    self.Lista;

//    if linea[i] = 'PL-1001' then
 //   Begin
      for j:=0 to  TvectorCliente[1].ListaMateriales.Count-1 do
      Begin
        self.TreeView1.Items.AddChildObject(nodo,
                                            (TvectorCliente[1].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[1].ListaMateriales[j] as TMateriales).Estado,
                                            TvectorCliente[1].ListaMateriales[j] as TMateriales);
      end;
      for j:=0 to  TvectorCliente[2].ListaMateriales.Count-1 do
      begin
        self.TreeView1.Items.AddChildObject(nodoRPO,
                                            (TvectorCliente[2].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[2].ListaMateriales[w] as TMateriales).Estado,
                                            TvectorCliente[2].ListaMateriales[j] as TMateriales);
      end;
      for z:=0 to  TvectorCliente[3].ListaMateriales.Count-1 do
      begin
        self.TreeView1.Items.AddChildObject(nodoDMC,
                                            (TvectorCliente[3].ListaMateriales[z] as TMateriales).Codigol + '  ' + (TvectorCliente[3].ListaMateriales[z] as TMateriales).Estado,
                                            TvectorCliente[3].ListaMateriales[z] as TMateriales);
      end;
      for j:=0 to TvectorCliente[4].ListaMateriales.Count-1 do
      begin
       self.TreeView1.Items.AddChildObject(nodoBo,
                                          (TvectorCliente[4].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[4].ListaMateriales[j] as TMateriales).Estado,
                                           TvectorCliente[4].ListaMateriales[j] as TMateriales);
      end;
      for j:= 0 to TvectorCliente[5].ListaMateriales.Count-1 do
      begin
       self.TreeView1.Items.AddChildObject(nodoDCF,
                                          (TvectorCliente[5].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[5].ListaMateriales[j] as TMateriales).Estado,
                                          TvectorCliente[5].ListaMateriales[j] as TMateriales);
      end;
      for j:= 0 to TvectorCliente[6].ListaMateriales.Count-1 do
      begin
        self.TreeView1.Items.AddChildObject(nodoDPT,
                                           (TvectorCliente[6].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[6].ListaMateriales[j] as TMateriales).Estado,
                                            TvectorCliente[6].ListaMateriales[j] as TMateriales);
      end;
      for j:= 0 to TvectorCliente[7].ListaMateriales.Count-1 do
      begin
        self.TreeView1.Items.AddChildObject(nodoMAI,
                                           (TvectorCliente[7].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[7].ListaMateriales[j] as TMateriales).Estado,
                                            TvectorCliente[7].ListaMateriales[j] as TMateriales);
      end;
      for j:= 0 to TvectorCliente[8].ListaMateriales.Count-1 do
      begin
        self.TreeView1.Items.AddChildObject(nodoMB04,
                                            (TvectorCliente[8].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[8].ListaMateriales[j] as TMateriales).Estado,
                                            TvectorCliente[8].ListaMateriales[j] as TMateriales);
      end;
     for j:= 0 to TvectorCliente[9].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoMO2,
                                         (TvectorCliente[9].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[9].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[9].ListaMateriales[j] as TMateriales);
     end;
     for j:= 0 to TvectorCliente[10].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoMOD,
                                         (TvectorCliente[10].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[10].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[10].ListaMateriales[j] as TMateriales);
     end;
      for j:= 0 to TvectorCliente[11].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoPLSC,
                                         (TvectorCliente[11].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[11].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[11].ListaMateriales[j] as TMateriales);
     end;
      for j:= 0 to TvectorCliente[12].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoPll1,
                                         (TvectorCliente[12].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[12].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[12].ListaMateriales[j] as TMateriales);
     end;
       for j:= 0 to TvectorCliente[13].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoPl,
                                         (TvectorCliente[13].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[13].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[13].ListaMateriales[j] as TMateriales);
     end;
      for j:= 0 to TvectorCliente[14].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoRec,
                                         (TvectorCliente[14].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[14].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[14].ListaMateriales[j] as TMateriales);
     end;
      for j:= 0 to TvectorCliente[15].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoRsc,
                                         (TvectorCliente[15].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[15].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[15].ListaMateriales[j] as TMateriales);
     end;
     for j:= 0 to TvectorCliente[16].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoSA,
                                         (TvectorCliente[16].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[16].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[16].ListaMateriales[j] as TMateriales);
     end;
      for j:= 0 to TvectorCliente[17].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoSi,
                                         (TvectorCliente[17].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[17].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[17].ListaMateriales[j] as TMateriales);
     end;
      for j:= 0 to TvectorCliente[18].ListaMateriales.Count-1 do
     begin
      self.TreeView1.Items.AddChildObject(nodoSA4,
                                         (TvectorCliente[18].ListaMateriales[j] as TMateriales).Codigol + '  ' + (TvectorCliente[18].ListaMateriales[j] as TMateriales).Estado,
                                         TvectorCliente[18].ListaMateriales[j] as TMateriales);
     end;
     self.TreeView1.CustomSort(@mySort,0);
  end;
  
procedure TConsultasFrm.TreeView1CustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Material:TMateriales;
begin
 if (Node.Data<>nil) then
 Begin
  Material := TMateriales(Node.Data);
  If Material.Estado='AC' then
  Begin
    self.TreeView1.Canvas.Font.Color := clLime;
  end
    else
  Begin
    self.TreeView1.Canvas.Font.Color := clYellow;
  end;
 end;

end;
{ TProductro }

constructor TProducto.Create;
begin
  Self.FListaMateriales := TObjectList.Create(True);
end;

destructor TProducto.Destroy;

begin
  Self.FListaMateriales.Free;
end;
procedure TConsultasFrm.ConsultarCodigo(Codigo: string);
 var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;
  Materiales: TMateriales;
  codigoAux: string;
begin
  Materiales:= TMateriales.Create;
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;
try
  CodigoAux:= copy(Codigo,1,11);
  if MSQL.GetStatus = 0 then
  begin
    Dst:= TADODataset.Create(nil);
    Dst.Connection:= MSQL.GetConn;
    sSQL:= 'Select PLN_CODIGO,PLN_NRO_REV,PLN_DESCRIPCION from MATERIALES where PLN_CODIGO = ' + QuotedStr(CodigoAux);

    Dst.CommandText:= sSQL;
    Dst.Open;

    self.edtNroRevlm.Text:= IntToStr(dst.fieldByName('PLN_NRO_REV').AsInteger);
    self.edtDescripcionlm.Text:= dst.fieldByName('PLN_DESCRIPCION').AsString;
    self.edtNroRevlm.Enabled:= false;
    self.edtDescripcionlm.Enabled:= false;
    self.edtCodigolm.Enabled:= false;
 end;
   MSQL.CloseConn;
finally
  Dst.Free;
 end;
end;

procedure TConsultasFrm.TreeView1Click(Sender: TObject);
var
 node,node2: TTreeNode;
 i,w: integer;

 begin
   for i:= 0 to self.TreeView1.Items.Count-1 do
   begin
    if  self.TreeView1.Items.Item[i].Selected then
    begin
     node:= self.TreeView1.Items.Item[i];
     case node.Level of
     0:
     begin
      self.edtCodigolm.Text:= '';
      self.edtNroRevlm.Text:= '';
      self.edtDescripcionlm.Text:= '';
     end;
     1:
     begin
      self.edtCodigolm.Text:= '';
      self.edtNroRevlm.Text:= '';
      self.edtDescripcionlm.Text:= '';
     end;
     2:
     begin
      self.edtCodigolm.Text:= node.Text;
      self.ConsultarCodigo(node.Text);
       //self.ConsultarCodigo(codigonuevo);
     end;
    end;
   end;
 end;
 end;

procedure TConsultasFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
self.btnVolverClick(Sender);
  end;
end;

procedure TConsultasFrm.Button1Click(Sender: TObject);
 var
  myFile : TextFile;
  i, k, z : integer;
  fileString: string;
  sMsj1,sMsj2,sMsj3: string;
  lineas: integer;
  cTemp: string;

begin
  i:= 10;
  z:= 0;

  cTemp:= (Copy(Tsistema.getInstance.GetDataBaseFilename,1,Pos('SGPB.mdb',Tsistema.getInstance.GetDataBaseFilename)-1));
  cTemp:= Ctemp + 'Error.txt';
  fileString:=  cTemp;
  AssignFile (myFile,fileString);
   try
    k := i div z;
    showMessage(IntToStr(K));
    except
     on E: Exception  do
   begin
     sMsj1:= 'Clase en la que ocurrió el error: ' + self.ClassName;
     sMsj2:= 'Tipo de error: ' + E.ClassName;
     sMsj3:= sMsj1 +  #13#10 + sMsj2 +  #13#10 + E.message;

     if FileExists(fileString) then
     begin
     try
      Append(myFile);
      WriteLn(myFile,sMsj3);
       finally
       CloseFile(myfile);
      end;
     end
   else
   begin
     Rewrite(myfile);
     WriteLn(myFile,sMsj3);
     CloseFile(myfile);
  end;
 end;
end;
end;
procedure TConsultasFrm.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then
    begin
        btnBuscarClick(Sender);

    end;
end;

procedure TConsultasFrm.edtCodigolmKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (key=#13) then
    begin
        btnBuscarlmClick(Sender);
    end;
end;

procedure TConsultasFrm.edtCodigompKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
    begin
        btnBuscarmpClick(Sender);
    end;
end;

procedure TConsultasFrm.edtDescripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (key=#13) then
    begin
        btnBuscarClick(Sender);
    end;
end;

procedure TConsultasFrm.edtAltaKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then
    begin
        btnBuscarClick(Sender);
   end;
end;

procedure TConsultasFrm.edtAprobacionKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
    begin
        btnBuscarClick(Sender);
   end;
end;

procedure TConsultasFrm.edtRecepcionKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
    begin
        btnBuscarClick(Sender);
   end;
end;

procedure TConsultasFrm.edtCodigoDesdeKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (key=#13) then
    begin
        btnBuscarClick(Sender);
   end;
end;

procedure TConsultasFrm.edtCodigoHastaKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (key=#13) then
    begin
        btnBuscarClick(Sender);
   end;
end;

procedure TConsultasFrm.edtDescripcionmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
    begin
        btnBuscarmpClick(Sender);
    end;
end;

procedure TConsultasFrm.edtAltampKeyPress(Sender: TObject; var Key: Char);
begin
   if (key=#13) then
    begin
        btnBuscarmpClick(Sender);
    end;
end;

procedure TConsultasFrm.edtAprobacionmpKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (key=#13) then
    begin
        btnBuscarmpClick(Sender);
    end;
end;

procedure TConsultasFrm.edtRecepcionmpKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (key=#13) then
    begin
        btnBuscarmpClick(Sender);
    end;
end;

procedure TConsultasFrm.btnVolverspClick(Sender: TObject);
begin
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TConsultasFrm.btnLimpiarspClick(Sender: TObject);
begin
  edtCodigosp.Text:= '';
  edtCodigoDesdesp.Text:= '';
  edtCodigoHastasp.Text:= '';
  edtNroRevsp.Text:= '';
  edtNroRevDesdesp.Text:= '';
  edtNroRevHastasp.Text:= '';
  edtDescripcionsp.Text:= '';
  edtAltasp.Text:= '';
  edtAprobacionsp.Text:= '';
  edtRecepcionsp.Text:= '';

  rbUltRevsp.Checked:= True;
  ListViewsp.Clear;
  ListViewsp.Enabled:= False;
  btnAbrirsp.Enabled:= False;
  btnBuscarsp.Enabled:= True;
  btnTodossp.Enabled:= True;

end;

procedure TConsultasFrm.btnBuscarspClick(Sender: TObject);
var
  W: Boolean;
  SQLWhere: string;

begin
  SQLWhere:= ' ';
  W:= False;

  if SonDatosValidossp then
  begin
   if edtCodigosp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO like ''%' + edtCodigosp.Text + '%''';

    if edtCodigoDesdesp.Text <> '' then
       SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''' + edtCodigoDesdesp.Text + ''' and ''SB99-999''';


    if edtCodigoHastasp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''SB9-0000'' and ''' + edtCodigoHastasp.Text + '''';

    if edtNroRevsp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV =' + edtNroRevsp.Text;

    if edtNroRevDesdesp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between ' + edtNroRevDesdesp.Text + ' and 9999';

    if edtNroRevHastasp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between 0 and ' + edtNroRevHastasp.Text;

    if edtDescripcionsp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_DESCRIPCION like ''%' + edtDescripcionsp.Text + '%''';

    if edtAltasp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_ALTA like ''%' + edtAltasp.Text + '%''';

    if edtAprobacionsp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_APR like ''%' + edtAprobacionsp.Text + '%''';

    if edtRecepcionsp.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_REC like ''%' + edtRecepcionsp.Text + '%''';


    FSQL:= 'select PLN_FECHA, PLN_CODIGO,PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO';

    if rbUltRevsp.Checked then
      FSQL:= FSQL + ' from SUBINSTRUCTIVOSPRODUCCION ' + SQLWhere + ' order by 2,1'
    else if rbHistsp.Checked then
      FSQL:= FSQL + ' from SUBINSTRUCTIVOSPRODUCCIONHISTORICO ' + SQLWhere + ' order by 2,3,1'
    else if rbTodossp.Checked then
      FSQL:= 'select PLN_CODIGO,PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
             ' from SUBINSTRUCTIVOSPRODUCCION ' + SQLWhere +
             ' union ' +
             'select PLN_CODIGO,PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
             ' from SUBINSTRUCTIVOSPRODUCCIONHISTORICO ' + SQLWhere;

   Consultarsp;

  end;
end;

procedure TConsultasFrm.edtCodigospEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del subinstructivo de producción que desea consultar';
end;

procedure TConsultasFrm.btnLimpiarspEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla para '
                        + 'poder realizar una nueva consulta';
end;

procedure TConsultasFrm.edtCodigoDesdespEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del subinstructivo de producción desde el cual desea consultar';
end;

procedure TConsultasFrm.edtCodigoHastaspEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el código del subinstructivo de producción hasta el cual desea consultar';
end;

procedure TConsultasFrm.edtNroRevspEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión del subinstructivo de producción que desea consultar';
end;

procedure TConsultasFrm.edtNroRevDesdespEnter(Sender: TObject);
begin
   stbPlano.SimpleText:= 'Ingrese el número de revisión del subinstructivo de producción desde el cual desea consultar';
end;

procedure TConsultasFrm.edtNroRevHastaspEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el número de revisión del subinstructivo de producción hasta el cual desea consultar';
end;

procedure TConsultasFrm.edtDescripcionspEnter(Sender: TObject);
begin
   stbPlano.SimpleText:= 'Ingrese la descripción de los subinstructivos de producción que desea consultar';
end;

procedure TConsultasFrm.edtAltaspEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Ingrese el usuario de alta de los subinstructivos de producción que desea consultar';
end;

procedure TConsultasFrm.edtAprobacionspEnter(Sender: TObject);
begin
    stbPlano.SimpleText:= 'Ingrese el usuario de aprobación de los subinstructivos de producción que desea consultar';
end;

procedure TConsultasFrm.edtRecepcionspEnter(Sender: TObject);
begin
   stbPlano.SimpleText:= 'Ingrese el usuario de recepción de los subinstructivos de producción que desea consultar';
end;

procedure TConsultasFrm.ListViewspCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);

var
 Dst: TADODataset;

begin
     if((item.SubItems[9] = 'PA') or (item.SubItems[9] = 'PR')) then
        sender.Canvas.Brush.Color:= clYellow;
        sender.Canvas.Font.Color:= clBlack;
     if((item.SubItems[10] = 'NS') and (item.SubItems[9] = 'AC')) then
        sender.Canvas.Brush.Color:= clLime;
        sender.Canvas.Font.Color:= clBlack;
     if((item.SubItems[10] = 'S')) then
       sender.Canvas.Brush.Color:= clRed;
       sender.Canvas.Font.Color:= clBlack;

end;

procedure TConsultasFrm.btnTodosspClick(Sender: TObject);
begin
  if rbUltRevsp.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from SUBINSTRUCTIVOSPRODUCCION order by 2,3,1'
  else if rbHistsp.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from SUBINSTRUCTIVOSPRODUCCIONHISTORICO order by 2,3,1'
  else if rbTodossp.Checked then
    FSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO, PLN_SUPERADO ' +
           ' from SUBINSTRUCTIVOSPRODUCCION ' +
           ' union ' +
           'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO, PLN_SUPERADO ' +
           ' from SUBINSTRUCTIVOSPRODUCCIONHISTORICO ';

  self.Consultarsp;
end;

procedure TConsultasFrm.btnAbrirspClick(Sender: TObject);
begin
  if ListViewsp.Selected.SubItems[8] <> '' then
  begin
    if ShellExecute( Self.Handle, 'explore'
                   , PChar(ListViewsp.Selected.SubItems[8])
                   , nil, nil, SW_SHOWMAXIMIZED) <= 32 then
      Application.MessageBox('La ubicación del Subinstructivo de Producción no existe', 'SGPB', MB_ICONEXCLAMATION);
  end
  else
    Application.MessageBox('El registro del Subinstructivo de Producción seleccionado no tiene ingresada la ubicación del mismo', 'SGPB', MB_ICONINFORMATION,);
end;

procedure TConsultasFrm.edtCodigospKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (key=#13) then
    begin
        btnBuscarspClick(Sender);
    end;
end;

procedure TConsultasFrm.edtDescripcionspKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
    begin
        btnBuscarspClick(Sender);
    end;
end;

procedure TConsultasFrm.edtNroRevspKeyPress(Sender: TObject;
  var Key: Char);
begin
if (key=#13) then
    begin
        btnBuscarspClick(Sender);
    end;
end;

procedure TConsultasFrm.edtNroRevKeyPress(Sender: TObject; var Key: Char);
begin
 if (key=#13) then
    begin
        btnBuscarClick(Sender);
    end;
end;

procedure TConsultasFrm.edtAltaspKeyPress(Sender: TObject; var Key: Char);
begin
 if (key=#13) then
    begin
        btnBuscarspClick(Sender);
    end;
end;

procedure TConsultasFrm.edtAprobacionspKeyPress(Sender: TObject;
  var Key: Char);
begin
 if (key=#13) then
    begin
        btnBuscarspClick(Sender);
    end;
end;

procedure TConsultasFrm.edtRecepcionspKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
    begin
        btnBuscarspClick(Sender);
    end;
end;

procedure TConsultasFrm.ListViewCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
   if((item.SubItems[9] = 'PA') or (item.SubItems[9] = 'PR')) then
        sender.Canvas.Brush.Color:= clYellow;
        sender.Canvas.Font.Color:= clBlack;
     if((item.SubItems[10] = 'NS') and (item.SubItems[9] = 'AC')) then
        sender.Canvas.Brush.Color:= clLime;
        sender.Canvas.Font.Color:= clBlack;
     if((item.SubItems[10] = 'S')) then
       sender.Canvas.Brush.Color:= clRed;
       sender.Canvas.Font.Color:= clBlack;
end;

procedure TConsultasFrm.ListViewColumnClick(Sender: TObject;
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
  ShowArrowOfListViewColumn(TListView(Sender), column.Index, Descending);
  TListView(Sender).SortType := stText;
end;

procedure TConsultasFrm.ListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
  begin
  if (Item1.SubItems.Count>0) and (Item2.SubItems.Count>0) then
  Begin
    if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)
     else
    if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
    if Descending then Compare := -Compare;
  end;
end;

procedure TConsultasFrm.ListViewspColumnClick(Sender: TObject;
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


procedure TConsultasFrm.ListViewspCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)
  else
    if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
    if Descending then Compare := -Compare;
end;

procedure TConsultasFrm.ListViewlmCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  {if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)
  else
  if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
  if Descending then Compare := -Compare;
  }
end;

procedure TConsultasFrm.ListViewlmColumnClick(Sender: TObject;
  Column: TListColumn);
begin
 {TListView(Sender).SortType := stNone;
  if Column.Index<>SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end
  else
    Descending := not Descending;
    TListView(Sender).SortType := stText;

  }
end;

procedure TConsultasFrm.ListViewlmCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
     if((item.SubItems[9] = 'PA') or (item.SubItems[9] = 'PR')) then
        sender.Canvas.Brush.Color:= clYellow;
        sender.Canvas.Font.Color:= clBlack;
     if((item.SubItems[10] = 'NS') and (item.SubItems[9] = 'AC')) then
        sender.Canvas.Brush.Color:= clLime;
        sender.Canvas.Font.Color:= clBlack;
     if((item.SubItems[10] = 'S')) then
       sender.Canvas.Brush.Color:= clRed;
       sender.Canvas.Font.Color:= clBlack;
end;

procedure TConsultasFrm.ListViewmpCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
   if((item.SubItems[9] = 'PA') or (item.SubItems[9] = 'PR')) then
        sender.Canvas.Brush.Color:= clYellow;
        sender.Canvas.Font.Color:= clBlack;
   if((item.SubItems[10] = 'NS') and (item.SubItems[9] = 'AC')) then
        sender.Canvas.Brush.Color:= clLime;
        sender.Canvas.Font.Color:= clBlack;
   if((item.SubItems[10] = 'S')) then
       sender.Canvas.Brush.Color:= clRed;
       sender.Canvas.Font.Color:= clBlack;

end;

procedure TConsultasFrm.btnBuscaripClick(Sender: TObject);
var
  W: Boolean;
  SQLWhere: string;

begin
  SQLWhere:= ' ';
  W:= False;

  if SonDatosValidosip then
  begin
   if edtCodigoip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO like ''%' + edtCodigoip.Text + '%''';

    if edtCodigoDesdeip.Text <> '' then
       SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''' + edtCodigoDesdeip.Text + ''' and ''IB9-999''';


    if edtCodigoHastaip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_CODIGO between ''IB9-0000'' and ''' + edtCodigoHastaip.Text + '''';

    if edtNroRevip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV =' + edtNroRevip.Text;

    if edtNroRevDesdeip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between ' + edtNroRevDesdeip.Text + ' and 9999';

    if edtNroRevHastaip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_NRO_REV between 0 and ' + edtNroRevHastaip.Text;

    if edtDescripcionip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_DESCRIPCION like ''%' + edtDescripcionip.Text + '%''';

    if edtAltaip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_ALTA like ''%' + edtAltaip.Text + '%''';

    if edtAprobacionip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_APR like ''%' + edtAprobacionip.Text + '%''';

    if edtRecepcionip.Text <> '' then
      SQLWhere:= SQLWhere + Where(W) + ' PLN_USUARIO_REC like ''%' + edtRecepcionip.Text + '%''';


    FSQL:= 'select PLN_FECHA, PLN_CODIGO,PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION, PLN_ESTADO, PLN_SUPERADO';

    if rbUltRevip.Checked then
      FSQL:= FSQL + ' from INSTRUCTIVOSPRODUCCION ' + SQLWhere + ' order by 2,1'
    else if rbHistip.Checked then
      FSQL:= FSQL + ' from INSTRUCTIVOSPRODUCCIONHISTORICO ' + SQLWhere + ' order by 2,3,1'
    else if rbTodosip.Checked then
      FSQL:= 'select PLN_CODIGO,PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
             ' from INSTRUCTIVOSPRODUCCION ' + SQLWhere +
             ' union ' +
             'select PLN_CODIGO,PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
             ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
             ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
             ' from INSTRUCTIVOSPRODUCCIONHISTORICO ' + SQLWhere;

   Consultarip;

  end;
end;

procedure TConsultasFrm.btnLimpiaripClick(Sender: TObject);
begin
  edtCodigoip.Text:= '';
  edtCodigoDesdeip.Text:= '';
  edtCodigoHastaip.Text:= '';
  edtNroRevip.Text:= '';
  edtNroRevDesdeip.Text:= '';
  edtNroRevHastaip.Text:= '';
  edtDescripcionip.Text:= '';
  edtAltaip.Text:= '';
  edtAprobacionip.Text:= '';
  edtRecepcionip.Text:= '';

  rbUltRevip.Checked:= True;
  ListViewip.Clear;
  ListViewip.Enabled:= False;
  btnAbririp.Enabled:= False;
  btnBuscarip.Enabled:= True;
  btnTodosip.Enabled:= True;
end;

procedure TConsultasFrm.btnTodosipClick(Sender: TObject);
begin
  if rbUltRevip.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO, PLN_SUPERADO ' +
           ' from INSTRUCTIVOSPRODUCCION order by 2,3,1'
  else if rbHistip.Checked then
    FSQL:= 'select PLN_FECHA, PLN_CODIGO, PLN_NRO_REV, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from INSTRUCTIVOSPRODUCCIONHISTORICO order by 2,3,1'
  else if rbTodosip.Checked then
    FSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from INSTRUCTIVOSPRODUCCION ' +
           ' union ' +
           'select PLN_CODIGO, PLN_NRO_REV, PLN_FECHA, PLN_NRO_EDIC ' +
           ', PLN_DESCRIPCION, PLN_USUARIO_ALTA, PLN_USUARIO_APR, PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC, PLN_FECHA_REC, PLN_UBICACION,PLN_ESTADO,PLN_SUPERADO ' +
           ' from INSTRUCTIVOSPRODUCCIONHISTORICO ';

  Consultarip;
end;

procedure TConsultasFrm.ListViewipCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if((item.SubItems[9] = 'PA') or (item.SubItems[9] = 'PR')) then
    sender.Canvas.Brush.Color:= clYellow;
    sender.Canvas.Font.Color:= clBlack;
  if((item.SubItems[10] = 'NS') and (item.SubItems[9] = 'AC')) then
    sender.Canvas.Brush.Color:= clLime;
    sender.Canvas.Font.Color:= clBlack;
  if((item.SubItems[10] = 'S')) then
    sender.Canvas.Brush.Color:= clRed;
    sender.Canvas.Font.Color:= clBlack;
end;

procedure TConsultasFrm.btnVolveripClick(Sender: TObject);
begin
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TConsultasFrm.btnAbriripClick(Sender: TObject);
begin
 if ListViewip.Selected.SubItems[8] <> '' then
  begin
    if ShellExecute( Self.Handle, 'explore'
                   , PChar(ListViewip.Selected.SubItems[8])
                   , nil, nil, SW_SHOWMAXIMIZED) <= 32 then
      Application.MessageBox('La ubicación del Instructivo de Producción no existe', 'SGPB', MB_ICONEXCLAMATION);
  end
  else
    Application.MessageBox('El registro del Instructivo de Producción seleccionado no tiene ingresada la ubicación del mismo', 'SGPB', MB_ICONINFORMATION,);

end;

procedure TConsultasFrm.edtCodigoipKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
  begin
    btnBuscaripClick(Sender);
  end;
end;

procedure TConsultasFrm.ListViewmpDblClick(Sender: TObject);
begin
  self.btnAbrirmp.Click;
end;

procedure TConsultasFrm.ListViewspDblClick(Sender: TObject);
begin
  self.btnAbrirsp.Click;
end;

procedure TConsultasFrm.ListViewipDblClick(Sender: TObject);
begin
  self.btnAbririp.Click;
end;

procedure TConsultasFrm.btnAbrirlmClick(Sender: TObject);
begin
  if ListViewlm.Selected.SubItems[8] <> '' then
  begin
    if ShellExecute( Self.Handle, 'explore'
                   , PChar(ListViewlm.Selected.SubItems[8])
                   , nil, nil, SW_SHOWMAXIMIZED) <= 32 then
      Application.MessageBox('La ubicación de la Lista de Materiales no existe', 'SGPB', MB_ICONEXCLAMATION);
  end
  else
    Application.MessageBox('El registro de la Lista de Materiales seleccionado no tiene ingresada la ubicación del mismo', 'SGPB', MB_ICONINFORMATION,);
end;

procedure TConsultasFrm.ListViewlmDblClick(Sender: TObject);
begin
  self.btnAbrirlm.Click;
end;

end.










