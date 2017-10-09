unit UInstructivosProdModificarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UDVarios, USistema, UMotorSql,UUtiles,ShlObj,UPantallaFrm,
  DB, ADODB;

type
  TInstructivosProduccionModificarFrm = class(TPantallaFrm)
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
    StbVarios: TStatusBar;
    btnBuscar: TButton;
    ADODataSet1: TADODataSet;
    procedure btnLimpiardvClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnVolverdvClick(Sender: TObject);
    procedure btnConfirmardvClick(Sender: TObject);
    procedure btnDirdvClick(Sender: TObject);
    procedure edtCodigodvEnter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure edtUbicaciondvEnter(Sender: TObject);
    procedure btnDirdvEnter(Sender: TObject);
    procedure btnLimpiardvEnter(Sender: TObject);
    procedure btnConfirmardvEnter(Sender: TObject);
    //procedure FormShow(Sender: TObject);
  private
    procedure LockScreen;
    procedure UnLockscreen;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InstructivosProduccionModificarFrm: TInstructivosProduccionModificarFrm;

implementation

{$R *.dfm}
procedure TInstructivosProduccionModificarFrm.LockScreen;
begin
  self.lblCodigodv.Enabled:= False;
  self.edtCodigodv.Enabled:= False;
  self.edtCodigodv.Text:= '';
  self.lblDescripciondv.Enabled:= False;
  self.edtDescripciondv.Enabled:= False;
  self.edtDescripciondv.Text:= '';
  self.lblUbicaciondv.Enabled:= False;
  self.edtUbicaciondv.Enabled:= False;
  self.btnDirdv.Enabled:= False;
  self.btnBuscar.Visible:= False;
  self.btnLimpiardv.Visible:= False;
  self.btnVolverdv.SetFocus;
  self.btnConfirmardv.Visible:= False;

end;
procedure TInstructivosProduccionModificarFrm.UnLockscreen;
begin
  self.lblCodigodv.Enabled:= True;
  self.edtCodigodv.Enabled:= True;
  self.lblDescripciondv.Enabled:= True;
  self.edtDescripciondv.Enabled:= True;
  self.lblUbicaciondv.Enabled:= True;
  self.btnDirdv.Enabled:= True;
  self.btnBuscar.Visible:= True;
  self.btnConfirmardv.Visible:= True;
  self.btnLimpiardv.Visible:= True;
end;
procedure TInstructivosProduccionModificarFrm.btnLimpiardvClick(Sender: TObject);
begin
  self.edtCodigodv.Enabled:= True;
  self.edtCodigodv.Text:= '';
  self.btnBuscar.Enabled:= True;
  self.edtDescripciondv.Enabled:= False;
  self.edtDescripciondv.Text:= '';
  self.edtDescripciondv.TabStop:= False;
  self.edtUbicaciondv.Text:= '';
  self.edtUbicaciondv.TabStop:= False;
  self.edtUbicaciondv.Enabled:= False;
  self.btnDirdv.Enabled:= False;
  self.btnConfirmardv.Enabled:= False;
  self.edtCodigodv.SetFocus;
end;

procedure TInstructivosProduccionModificarFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 Ret: boolean;
begin
  if self.edtCodigodv.Text = '' then
  begin
    self.edtCodigodv.Color:= clred;
    ShowMessage('Debe ingresar el código correspondiente al Documento que desea Modificar');
    self.edtCodigodv.Color:= clWindow;
    self.edtCodigodv.SetFocus;
  end
  else
  begin
    self.edtCodigodv.Text:= UpperCase(self.edtCodigodv.Text);
    Varios:= TDVarios.Create;
    Varios.CodigoDV:= self.edtCodigodv.Text;
    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
    TMotorSql.GetInstance.OpenConn;

    sSQL:= 'select PLN_CODIGO ' +
           ', PLN_DESCRIPCION ' +
           ', PLN_UBICACION ' +
           ' from INSTRUCTIVOSPRODUCCION' +
           ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigodv.Text);
    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Open;

    if (Self.ADODataSet1.Eof) then
    Begin
      self.edtCodigodv.Color:= clRed;
      showMessage('El Código que ingresó no corresponde a ningun Documento en la base de datos');
      self.edtCodigodv.Color:= clWindow;
      self.edtCodigodv.SetFocus;
    end
    else
    begin
      Self.edtDescripciondv.Enabled := True;
      Self.edtUbicaciondv.Enabled := True;
      Self.btnConfirmardv.Enabled := True;
      Varios.Codigodv:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
      Varios.Descripciondv:= self.ADODataSet1.fieldByName('PLN_DESCRIPCION').AsString;
      Varios.Ubicaciondv:= self.ADODataSet1.fieldByName('PLN_UBICACION').AsString;

      self.edtDescripciondv.Text:= Varios.DescripcionDV;
      self.edtUbicaciondv.Text:= Varios.UbicacionDv;
      self.edtDescripciondv.SetFocus;
      self.ADODataSet1.Open;
      self.ADODataSet1.Close;
      edtCodigodv.Color:= clWindow;
    end;
     TMotorSql.GetInstance.CloseConn;
   end;
 end;

