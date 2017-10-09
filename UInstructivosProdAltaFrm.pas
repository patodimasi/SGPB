unit UInstructivosProdAltaFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, USistema, UDVarios, UMotorSql, ADODB, UObjectDB,shlobj,UUtiles, UPantallaFrm;

type
  TInstructivosMaterialesAltaFrm = class(TPantallaFrm)
    lblCodigodv: TLabel;
    edtCodigodv: TEdit;
    lblDescripciondv: TLabel;
    edtDescripciondv: TEdit;
    lblUbicaciondv: TLabel;
    edtUbicaciondv: TEdit;
    btnDirdv: TButton;
    btnConfirmardv: TButton;
    btnLimpiardv: TButton;
    btnVolverdv: TButton;
    StatusBar1: TStatusBar;
    procedure btnVolverdvClick(Sender: TObject);
    procedure btnLimpiardvClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmardvClick(Sender: TObject);
    procedure btnDirdvClick(Sender: TObject);
    procedure edtDescripciondvEnter(Sender: TObject);
    procedure edtUbicaciondvEnter(Sender: TObject);
    procedure btnDirdvEnter(Sender: TObject);
    procedure btnConfirmardvEnter(Sender: TObject);
    procedure btnLimpiardvEnter(Sender: TObject);
    procedure btnVolverdvEnter(Sender: TObject);

  private
    procedure GenerarCodigo;
    procedure LockScreen;
    procedure UnLockScreen;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  InstructivosMaterialesAltaFrm: TInstructivosMaterialesAltaFrm;

implementation

{$R *.dfm}
procedure TInstructivosMaterialesAltaFrm.LockScreen;
begin
  self.lblCodigodv.Enabled:= False;
  self.edtCodigodv.Enabled:= False;
  self.edtCodigodv.Text:= '';
  self.lblDescripciondv.Enabled:= False;
  self.edtDescripciondv.Enabled:= False;
  self.lblUbicaciondv.Enabled:= False;
  self.edtUbicaciondv.Enabled:= False;
  self.btnDirdv.Enabled:= False;
  self.btnConfirmardv.Visible:= False;
  self.btnLimpiardv.Visible:= False;
  self.btnVolverdv.SetFocus;
end; 
procedure TInstructivosMaterialesAltaFrm.UnLockScreen;
begin
  self.lblCodigodv.Enabled:= True;
  self.edtCodigodv.Enabled:= True;
  self.lblDescripciondv.Enabled:= True;
  self.edtDescripciondv.Enabled:= True;
  self.lblUbicaciondv.Enabled:= True;
  self.edtUbicaciondv.Enabled:= True;
  self.btnDirdv.Enabled:= True;
  self.btnConfirmardv.Visible:= True;
  self.btnLimpiardv.Visible:= True;

end;
procedure TInstructivosMaterialesAltaFrm.btnVolverdvClick(Sender: TObject);
begin
  self.Close;
{  if not self.FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_INSTRUCTIVOSPROD_ALTA);
  end
  else
  begin
    self.UnLockScreen;
    self.FLocked:= False;
  end;
    self.MainForm.Enabled:= True;
    self.MainForm.Enabled:= True;
    self.MainForm.Show;
    Hide;
    self.MainForm:= nil;}
end;

procedure TInstructivosMaterialesAltaFrm.btnLimpiardvClick(Sender: TObject);
begin
  self.edtDescripciondv.Text:= '';
  self.edtUbicaciondv.Text:= '';
  self.edtDescripciondv.SetFocus;
end;
procedure TInstructivosMaterialesAltaFrm.GenerarCodigo;
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
  sSQL:= 'select PLN_CODIGO as CodMax from INSTRUCTIVOSPRODUCCION where PLN_CODIGO like '+QuotedStr('IB9-%');

  Dst:= TADODataset.Create(nil);
  try
    // Obtengo la conexion a la BD
    Dst.Connection:= MSQL.GetConn;
    Dst.CommandText:= sSQL;
    Dst.Open;
    if Dst.Eof then
    Begin
      self.edtCodigodv.Text:= 'IB9-001';
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
     self.edtCodigodv.Text:= 'IB9-0'+IntToStr(iUltimoCodMax+1);
    end;
    Dst.Close;
    MSQL.CloseConn;
  finally
    Dst.Free;
  end;
end;
procedure TInstructivosMaterialesAltaFrm.FormShow(Sender: TObject);
begin
{  if self.PantallaLockeada(SCR_INSTRUCTIVOSPROD_ALTA) then
  begin
    self.LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_INSTRUCTIVOSPROD_ALTA,SCR_INSTRUCTIVOSPROD_ALTA);
    self.FLocked:= False;
  end;}
  self.GenerarCodigo;
end;

procedure TInstructivosMaterialesAltaFrm.btnConfirmardvClick(Sender: TObject);
var
 sSQL:string;
 UsuarioAlta:string;
 Varios: TDVarios;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigodv.Text;
  UsuarioAlta:= TSistema.GetInstance.GetUsuario.Logon;

  sSQL:= 'insert into INSTRUCTIVOSPRODUCCION (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA)'+
         'VALUES ('+QuotedStr(self.edtCodigodv.Text)+','+QuotedStr(self.edtDescripciondv.Text)+','+QuotedStr('PA')+','+QuotedStr(self.edtUbicaciondv.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+')';

  TMotorSQL.GetInstance.OpenConn;

  TMotorSQL.GetInstance.ExecuteSQL(sSQL);
  ShowMessage('El Documento ' +  Varios.CodigoDV + ' se dio de alta satisfactoriamente');

  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
  else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
    sSQL:= 'insert into DOCUMENTOSVARIOS  (PLN_CODIGO,PLN_DESCRIPCION,PLN_ESTADO,PLN_UBICACION,PLN_FECHA,PLN_USUARIO_ALTA,PLN_NRO_REV)'+
           'VALUES ('+ QuotedStr(SELF.edtCodigodv.Text)+','+QuotedStr(SELF.edtDescripciondv.Text)+','+QuotedStr('PA')+','+QuotedStr(SELF.edtUbicaciondv.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr(UsuarioAlta)+','+QuotedStr('0')+')';
    TMotorSql.GetInstance.ExecuteSQL(sSQL);
    if TMotorSql.GetInstance.GetStatus = 0 then
    begin
      TMotorSQL.GetInstance.Commit;
    end
    else
    begin
      TMotorSQL.GetInstance.Rollback;
    end;
      TMotorSQL.GetInstance.CloseConn;

     self.edtCodigodv.Text:= '';
     self.edtDescripciondv.Text:= '';
     self.edtUbicaciondv.Text:= '';
     self.GenerarCodigo;
 end;
procedure TInstructivosMaterialesAltaFrm.btnDirdvClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, self.edtUbicaciondv.Text);
  if sDir <> '' then
     self.edtUbicaciondv.Text:= sDir;
end;
procedure TInstructivosMaterialesAltaFrm.edtDescripciondvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Ingrese una breve descripción del Documento';
end;

procedure TInstructivosMaterialesAltaFrm.edtUbicaciondvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Ingrese la ubicación del archivo con el Documento';
end;

procedure TInstructivosMaterialesAltaFrm.btnDirdvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento';
end;

procedure TInstructivosMaterialesAltaFrm.btnConfirmardvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Da de Alta el Documento en la base de datos';
end;

procedure TInstructivosMaterialesAltaFrm.btnLimpiardvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TInstructivosMaterialesAltaFrm.btnVolverdvEnter(Sender: TObject);
begin
  self.StatusBar1.SimpleText:= 'Regresa a la pantalla anterior';
end;

end.

