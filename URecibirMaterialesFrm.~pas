unit URecibirMaterialesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB,UUtiles,ShlObj, UMateriales, USistema, UMotorSql,UPantallaFrm;

type
  TRecibirMaterialesFrm = class(TPantallaFrm)
    lblCodigol: TLabel;
    edtcodigol: TEdit;
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
    procedure edtcodigolEnter(Sender: TObject);
    procedure btnConfirmarlEnter(Sender: TObject);
    procedure btnLimpiarlEnter(Sender: TObject);
    procedure btnVolverlEnter(Sender: TObject);
    procedure btnBuscarlEnter(Sender: TObject);
    procedure edtUbicacionlEnter(Sender: TObject);
    procedure btnDirlEnter(Sender: TObject);
    procedure btnVolverlClick(Sender: TObject);
    procedure btnLimpiarlClick(Sender: TObject);
    procedure btnDirlClick(Sender: TObject);
    procedure btnBuscarlClick(Sender: TObject);
    procedure btnConfirmarlClick(Sender: TObject);
   // procedure FormShow(Sender: TObject);

  private
    //procedure LockScreen;
    //procedure UnLockScreen;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecibirMaterialesFrm: TRecibirMaterialesFrm;

implementation

{$R *.dfm}
{procedure TRecibirMaterialesFrm.LockScreen;
begin
  self.lblCodigol.Enabled:= False;
  self.edtcodigol.Enabled:= False;
  self.edtcodigol.Text:= '';
  self.lblDescripcionl.Enabled:= False;
  self.edtDescripcionl.Enabled:= False;
  self.edtDescripcionl.Text:= '';
  self.lblUbicacionl.Enabled:= False;
  self.edtUbicacionl.Enabled:= False;
  self.edtUbicacionl.Text:= '';
  self.btnDirl.Enabled:= False;
  self.btnBuscarl.Visible:= False;
  self.btnLimpiarl.Visible:= False;
  self.btnConfirmarl.Visible:= False;
  self.btnVolverl.SetFocus;
end;
procedure TRecibirMaterialesFrm.UnLockScreen;
begin
  self.lblCodigol.Enabled:= True;
  self.edtcodigol.Enabled:= True;
  self.lblDescripcionl.Enabled:= True;
  self.edtDescripcionl.Enabled:= True;
  self.lblUbicacionl.Enabled:= True;
  self.edtUbicacionl.Enabled:= True;
  self.btnDirl.Enabled:= True;
  self.btnBuscarl.Visible:= True;
  self.btnConfirmarl.Visible:= True;
  self.btnLimpiarl.Visible:= True;
end;}
procedure TRecibirMaterialesFrm.edtcodigolEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Ingrese el código de la Lista de Materiales a Recibir';
end;

procedure TRecibirMaterialesFrm.btnConfirmarlEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Recibe la Lista de Materiales especificada';
end;

procedure TRecibirMaterialesFrm.btnLimpiarlEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TRecibirMaterialesFrm.btnVolverlEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Regresa a la pantalla anterior';
end;

procedure TRecibirMaterialesFrm.btnBuscarlEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Busca el codigo de la Lista de Materiales ingresado en la base de datos';
end;

procedure TRecibirMaterialesFrm.edtUbicacionlEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Ingrese la ubicacion del archivo con la Lista de Materiales';
end;

procedure TRecibirMaterialesFrm.btnDirlEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Seleccione la carpeta donde se encuentra la Lista de Materiales';
end;
procedure TRecibirMaterialesFrm.btnVolverlClick(Sender: TObject);
begin
 { if not self.FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_MATERIALES_RECIBIR);
  end
  else
  begin
    self.UnLockScreen;
    self.FLocked:= False;
  end;
    self.MainForm.Enabled:= True;
    self.MainForm.Show;
    Hide;
    self.MainForm:= nil;
  end;}
  self.Close;
end;
procedure TRecibirMaterialesFrm.btnLimpiarlClick(Sender: TObject);
begin
  self.edtcodigol.Enabled:= true;
  self.btnBuscarl.Enabled:= true;
  self.edtDescripcionl.Enabled:= false;
  self.edtDescripcionl.Text:= '';
  self.edtDescripcionl.TabStop:= false;
  self.edtUbicacionl.Text:= '';
  self.edtUbicacionl.TabStop:= false;
  self.edtUbicacionl.Enabled:= false;
  self.btnDirl.Enabled:= false;
  self.btnConfirmarl.Enabled:= false;
  self.edtcodigol.SetFocus;
end;

procedure TRecibirMaterialesFrm.btnDirlClick(Sender: TObject);
var
  sDir: string;
