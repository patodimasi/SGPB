unit UMaterialesAltaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,UPantallaFrm,USistema,DB,ADODB,UMotorSQL,UPlano,ShellApi,
  ImgList, Menus,UBuscarLMFrm, Buttons,ComObj;

type
  TMaterialesAltaFrm = class(TPantallaFrm)
    lblCodigol: TLabel;
    edtCodigol: TEdit;
    lblDescripcionl: TLabel;
    edtDescripcionl: TEdit;
    lblUbicacionl: TLabel;
    edtUbicacionl: TEdit;
    btnDirl: TButton;
    btnConfirmarl: TButton;
    btnLimpiarl: TButton;
    btnVolverl: TButton;
    stbPlano: TStatusBar;
    ADODataSet1: TADODataSet;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    DescripcionAM: TMenuItem;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    ImageList2: TImageList;
    procedure btnVolverEnter(Sender: TObject);
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarlEnter(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnDirlClick(Sender: TObject);
    procedure btnDirlEnter(Sender: TObject);
    procedure edtDescripcionlEnter(Sender: TObject);
    procedure edtUbicacionlEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
   FArbol: TTreeNode;
   BlmFrm: TBuscarLMFrm;
    //procedure GenerarCodigo;
   // procedure LockScreen;
   // procedure UnLockScreen;
    function Formatear(S: string): string;
  public
    { Public declarations }
  end;

var
  MaterialesAltaFrm: TMaterialesAltaFrm;

implementation

{$R *.dfm}
uses
   UPlanoDB, UUtiles, shlobj, UMateriales;
function TMaterialesAltaFrm.Formatear(S: string): string;
begin
  if S = '' then
    Result:= 'NULL'
  else
    Result:= QuotedStr(S);
end;
{procedure TMaterialesAltaFrm.LockScreen;
begin
  lblCodigol.Enabled:= False;
  edtCodigol.Enabled:= False;
  edtCodigol.Text:= '';
  lblDescripcionl.Enabled:= False;
  edtDescripcionl.Enabled:= False;
  lblUbicacionl.Enabled:= False;
  edtUbicacionl.Enabled:= False;
  btnDirl.Enabled:= False;
  btnConfirmarl.Visible:= False;
  btnLimpiarl.Visible:= False;
  btnVolverl.SetFocus;
end;

procedure TMaterialesAltaFrm.UnLockScreen;
begin
  lblCodigol.Enabled:= True;
  edtCodigol.Enabled:= True;
  lblDescripcionl.Enabled:= True;
  edtDescripcionl.Enabled:= True;
  lblUbicacionl.Enabled:= True;
  edtUbicacionl.Enabled:= True;
  btnDirl.Enabled:= True;
  btnConfirmarl.Visible:= True;
  btnLimpiarl.Visible:= True;
end;}
procedure TMaterialesAltaFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Regresa a la pantalla anterior';
end;
procedure TMaterialesAltaFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TMaterialesAltaFrm.btnLimpiarlEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;
procedure TMaterialesAltaFrm.btnLimpiarClick(Sender: TObject);
begin
  self.edtDescripcionl.Text:= '';
  self.edtUbicacionl.Text:= '';
  self.edtCodigol.Text:= '';
  self.FArbol.Delete;
  self.edtDescripcionl.SetFocus;
end;
procedure TMaterialesAltaFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Da de Alta la Lista de Materiales en la base de datos';
end;

procedure TMaterialesAltaFrm.btnConfirmarClick(Sender:TObject);
var
  sSQL:string;
  UsuarioAlta:string;
  Materiales: TMateriales;
  Existe : string;
begin
  Materiales:= TMateriales.Create;
  Materiales.Codigol:= self.edtCodigol.Text;
  UsuarioAlta:= TSistema.getInstance.getUsuario.Logon;

  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'select PLN_CODIGO ' +
         ' from MATERIALES' +
         ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigol.Text);
  self.ADODataSet1.CommandText:= sSQL;
  self.ADODataSet1.Close;
  self.ADODataSet1.Open;

  if self.ADODataSet1.RecordCount > 0 then
  begin
   ShowMessage('La Lista de Materiales ya existe en la Base de Datos');
   self.edtCodigol.Color:= clwindow;
   self.edtCodigol.SetFocus;
  end
  else
  begin

  sSQL:= 'insert into  MATERIALES (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA,PLN_SUPERADO)'+
         ' VALUES ('+QuotedStr(Self.edtCodigol.Text)+','+QuotedStr(Self.edtDescripcionl.Text)+','+QuotedStr('PA')+','+QuotedStr(self.edtUbicacionl.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+','+QuotedStr('NS')+')';


            //    , [Formatear(P.Codigo), Formatear(P.Descripcion)]);
  TMotorSQL.GetInstance.OpenConn;

  TMotorSQL.GetInstance.ExecuteSQL(sSQL);
  ShowMessage('La Lista de Materiales ' + Materiales.Codigol + ' se dio de alta satisfactoriamente');

  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
    else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;

  TMotorSQL.GetInstance.CloseConn;
  Self.edtCodigol.Text := '';
  Self.edtDescripcionl.Text := '';
  Self.edtUbicacionl.Text := '';

end;

{procedure TMaterialesAltaFrm.GenerarCodigo;
var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;
  CodMax: string;
  iCodMax: integer;
  iUltimoCodMax :integer;
begin
  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

//  sSQL:= 'select max(PLN_CODIGO) as CodMax from MATERIALES where PLN_CODIGO like '+QuotedStr('MAT-%');
  sSQL:= 'select PLN_CODIGO as CodMax from MATERIALES where PLN_CODIGO like '+QuotedStr('MAT-%');
  Dst:= TADODataset.Create(nil);
  try
    // Obtengo la conexion a la BD
    Dst.Connection:= MSQL.GetConn;
    Dst.CommandText:= sSQL;
    Dst.Open;
    if Dst.Eof then
    Begin
      Self.edtCodigol.Text := 'MAT-001';
    end
      else
    Begin
     iUltimoCodMax := -1;
     while not(Dst.Eof) do
     Begin
       CodMax:= Dst.FieldByName('CodMax').AsString;
       Delete(CodMax,1,4);
       iCodMax := StrToInt(CodMax);
       if iCodMax>iUltimoCodMax then
       Begin
         iUltimoCodMax := iCodMax;
       end;
//       iCodMax := iCodMax+1;
       Dst.Next;
     end;
//     CodMax:= Dst.FieldByName('CodMax').AsString;
//     Delete(CodMax,1,4);
//     iCodMax := StrToInt(CodMax);
//     iCodMax := iCodMax+1;
 //    Self.edtCodigol.Text := 'MAT-'+IntToStr(iCodMax);
      Self.edtCodigol.Text := 'MAT-'+IntToStr(iUltimoCodMax+1);
    end;
    Dst.Close;
    MSQL.CloseConn;
  finally
    Dst.Free;
  end;
end;}
end;
procedure TMaterialesAltaFrm.btnDirlClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra la Lista de Materiales:',
      CSIDL_NETWORK, edtUbicacionl.Text);
  if sDir <> '' then
    edtUbicacionl.Text:= sDir;

