unit UMaterialesAprobarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB,UOperacion, UMotorSql, UPantallaFrm;


type
  TMaterialesAprobarFrm = class(TPantallaFrm)
    lblCodigol: TLabel;
    edtCodigol: TEdit;
    btnBuscarl: TButton;
    lblDescripcionl: TLabel;
    edtDescripcionl: TEdit;
    lblUbicacionl: TLabel;
    edtUbicacionl: TEdit;
    btnDirl: TButton;
    btnConfirmarl: TButton;
    btnLimpiarl: TButton;
    btnVolverl: TButton;
    stbMateriales: TStatusBar;
    ADODataSet1: TADODataSet;
    procedure FormShow(Sender: TObject);
    procedure btnVolverlClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimpiarlClick(Sender: TObject);
    procedure btnBuscarlClick(Sender: TObject);
    procedure btnConfirmarlClick(Sender: TObject);
    procedure edtCodigolEnter(Sender: TObject);
    procedure btnBuscarlEnter(Sender: TObject);
    procedure edtDescripcionlEnter(Sender: TObject);
    procedure edtUbicacionlEnter(Sender: TObject);
    procedure btnConfirmarlEnter(Sender: TObject);
    procedure btnDirlClick(Sender: TObject);
    procedure edtCodigolKeyPress(Sender: TObject; var Key: Char);
 
    protected
      FOperacion: TOperacion;
      procedure LockScreen;
      procedure UnLockScreen;
    published
      property Operacion: TOperacion read FOperacion write FOperacion;
  end;

var
  MaterialesAprobarFrm: TMaterialesAprobarFrm;
  AdoCon: TADOConnection;
  AdoDst: TADODataset;


implementation

uses ULista, USistema, UAprobar, URecibir, UModificacion, UListaDB, UUtiles, shlobj;

{$R *.dfm}

procedure TMaterialesAprobarFrm.LockScreen;
begin
  self.lblCodigol.Enabled:= False;
  self.edtCodigol.Enabled:= False;
  self.edtCodigol.Text:= '';
  self.lblDescripcionl.Enabled:= False;
  self.edtDescripcionl.Enabled:= False;
  self.edtDescripcionl.Text:= '';
  self.lblUbicacionl.Enabled:= False;
  self.edtUbicacionl.Enabled:= False;
  self.edtUbicacionl.Text:= '';
  self.btnDirl.Enabled:= False;
  self.btnBuscarl.Visible:= False;
  self.btnLimpiarl.Visible:= False;
  self.btnVolverl.SetFocus;
end;

procedure TMaterialesAprobarFrm.UnLockScreen;
begin
  self.lblCodigol.Enabled:= True;
  self.edtCodigol.Enabled:= True;
  self.lblDescripcionl.Enabled:= True;
  self.edtDescripcionl.Enabled:= True;
  self.lblUbicacionl.Enabled:= True;
  self.edtUbicacionl.Enabled:= True;
  self.btnDirl.Enabled:= True;
  self.btnBuscarl.Visible:= True;
  self.btnConfirmarl.Visible:= True;
  self.btnLimpiarl.Visible:= True;
end;

procedure TMaterialesAprobarFrm.FormShow(Sender: TObject);
begin
    //FLocked:= False;
    edtCodigol.Enabled:= True;
    edtCodigol.Text:= '';
    btnBuscarl.Enabled:= True;
    edtDescripcionl.Enabled:= False;
    edtDescripcionl.Text:= '';
    edtDescripcionl.TabStop:= False;
    btnDirl.Enabled:= False;
    btnConfirmarl.Enabled:= False;
    edtUbicacionl.Enabled:= False;
    edtUbicacionl.Text:= '';
    edtUbicacionl.TabStop:= False;
    edtCodigol.SetFocus;
   
   if Operacion is TAprobar then
    begin
      MaterialesAprobarFrm.Caption:= 'Aprobar Lista de Materiales';
    end
     else if Operacion is TRecibir then
     begin
       MaterialesAprobarFrm.Caption:= 'Recibir Lista de Materiales';
    end
    else if Operacion is TModificacion then
    begin
       MaterialesAprobarFrm.Caption:= 'Modificar Lista de Materiales';
    end;

end;

procedure TMaterialesAprobarFrm.btnVolverlClick(Sender: TObject);
begin
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
end;