begin
  sDir:= BrowseForFolder('Seleccione la carpeta donde se encuentra la Lista de Materiales:',
      CSIDL_DRIVES, edtUbicacionl.Text);
  if sDir <> '' then
    edtUbicacionl.Text:= sDir;
end;

procedure TRecibirMaterialesFrm.btnBuscarlClick(Sender: TObject);
var
 sSql: string;
 Materiales: TMateriales;
begin
 if self.edtcodigol.Text = '' then
  begin
    self.edtcodigol.Color:= clred;
    showMessage('Debe ingresar el código correspondiente a la Lista de Materiales que desea Recibir');
    self.edtcodigol.Color:= clwindow;
    self.edtcodigol.SetFocus;
  end
  else
  begin
    self.edtcodigol.Text:= UpperCase(self.edtcodigol.Text);
    Materiales:= TMateriales.Create;
    Materiales.Codigol:= self.edtcodigol.Text;

    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.GetInstance.GetConn;
    TMotorSql.GetInstance.OpenConn;

    sSql:= 'select PLN_CODIGO ' +
            ',PLN_DESCRIPCION ' +
            ',PLN_ESTADO ' +
            ',PLN_UBICACION ' +
            'from MATERIALES ' +
            'where PLN_CODIGO = ' + QuotedStr(self.edtcodigol.Text) +
            ' and PLN_ESTADO = ''PR''';

    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Open;
    if self.ADODataSet1.Eof then
    begin
      self.edtcodigol.Color:= clred;
      showMessage('El Código que ingresó no corresponde a ninguna Lista de Materiales en la base de datos');
      self.edtcodigol.Color:= clwindow;
      self.edtcodigol.SetFocus;
    end
    else
    begin
      self.edtDescripcionl.Enabled:= true;
      self.edtUbicacionl.Enabled:= true;
      self.btnConfirmarl.Enabled:= true;
      Materiales.Codigol:= self.ADODataSet1.fieldbyname('PLN_CODIGO').AsString;
      Materiales.Descripcionl:= self.ADODataSet1.fieldbyname('PLN_DESCRIPCION').AsString;
      Materiales.Ubicacionl:= self.ADODataSet1.fieldbyname('PLN_UBICACION').AsString;

      self.edtDescripcionl.Text:= Materiales.Descripcionl;
      self.edtUbicacionl.Text:= Materiales.Ubicacionl;

      self.ADODataSet1.Open;
      self.ADODataSet1.Close;

    end;
      self.edtcodigol.Enabled:= true;
      self.btnConfirmarl.Enabled:= true;
      self.edtDescripcionl.Enabled:= false;
      self.edtUbicacionl.Enabled:= false;
      self.btnBuscarl.Enabled:= true;

      TMotorSql.GetInstance.CloseConn;
  end;
 end;

procedure TRecibirMaterialesFrm.btnConfirmarlClick(Sender: TObject);
var
 sSQL: string;
 Materiales: TMateriales;
 usuario: string;
begin
  usuario:= TSistema.getInstance.getUsuario.Logon;
  Materiales:= TMateriales.Create;
  Materiales.Codigol:= self.edtcodigol.Text;

  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TmotorSql.getInstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'update MATERIALES ' +
          'set PLN_USUARIO_REC = ' + QuotedStr(usuario) +
          ', PLN_FECHA_REC = ' + QuotedStr(DateToStr(Date)) +
          ', PLN_ESTADO = ' + QuotedStr('AC') +
          ' where PLN_CODIGO = ' + QuotedStr(self.edtcodigol.Text);

  TMotorSql.GetInstance.ExecuteSQL(sSQL);
  ShowMessage('La Lista de Materiales ' + Materiales.Codigol + ' se recibió satisfactoriamente');
  if TMotorSql.GetInstance.GetStatus = 0 then
  begin
    TMotorSql.GetInstance.Commit;
  end
  else
  begin
    TMotorSql.GetInstance.Rollback;
  end;
    self.edtcodigol.Text:= '';
    self.edtDescripcionl.Text:= '';
    self.edtUbicacionl.Text:= '';

    TMotorSql.GetInstance.CloseConn;
 end;

{procedure TRecibirMaterialesFrm.FormShow(Sender: TObject);
begin
  if self.PantallaLockeada(SCR_MATERIALES_RECIBIR) then
  begin
    self.LockScreen;
  end
  else
  begin
    TSistema.GetInstance.LockScreen(SCR_MATERIALES_RECIBIR,SCR_MATERIALES_RECIBIR);
    self.FLocked:= False;
  end;
   self.btnConfirmarl.Enabled:= False;
end;}

end.