end;
procedure TMaterialesAltaFrm.btnDirlEnter(Sender: TObject);
begin
  stbPlano.SimpleText:= 'Seleccione la carpeta donde se encuentra la Lista de Materiales';
end;
procedure TMaterialesAltaFrm.edtDescripcionlEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese una breve descripción de la Lista de Materiales';
end;
procedure TMaterialesAltaFrm.edtUbicacionlEnter(Sender: TObject);
begin
  self.stbPlano.SimpleText:= 'Ingrese la ubicación del archivo con la Lista de Materiales';
end;

{procedure TMaterialesAltaFrm.Button1Click(Sender: TObject);
var
 sSQL,sSQL2: string;
 Materiales: TMateriales;
begin
//self.TreeView1.Visible:= true;
  self.FArbol:= self.TreeView1.Items.Add(nil,self.edtCodigol.Text);
  Materiales:= TMateriales.Create;
  Materiales.Codigol:= self.edtCodigol.Text;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'select PLN_CODIGO ' +
         ' from MATERIALES' +
         ' where PLN_CODIGO like' + QuotedStr(self.edtCodigol.Text + '%');
  self.ADODataSet1.CommandText:= sSQL;
  self.ADODataSet1.Close;
  self.ADODataSet1.Open;
 while not (self.ADODataSet1.Eof) do
 begin
  materiales.Codigol:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
  self.TreeView1.Items.AddChild(self.FArbol,materiales.Codigol).ImageIndex:= 1;
  self.ADODataSet1.Next;
end;
end; }
procedure TMaterialesAltaFrm.FormShow(Sender: TObject);
begin
// self.FArbol:= self.TreeView1.Items.Add(nil,'LB9');
end;
{procedure TMaterialesAltaFrm.TreeView1Click(Sender: TObject);
var
MyNode: TTreeNode;
begin
 MyNode := self.TreeView1.Selected as TTreeNode;
 self.edtCodigol.Text:= MyNode.Text;
end;}
{procedure TMaterialesAltaFrm.TreeView1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

 var Pt: TPoint;
begin
  If Button = mbRight then
  begin
      {Si el raton se encuentra sobre un item, lanzamos el popup}
    //  if Not(htOnItem in TTreeView(Sender).GetHitTestInfoAt(X,Y)) then exit;

      {Obtenemos las coordenadas relativas al escritorio de X e Y}
    //  Pt:= Point((Left + TTreeView(Sender).Left + X +5),
               //  (Top + TTreeView(Sender).Top + Y +25));

      {Lanzamos el popupmenu}
    //  Popupmenu1.Popup(Pt.X,Pt.Y);
  //end;
//end;}
{procedure TMaterialesAltaFrm.DescripcionAMClick(Sender: TObject);
var
 sSQl: string;
 i: integer;
 Materiales: TMateriales;
 MyNode: TTreenode;
begin
  Materiales:= TMateriales.Create;
  //Materiales.Codigol:= self.edtCodigol.Text;
  MyNode:= self.TreeView1.Selected;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
  TMotorSql.GetInstance.OpenConn;
  sSQL:= 'select * from MATERIALES where PLN_CODIGO='+QuotedStr(MyNode.Text);
  self.ADODataSet1.CommandText:= sSQL;
  self.ADODataSet1.Close;
  self.ADODataSet1.Open;
  materiales.Codigol:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
  materiales.Revisionl:= self.ADODataSet1.fieldByName('PLN_NRO_REV').AsInteger;
  materiales.Descripcionl:= self.ADODataSet1.FieldByName('PLN_DESCRIPCION').AsString;
  MessageBox(GetActiveWindow, PChar('NroRev: '+ IntToStr(materiales.Revisionl)+#13#10+ 'Descripcion: '+materiales.Descripcionl) , PChar(materiales.Codigol), MB_OK);
 end;   }
{procedure TMaterialesAltaFrm.Button2Click(Sender: TObject);
var
 BlmFrm: TBuscarLMFrm;
 sSQL,sSQL2: string;
 Materiales: TMateriales;
begin
  BlmFrm:= TBuscarLmFrm.Create(nil);
//  BlmFrm.ShowModal();
//self.TreeView1.Visible:= true;
 // self.FArbol:= self.TreeView1.Items.Add(nil,self.edtCodigol.Text);
  self.FArbol:= BlmFrm.TreeView1.Items.Add(nil,MaterialesAltaFrm.edtCodigol.Text);
  Materiales:= TMateriales.Create;
 // Materiales.Codigol:= self.edtCodigol.Text;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'select PLN_CODIGO ' +
         ' from MATERIALES' +
         ' where PLN_CODIGO like' + QuotedStr(MaterialesAltaFrm.edtCodigol.Text + '%');
  self.ADODataSet1.CommandText:= sSQL;
  self.ADODataSet1.Close;
  self.ADODataSet1.Open;

 while not (self.ADODataSet1.Eof) do
 begin
  materiales.Codigol:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
  //self.TreeView1.Items.AddChild(self.FArbol,materiales.Codigol).ImageIndex:= 1;
  BlmFrm.TreeView1.Items.AddChild(self.FArbol,materiales.Codigol).ImageIndex:= 1;
  self.ADODataSet1.Next;
end;
    BlmFrm.ShowModal();
end;}
procedure TMaterialesAltaFrm.BitBtn1Click(Sender: TObject);
var
 //BlmFrm: TBuscarLMFrm;
 arbolBo,arbolBohijo,arbolCV,arbolCS,arbolRPO: TTreenode;
 arbolDMC,arbolRA,arbolSi96,arbolMai2: TTreenode;
 arbolMO2,arbolRSCBDS,arbolRectificador,arbolSA4003:TTreenode;
 arbolDPT,arbolDCF,arbolPL,arbolPLL1,arbolPLS,LMCV,LMBO,LMCVHijo: TTreenode;
 LMCS,LMRPO,LMDMC,LMRA,LMSI96,LMMAI2,LMMO2,LMREC,LMRSCBDS,LMDPT,LMDCF,LMPLSC: TTreenode;
 LMPL1,LMMOD,LMMB04,LMSA4003: TTreenode;
 arbolHijoPl1,arbolHijoMod,arbolHijoMB04,arbolHijoSA4003: TTreenode;
 arbolMod,arbolMB04,arbolHijoSI96,arbolHijoMO2,arbolhijoRec,arbolHijoRSCBDS,arbolHijoDCF: TTreenode;
 arbolCsHijo,arbolHijoRPO,arbolHijoDmc,arbolHijoRA,arbolHijoMAI2,arbolHijoDPT,arbolHijoPLSC:TTreenode;
 sSQL,sSQL2: string;
 Materiales: TMateriales;
 lista: TStringList;
 i,j: integer;
 MyNode: TTreenode;
 DstABo: TADODataset;
 DstCs:  TADODataset;
 DstRPO,DstMB04: TADODataset;
 DstDMC,DstMOD: TADODataset;
 DstRA,DstPL1: TADODataset;
 DstSI96,DstPLSC: TADODataset;
 DstMAI2,DstDCF: TADODataset;
 DstMO2,DstDPT: TADODataset;
 DstRec,DstRSCBDS: TADODataset;
 DstSA4003: TADODataset;
begin
 try
  BlmFrm:= TBuscarLmFrm.Create(self);
 // self.FArbol:= BlmFrm.TreeView1.Items.Add(nil,MaterialesAltaFrm.edtCodigol.Text);
 self.FArbol:= BlmFrm.TreeView1.Items.Add(nil,'Productos');
 //self.FArbol.ImageIndex:= 0;
 BlmFrm.TreeView1.Items.Item[0].ImageIndex:= 0;
 BlmFrm.TreeView1.Items.Item[0].SelectedIndex:= 0;

 for i:= 0 to (BlmFrm.TreeView1.Items.Count-1) do
 begin
  BlmFrm.TreeView1.Items[i].ImageIndex:=2;
  BlmFrm.TreeView1.Items[i].SelectedIndex:= 2;
 end;
  arbolCS:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'PL-1001 Señalizacion Optica');
  arbolRPO:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'RPO/RNO/RCA');
  arbolDMC:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'DMC');
  arbolRA:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'SA3002N');
  arbolSi96:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'Si-96');
  arbolMai2:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'MAI-2');
  arbolMO2:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'MO-2');
  arbolRSCBDS:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'RSCBDS');
  arbolRectificador:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'Rectificador');
  arbolDPT:= BLmFrm.TreeView1.Items.AddChild(self.FArbol,'DPT');
  arbolDCF:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'DCF');
  arbolBo:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'Bocina2002');
  arbolCv:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'CV2000');
  arbolPLS:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'PL/SC2');
  arbolPL:=BlmFrm.TreeView1.Items.AddChild(self.FArbol,'PL-L1');
  arbolMod:= BlmFrm.TreeView1.Items.AddChild(self.FArbol,'MOD');
  arbolMB04:= BLMFrm.TreeView1.Items.AddChild(self.FArbol,'MB04');
  arbolSA4003:= BLMFrm.TreeView1.Items.AddChild(self.FArbol,'Sistema de Alarma SA4003');
  LMCV:= BlmFrm.TreeView1.Items.AddChild(arbolCv,'Lista de Materiales');
  LMBO:= BlmFrm.TreeView1.Items.AddChild(arbolBo,'Lista de Materiales');
  LMCS:= BlmFrm.TreeView1.Items.AddChild(arbolCs,'Lista deMateriales');
  LMRPO:= BLMFrm.TreeView1.Items.AddChild(arbolRPO,'Lista de Materiales');
  LMDMC:= BLMFrm.TreeView1.Items.AddChild(arbolDMC,'Lista de Materiales');
  LMRA:= BLMFrm.TreeView1.Items.AddChild(arbolRA,'Lista de Materiales');
  LMSI96:= BLMFrm.TreeView1.Items.AddChild(arbolSi96,'Lista de Materiales');
  LMMAI2:= BLMFrm.TreeView1.Items.AddChild(arbolMai2,'Lista de Materiales');
  LMMO2:= BLMFrm.TreeView1.Items.AddChild(arbolMO2,'Lista de Materiales');
  LMREC:= BLMFrm.TreeView1.Items.AddChild(arbolRectificador,'Lista de Materiales');
  LMRSCBDS:= BLMFrm.TreeView1.Items.AddChild(arbolRSCBDS,'Lista de Materiales');
  LMDPT:= BLMFrm.TreeView1.Items.AddChild(arbolDPT,'Lista de Materiales');
  LMDCF:= BLMFrm.TreeView1.Items.AddChild(arbolDCF,'Lista de Materiales');
  LMPLSC:= BLMFrm.TreeView1.Items.AddChild(arbolPLS,'Lista de Materiales');
  LMPL1:= BLMFrm.TreeView1.Items.AddChild(arbolPL,'Lista de Materiales');
  LMMOD:= BLMFrm.TreeView1.Items.AddChild(arbolMOD,'Lista de Materiales');
  LMMB04:= BLMFrm.TreeView1.Items.AddChild(ArbolMB04,'Lista de Materiales');
  LMSA4003:= BlmFrm.TreeView1.Items.AddChild(ArbolSA4003,'Lista de Materiales');
  LMCV.ImageIndex:= 1;
  LMCV.SelectedIndex := 1;
  LMBO.ImageIndex:= 1;
  LMBO.SelectedIndex:= 1;
  LMCS.ImageIndex:= 1;
  LMCS.SelectedIndex:= 1;
  LMRPO.ImageIndex:= 1;
  LMRPO.SelectedIndex:= 1;
  LMDMC.ImageIndex:= 1;
  LMDMC.SelectedIndex:= 1;
  LMRA.ImageIndex:= 1;
  LMRA.SelectedIndex:= 1;
  LMSI96.ImageIndex:= 1;
  LMSI96.SelectedIndex:=1;
  LMMAI2.ImageIndex:= 1;
  LMMAI2.SelectedIndex:= 1;
  LMMO2.ImageIndex:= 1;
  LMMO2.SelectedIndex:= 1;
  LMRec.ImageIndex:= 1;
  LMRec.SelectedIndex:= 1;
  LMRSCBDS.ImageIndex:= 1;
  LMRSCBDS.SelectedIndex:= 1;
  LMDPT.ImageIndex:= 1;
  LMDPT.SelectedIndex:= 1;
  LMDCF.ImageIndex:= 1;
  LMDCF.SelectedIndex:= 1;
  LMPLSC.ImageIndex:= 1;
  LMPLSC.SelectedIndex:= 1;
  LMPL1.ImageIndex:= 1;
  LMPL1.SelectedIndex:= 1;
  LMMOD.ImageIndex:= 1;
  LMMOD.SelectedIndex:= 1;
  LMMB04.ImageIndex:= 1;
  LMMB04.SelectedIndex:= 1;
  LMSA4003.SelectedIndex:= 1;
  LMSA4003.ImageIndex:= 1;

  Materiales:= TMateriales.Create;
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'select PLN_CODIGO ' +
        ' from MATERIALES ' +
        ' where PLN_CODIGO like' + quotedStr('LB9-012'+'%');
  self.ADODataSet1.CommandText:= sSQL;
  self.ADODataSet1.Close;
  self.ADODataSet1.Open;
 while not (self.ADODataSet1.Eof) do
 begin
   materiales.Codigol:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
   LMCVHijo := BlmFrm.TreeView1.Items.AddChild(LMCV,materiales.Codigol);
   LMCVHijo.ImageIndex:= 0;
   LMCVHijo.SelectedIndex := 0;
   self.ADODataSet1.Next;