procedure TMaterialesAprobarFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  btnVolverl.Click;
end;

procedure TMaterialesAprobarFrm.btnLimpiarlClick(Sender: TObject);
begin
  edtCodigol.Enabled:= True;
  edtCodigol.Text:= '';
  btnBuscarl.Enabled:= True;
  edtDescripcionl.Enabled:= False;
  edtDescripcionl.Text:= '';
  edtDescripcionl.TabStop:= False;
  edtUbicacionl.Text:= '';
  edtUbicacionl.TabStop:= False;
  edtUbicacionl.Enabled:= False;
  btnDirl.Enabled:= False;
  btnConfirmarl.Enabled:= False;
  edtCodigol.SetFocus;
end;

procedure TMaterialesAprobarFrm.btnBuscarlClick(Sender: TObject);
var
  Lista: TLista;
  Ret: Boolean;

begin
  Ret:= False;
  if edtCodigol.Text = '' then
  begin
    edtCodigol.Color:= clYellow;
    if Operacion is TAprobar then
      ShowMessage('Debe ingresar el c�digo correspondiente a la Lista de Materiales que desea aprobar')
    else if Operacion is TRecibir then
      ShowMessage('Debe ingresar el c�digo correspondiente a la Lista de Materiales que desea recibir')
    else if Operacion is TModificacion then
      ShowMessage('Debe ingresar el c�digo correspondiente a la Lista de Materiales que desea modificar');

    edtCodigol.Color:= clWindow;
    edtCodigol.SetFocus;
  end
  else
  begin
    edtCodigol.Text:= UpperCase(edtCodigol.Text);
    Lista:= TLista.Create;
    Lista.Codigo:= edtCodigol.Text;

    if Operacion is TAprobar then
      Ret:= TSistema.GetInstance.ListaDB.GetLista(Lista, PLN_EST_PEND_APR)
    else if Operacion is TRecibir then
      Ret:= TSistema.GetInstance.ListaDB.GetLista(Lista, PLN_EST_PEND_REC)
    else if Operacion is TModificacion then
      Ret:= TSistema.GetInstance.ListaDB.GetLista(Lista, PLN_EST_TODOS);

    if Ret then
    begin
      edtDescripcionl.Text:= Lista.Descripcion;
      edtUbicacionl.Text:= Lista.Ubicacion;
      btnConfirmarl.Enabled:= True;
      edtCodigol.Enabled:= False;
      btnBuscarl.Enabled:= False;

      if Operacion is TModificacion then
      begin
        edtDescripcionl.Enabled:= True;
        edtDescripcionl.TabStop:= True;
        edtUbicacionl.Enabled:= True;
        edtUbicacionl.TabStop:= True;
        btnDirl.Enabled:= True;
        edtDescripcionl.SetFocus;
      end
      else
        btnConfirmarl.SetFocus;
    end
    else
    begin
      edtCodigol.Color:= clYellow;
      if Operacion is TAprobar then
        ShowMessage('El c�digo que ingres� no corresponde a ning�na Lista de Materiales existente pendiente de aprobaci�n en la base de datos')
      else if Operacion is TRecibir then
        ShowMessage('El c�digo que ingres� no corresponde a ning�na Lista de Materiales existente pendiente de recepci�n en la base de datos')
      else if Operacion is TModificacion then
        ShowMessage('El c�digo que ingres� no corresponde a ning�na Lista de Materiales existente en la base de datos');

      edtCodigol.Color:= clWindow;
      edtCodigol.SetFocus;
    end;
    Lista.Free;
  end;
end;

procedure TMaterialesAprobarFrm.btnConfirmarlClick(Sender: TObject);
 var
  Lista: TLista;
  CodRet: Integer;