procedure TInstructivosProduccionModificarFrm.btnVolverdvClick(Sender: TObject);
begin
{  if not self.FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_INSTRUCTIVOSPROD_MODIF);
  end
  else
  begin
    self.UnLockscreen;
    self.FLocked:= False;
  end;
    self.MainForm.Enabled:= True;
    self.MainForm.Show;
    Hide;
    self.MainForm:= nil;}
   self.Close;
end;
procedure TInstructivosProduccionModificarFrm.btnConfirmardvClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
 UsuarioV: string;
begin
  Varios:= TDVarios.Create;
  Varios.CodigoDV:= self.edtCodigodv.Text;
  Varios.DescripcionDV:= self.edtDescripciondv.Text;
  Varios.UbicacionDv:= self.edtUbicaciondv.Text;
  UsuarioV:= TSistema.getInstance.getUsuario.Logon;
  self.ADODataSet1.close;
  self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'update INSTRUCTIVOSPRODUCCION ' +
         'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripciondv.Text) +
         ', PLN_UBICACION =  '  +  QuotedStr(self.edtUbicaciondv.Text) +
         ', USUARIO_MODIF = ' + QuotedStr(UsuarioV) +
         ', FECHA_MODIF = ' + QuotedStr(DateToStr(Date)) +
         'where PLN_CODIGO =  ' +  QuotedStr(self.edtCodigodv.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  if TMotorSQL.GetInstance.GetStatus = 0 then
  begin
    TMotorSQL.GetInstance.Commit;
  end
  else
  Begin
    TMotorSQL.GetInstance.Rollback;
  end;
    sSQL:= 'update DOCUMENTOSVARIOS ' +
           'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripciondv.Text)+
           ', PLN_UBICACION = ' + QuotedStr(self.edtUbicaciondv.Text) +
           ', USUARIO_MODIF = ' + QuotedStr(UsuarioV) +
           ', FECHA_MODIF = ' + QuotedStr(DateToStr(Date)) +
           'where PLN_CODIGO = ' + QuotedStr(self.edtCodigodv.Text);

    TMotorSql.GetInstance.ExecuteSQL(sSQL);
    if TMotorSQL.GetInstance.GetStatus = 0 then
    begin
      TMotorSQL.GetInstance.Commit;
    end
    else
    begin
      TMotorSQl.GetInstance.Rollback;
    end;
      ShowMessage('El Documento ' + Varios.CodigoDV + ' se modifico satisfactoriamente');
      self.edtCodigodv.Text:= '';
      self.edtDescripciondv.Text:= '';
      self.edtUbicaciondv.Text:= '';

      TMotorSql.GetInstance.CloseConn;
end;
procedure TInstructivosProduccionModificarFrm.btnDirdvClick(Sender: TObject);
var
 sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra el Documento:',
      CSIDL_NETWORK, self.edtUbicaciondv.Text);
  if sDir <> '' then
    self.edtUbicaciondv.Text:= sDir;

end;
{procedure TInstructivosProduccionModificarFrm.FormShow(Sender: TObject);
begin
  if self.PantallaLockeada(SCR_INSTRUCTIVOSPROD_MODIF) then
   begin
    self.LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_INSTRUCTIVOSPROD_MODIF,SCR_INSTRUCTIVOSPROD_MODIF);
    self.FLocked:= False;
    self.btnConfirmardv.Enabled:= False;
end;
end;}

procedure TInstructivosProduccionModificarFrm.edtCodigodvEnter(Sender: TObject);
begin
  self.StbVarios.SimpleText:= 'Ingrese el código del Documento a modificar'
end;

procedure TInstructivosProduccionModificarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.StbVarios.SimpleText:= 'Busca el código del Documento ingresado en la base de datos';
end;

procedure TInstructivosProduccionModificarFrm.edtUbicaciondvEnter(Sender: TObject);
begin
  self.StbVarios.SimpleText:= 'Ingrese la ubicación del archivo con el Documento';
end;

procedure TInstructivosProduccionModificarFrm.btnDirdvEnter(Sender: TObject);
begin
  self.StbVarios.SimpleText:= 'Seleccione la carpeta donde se encuentra el Documento';
end;

procedure TInstructivosProduccionModificarFrm.btnLimpiardvEnter(Sender: TObject);
begin
  self.StbVarios.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TInstructivosProduccionModificarFrm.btnConfirmardvEnter(Sender: Tobject);
begin
  self.StbVarios.SimpleText:= 'Modifica el Documento especificado';
end;

end.