end;
    DstABo:=  TADODataset.Create(nil);
    DstABo.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
        ' from MATERIALES ' +
        ' where PLN_CODIGO like' + quotedStr('LB9-002'+'%');
   DstABo.CommandText:= sSQL;
   DstABo.Close;
   DstABo.Open;
 while not (DstABo.Eof) do
 begin
   materiales.Codigol:= DstABo.fieldByName('PLN_CODIGO').AsString;
   arbolBohijo := BlmFrm.TreeView1.Items.AddChild(LMBO,materiales.Codigol);
   DstABo.Next;
end;
   DstCS:=  TADODataset.Create(nil);
   DstCs.Connection:= TMotorSql.GetInstance.GetConn;
   sSQL:= 'select PLN_CODIGO ' +
          ' from MATERIALES ' +
          ' where PLN_CODIGO like' + quotedStr('LB9-001'+'%');
   DstCs.CommandText:= sSQL;
   DstCs.Close;
   DstCs.Open;
   while not (DstCs.Eof) do
   begin
     materiales.Codigol:= DstCs.fieldByName('PLN_CODIGO').AsString;
     arbolCsHijo := BlmFrm.TreeView1.Items.AddChild(LMCS,materiales.Codigol);
     DstCs.Next;
   end;
    DstRPO:=  TADODataset.Create(nil);
    DstRPO.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-003'+'%');
    DstRPO.CommandText:= sSQL;
    DstRPO.Close;
    DstRPO.Open;
   while not (DstRPO.Eof) do
   begin
     materiales.Codigol:= DstRPO.fieldByName('PLN_CODIGO').AsString;
     arbolHijoRPO := BlmFrm.TreeView1.Items.AddChild(LMRPO,materiales.Codigol);