begin
  CodRet:= 0;

  if Operacion is TAprobar then
    CodRet:= MessageDlg('� Esta seguro que desea aprobar la Lista de Materiales ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TRecibir then
    CodRet:= MessageDlg('� Esta seguro que desea recibir la Lista de Materiales ?', mtConfirmation, mbOKCancel, 0)
  else if Operacion is TModificacion then
    CodRet:= MessageDlg('� Esta seguro que desea modificar la Lista de Materiales ?', mtConfirmation, mbOKCancel, 0);

  if CodRet = mrOK then
  begin
    Lista:= TLista.Create;

    Lista.Codigo:= edtCodigol.Text;

    if Operacion is TAprobar then
    begin
     CodRet:= TSistema.GetInstance.ListaDB.Aprobar(Lista);
      if CodRet = PLN_APR_OK then
      begin
        ShowMessage('La Lista de Materiales ' + lista.Codigo + ' se aprob� satisfactoriamente');
        Lista.Free;
        if MessageDlg('� Desea aprobar otra Lista de Materiales ?', mtConfirmation, mbOKCancel, 0) = mrOK then

          btnLimpiarl.Click
        else
          btnVolverl.Click;
      end
      else
        ShowMessage('La Lista de Materiales ' + Lista.Codigo + ' no se pudo aprobar');
    end
    else if Operacion is TRecibir then
    begin
      CodRet:= TSistema.GetInstance.ListaDB.Recibir(Lista);
      if CodRet = PLN_REC_OK then
      begin
        ShowMessage('La Lista de Materiales ' + Lista.Codigo + ' se recibi� satisfactoriamente');
        Lista.Free;

        if MessageDlg('� Desea recibir otra Lista de Materiales ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiarl.Click
        else
          btnVolverl.Click;
      end
      else
        ShowMessage('La Lista de Materiales ' + Lista.Codigo + ' no se pudo recibir');
    end
    else if Operacion is TModificacion then
    begin
      Lista.Descripcion:= edtDescripcionl.Text;
      Lista.Ubicacion:= edtUbicacionl.Text;
      CodRet:= TSistema.GetInstance.ListaDB.Modificacion(Lista);
      if CodRet = PLN_MODIF_OK then
      begin
        ShowMessage('La Lista de Materiales ' + Lista.Codigo + ' se modific� satisfactoriamente');
        Lista.Free;

        if MessageDlg('� Desea modificar otra Lista de Materiales ?', mtConfirmation, mbOKCancel, 0) = mrOK then
          btnLimpiarl.Click
        else
          btnVolverl.Click;
      end
      else
        ShowMessage('La Lista de Materiales ' + Lista.Codigo + ' no se pudo modificar');
    end;

  end;
end;

procedure TMaterialesAprobarFrm.edtCodigolEnter(Sender: TObject);
begin
  if Operacion is TAprobar then
    stbMateriales.SimpleText:= 'Ingrese el c�digo de la Lista de Materiales'
  else if Operacion is TRecibir then
    stbMateriales.SimpleText:= 'Ingrese el c�digo de la Lista de Materiales'
  else if Operacion is TModificacion then
    stbMateriales.SimpleText:= 'Ingrese el c�digo de la Lista de Materiales';
end;

procedure TMaterialesAprobarFrm.btnBuscarlEnter(Sender: TObject);
begin
  stbMateriales.SimpleText:= 'Busca el c�digo de la Lista de Materiale ingresada en la base de datos';
end;

procedure TMaterialesAprobarFrm.edtDescripcionlEnter(Sender: TObject);
begin
  stbMateriales.SimpleText:= 'Ingrese la descripcion de la Lista de Materiales';
end;

procedure TMaterialesAprobarFrm.edtUbicacionlEnter(Sender: TObject);
begin
  stbMateriales.SimpleText:= 'Ingrese la ubicaci�n del archivo con la Lista de Materiales';
end;

procedure TMaterialesAprobarFrm.btnConfirmarlEnter(Sender: TObject);
begin
  if Operacion is TAprobar then
    stbMateriales.SimpleText:= 'Aprueba la Lista de Materiales especificada'
  else if Operacion is TRecibir then
    stbMateriales.SimpleText:= 'Recibe la Lista de Materiales especificada'
  else if Operacion is TModificacion then
    stbMateriales.SimpleText:= 'Modifica la Lista de Materiales especificada';
end;

procedure TMaterialesAprobarFrm.btnDirlClick(Sender: TObject);
  var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra la Lista de Materiales:',
      CSIDL_DRIVES, edtUbicacionl.Text);
  if sDir <> '' then
    edtUbicacionl.Text:= sDir;
end;

procedure TMaterialesAprobarFrm.edtCodigolKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
    btnBuscarl.Click;
end;

end.