//  LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
     DstRPO.Next;
   end;
    DstDMC:=  TADODataset.Create(nil);
    DstDMC.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-004'+'%');
    DstDMC.CommandText:= sSQL;
    DstDMc.Close;
    DstDMC.Open;
   while not (DstDMC.Eof) do
   begin
    materiales.Codigol:= DstDMC.fieldByName('PLN_CODIGO').AsString;
    arbolHijoDmc := BlmFrm.TreeView1.Items.AddChild(LMDMC,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstDMC.Next;
   end;
    DstRA:=  TADODataset.Create(nil);
    DstRA.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-005'+'%');
    DstRA.CommandText:= sSQL;
    DstRA.Close;
    DstRA.Open;
   while not (DstRA.Eof) do
   begin
     materiales.Codigol:= DstRA.fieldByName('PLN_CODIGO').AsString;
     arbolHijoSI96:= BlmFrm.TreeView1.Items.AddChild(LMRA,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
     DstRA.Next;
   end;
    DstSI96:=  TADODataset.Create(nil);
    DstSI96.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-006'+'%');
    DstSI96.CommandText:= sSQL;
    DstSI96.Close;
    DstSI96.Open;
   while not (DstSI96.Eof) do
   begin
    materiales.Codigol:= DstSI96.fieldByName('PLN_CODIGO').AsString;
    arbolHijoSI96:= BlmFrm.TreeView1.Items.AddChild(LMSI96,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstSI96.Next;
   end;
    DstMAI2:=  TADODataset.Create(nil);
    DstMAI2.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-007'+'%');
    DstMAI2.CommandText:= sSQL;
    DstMAI2.Close;
    DstMAI2.Open;
   while not (DstMAI2.Eof) do
   begin
    materiales.Codigol:= DstMAI2.fieldByName('PLN_CODIGO').AsString;
    arbolHijoMAI2:= BlmFrm.TreeView1.Items.AddChild(LMMAI2,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstMAI2.Next;
   end;
    DstMO2:=  TADODataset.Create(nil);
    DstMO2.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-008'+'%');
    DstMO2.CommandText:= sSQL;
    DstMO2.Close;
    DstMO2.Open;
   while not (DstMO2.Eof) do
   begin
    materiales.Codigol:= DstMO2.fieldByName('PLN_CODIGO').AsString;
    arbolHijoMO2:= BlmFrm.TreeView1.Items.AddChild(LMMO2,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstMO2.Next;
   end;
    DstRec:=  TADODataset.Create(nil);
    DstRec.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-011'+'%');
    DstRec.CommandText:= sSQL;
    DstRec.Close;
    DstRec.Open;
   while not (DstRec.Eof) do
   begin
    materiales.Codigol:= DstRec.fieldByName('PLN_CODIGO').AsString;
    arbolHijoRec:= BlmFrm.TreeView1.Items.AddChild(LMRec,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstRec.Next;
   end;
    DstRSCBDS:=  TADODataset.Create(nil);
    DstRSCBDS.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-009'+'%');
    DstRSCBDS.CommandText:= sSQL;
    DstRSCBDS.Close;
    DstRSCBDS.Open;
   while not (DstRSCBDS.Eof) do
   begin
    materiales.Codigol:= DstRSCBDS.fieldByName('PLN_CODIGO').AsString;
    arbolHijoRSCBDS:= BlmFrm.TreeView1.Items.AddChild(LMRSCBDS,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstRSCBDS.Next;
   end;
    DstDPT:=  TADODataset.Create(nil);
    DstDPT.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-013'+'%');
    DstDPT.CommandText:= sSQL;
    DstDPT.Close;
    DstDPT.Open;
   while not (DstDPT.Eof) do
   begin
    materiales.Codigol:= DstDPT.fieldByName('PLN_CODIGO').AsString;
    arbolHijoDPT:= BlmFrm.TreeView1.Items.AddChild(LMDPT,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstDPT.Next;
   end;
    DstDCF:=  TADODataset.Create(nil);
    DstDCF.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-014'+'%');
    DstDCF.CommandText:= sSQL;
    DstDCF.Close;
    DstDCF.Open;
   while not (DstDCF.Eof) do
   begin
    materiales.Codigol:= DstDCF.fieldByName('PLN_CODIGO').AsString;
    arbolHijoDCF:= BlmFrm.TreeView1.Items.AddChild(LMDCF,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstDCF.Next;
   end;
    DstPLSC:=  TADODataset.Create(nil);
    DstPLSC.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-015'+'%');
    DstPLSC.CommandText:= sSQL;
    DstPLSC.Close;
    DstPLSC.Open;
   while not (DstPLSC.Eof) do
   begin
    materiales.Codigol:= DstPLSC.fieldByName('PLN_CODIGO').AsString;
    arbolHijoPLSC:= BlmFrm.TreeView1.Items.AddChild(LMPLSC,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstPLSC.Next;
   end;
    DstPL1:=  TADODataset.Create(nil);
    DstPL1.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-016'+'%');
    DstPL1.CommandText:= sSQL;
    DstPL1.Close;
    DstPL1.Open;
   while not (DstPL1.Eof) do
   begin
    materiales.Codigol:= DstPL1.fieldByName('PLN_CODIGO').AsString;
    arbolHijoPL1:= BlmFrm.TreeView1.Items.AddChild(LMPL1,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstPL1.Next;
   end;
    DstMOD:=  TADODataset.Create(nil);
    DstMOD.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-019'+'%');
    DstMOD.CommandText:= sSQL;
    DstMOD.Close;
    DstMOD.Open;
   while not (DstMOD.Eof) do
   begin
    materiales.Codigol:= DstMOD.fieldByName('PLN_CODIGO').AsString;
    arbolHijoMod:= BlmFrm.TreeView1.Items.AddChild(LMMOD,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstMOD.Next;
   end;
    DstMB04:=  TADODataset.Create(nil);
    DstMB04.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-018'+'%');
    DstMB04.CommandText:= sSQL;
    DstMB04.Close;
    DstMB04.Open;
   while not (DstMB04.Eof) do
   begin
    materiales.Codigol:= DstMB04.fieldByName('PLN_CODIGO').AsString;
    arbolHijoMB04:= BlmFrm.TreeView1.Items.AddChild(LMMB04,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstMB04.Next;
   end;
    DstSA4003:=  TADODataset.Create(nil);
    DstSA4003.Connection:= TMotorSql.GetInstance.GetConn;
    sSQL:= 'select PLN_CODIGO ' +
           ' from MATERIALES ' +
           ' where PLN_CODIGO like' + quotedStr('LB9-017'+'%');
    DstSA4003.CommandText:= sSQL;
    DstSA4003.Close;
    DstSA4003.Open;
   while not (DstSA4003.Eof) do
   begin
    materiales.Codigol:= DstSA4003.fieldByName('PLN_CODIGO').AsString;
    arbolHijoSA4003:= BlmFrm.TreeView1.Items.AddChild(LMSA4003,materiales.Codigol);
 // LMCVHijo.ImageIndex:= 0;
//  LMCVHijo.SelectedIndex := 0;
    DstSA4003.Next;
   end;
   BlmFrm.ShowModal;
   finally
    BlmFrm.Free;
 end;
end;

procedure TMaterialesAltaFrm.FormDestroy(Sender: TObject);
begin
 TMotorSql.GetInstance.CloseConn;
end;

end.

