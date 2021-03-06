unit UMaterialesSuperarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, UMateriales, UMotorSql, USistema, UPantallaFrm,UMaterialesAltaFrm;

type
  TMaterialesSuperarFrm = class(TPantallaFrm)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    btnBuscar: TButton;
    lblNroRev: TLabel;
    edtNroRev: TEdit;
    lblNroEdic: TLabel;
    edtNroEdic: TEdit;
    lblDescripcion: TLabel;
    edtDescripcion: TEdit;
    lblFechaAlta: TLabel;
    edtFechaAlta: TEdit;
    lblUAlta: TLabel;
    edtUAlta: TEdit;
    lblFechaApr: TLabel;
    edtFechaApr: TEdit;
    lblUApr: TLabel;
    edtUApr: TEdit;
    gbNueva: TGroupBox;
    lblNroRev2: TLabel;
    edtNroRev2: TEdit;
    lblFechaSup2: TLabel;
    edtFechaSup2: TEdit;
    lblDescripcion2: TLabel;
    edtDescripcion2: TEdit;
    btnConfirmar: TButton;
    btnLimpiar: TButton;
    btnVolver: TButton;
    stbMateriales: TStatusBar;
    ADODataSet1: TADODataSet;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure buscarClick(Sender: TObject);
    procedure btnVolverEnter(Sender: TObject);
    procedure btnLimpiarEnter(Sender: TObject);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure edtDescripcion2Enter(Sender: TObject);
    procedure btnBuscarEnter(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  //  procedure FormShow(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);

  private
    // procedure LockScreen;
    // procedure UnLockScreen;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaterialesSuperarFrm: TMaterialesSuperarFrm;

implementation

{$R *.dfm}
{procedure TmaterialesSuperarFrm.LockScreen;
begin
  self.lblCodigo.Enabled:= False;
  self.edtCodigo.Enabled:= False;
  self.lblDescripcion.Enabled:= False;
  self.lblDescripcion2.Enabled:= False;
  self.edtDescripcion2.Enabled:= False;
  self.lblNroRev.Enabled:= False;
  self.lblNroRev2.Enabled:= False;
  self.lblNroEdic.Enabled:= False;
  self.lblFechaAlta.Enabled:= False;
  self.lblFechaApr.Enabled:= False;
  self.lblUAlta.Enabled:= False;
  self.lblUApr.Enabled:= False;
  self.gbNueva.Enabled:= False;
  self.lblFechaSup2.Enabled:= False;
  self.btnBuscar.Visible:= False;
  self.btnConfirmar.Visible:= False;
  self.btnLimpiar.Visible:= False;
  self.btnVolver.SetFocus;
end;
procedure TMaterialesSuperarFrm.UnLockScreen;
begin
  self.lblCodigo.Enabled:= True;
  self.edtCodigo.Enabled:= True;
  self.lblDescripcion.Enabled:= True;
  self.lblDescripcion2.Enabled:= True;
  self.edtDescripcion2.Enabled:= True;
  self.lblNroRev.Enabled:= True;
  self.lblNroRev2.Enabled:= True;
  self.lblNroEdic.Enabled:= True;
  self.lblFechaAlta.Enabled:= True;
  self.lblFechaApr.Enabled:= True;
  self.lblUAlta.Enabled:= True;
  self.lblUApr.Enabled:= True;
  self.gbNueva.Enabled:= True;
  self.lblFechaSup2.Enabled:= True;
  self.btnBuscar.Visible:= True;
  self.btnConfirmar.Visible:= True;
  self.btnLimpiar.Visible:= True;
end;}
procedure TMaterialesSuperarFrm.btnVolverClick(Sender: TObject);
begin
  {if not self.FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_MATERIALES_SUPERAR);
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
procedure TMaterialesSuperarFrm.btnLimpiarClick(Sender: TObject);
begin
  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;

  self.edtCodigo.Text:= '';
  self.edtNroRev.Text:= '';
  self.edtNroEdic.Text:= '';
  self.edtDescripcion.Text:= '';
  self.edtFechaAlta.Text:= '';
  self.edtUAlta.Text:= '';
  self.edtFechaApr.Text:= '';
  self.edtUApr.Text:= '';
  self.Edit1.Text:= '';
  self.Edit2.Text:= '';
  self.edtNroRev2.Text:= '';
  self.edtFechaSup2.Text:= '';
  self.edtDescripcion2.Text:= '';

  btnBuscar.Enabled:= True;
  btnConfirmar.Enabled:= False;
  edtCodigo.SetFocus;
end;

procedure TMaterialesSuperarFrm.buscarClick(Sender: TObject);
var
 sSQL: string;
 Materiales: TMateriales;
begin
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clRed;
    showMessage ('Debe ingresar el c�digo correspondiente a la Lista de Materiales que desea superar');
    self.edtCodigo.Color:= clWindow;
    self.edtCodigo.SetFocus;
  end
  else
  begin
    self.btnConfirmar.Enabled:= True;
    self.edtCodigo.Text:= UpperCase(self.edtCodigo.Text);
    Materiales:= TMateriales.create;
    Materiales.Codigol:= self.edtCodigo.Text;
    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
    TMotorSql.GetInstance.OpenConn;
    Materiales.UsuarioCreacionl:= TSistema.GetInstance.GetUsuario.Logon;
    Materiales.FechaCreacionl:= DateToStr(Date);
    sSQL:= 'select PLN_CODIGO ' +
           ', PLN_DESCRIPCION ' +
           ', PLN_NRO_REV ' +
           ', PLN_NRO_EDIC ' +
           ', PLN_FECHA ' +
           ', PLN_USUARIO_ALTA ' +
           ', PLN_USUARIO_APR ' +
           ', PLN_FECHA_APR ' +
           ', PLN_USUARIO_REC ' +
           ', PLN_FECHA_REC ' +
           ', PLN_UBICACION ' +
           ', USUARIO_CREACION ' +
           ', FECHA_CREACION ' +
           ', USUARIO_MODIF ' +
           ', FECHA_MODIF ' +
            ' from MATERIALES ' +
            ' where PLN_CODIGO = ' + QuotedStr(self.edtCodigo.Text) +
            ' and PLN_ESTADO in (''AC'',''PR'')';
    self.ADODataSet1.CommandText:= sSQL;
    self.ADODataSet1.Open;
    if not(self.ADODataSet1.Eof) then
    begin
      self.edtCodigo.Enabled:= false;
      self.edtNroRev.Enabled:= false;
      self.edtNroEdic.Enabled:= false;
      self.edtDescripcion.Enabled:= False;
      self.edtFechaAlta.Enabled:= false;
      self.edtUAlta.Enabled:= False;
      self.edtUApr.Enabled:= False;
      self.edtFechaApr.Enabled:= False;
      self.edtNroRev2.Enabled:= False;
      self.edtFechaSup2.Enabled:= False;
      self.Edit1.Enabled:= False;
      self.Edit2.Enabled:= False;

      Materiales.Codigol:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
      Materiales.Revisionl:= self.ADODataSet1.fieldByName('PLN_NRO_REV').AsInteger;
      Materiales.Edicionl:= self.ADODataSet1.fieldByNAme('PLN_NRO_EDIC').AsInteger;
      Materiales.Descripcionl:= self.ADODataSet1.fieldByName('PLN_DESCRIPCION').AsString;
      Materiales.Fechal:= self.ADODataSet1.fieldByName('PLN_FECHA').AsString;
      Materiales.UsuarioAltal:= Self.ADODataSet1.FieldByNAme('PLN_USUARIO_ALTA').AsString;
      Materiales.FechaAprobacionl:= self.ADODataSet1.fieldByName('PLN_FECHA_APR').AsString;
      Materiales.UsuarioAprobacionl:= self.ADODataSet1.fieldByName('PLN_USUARIO_APR').AsString;
      Materiales.UsuarioCreacionl:= self.ADODataSet1.fieldByName('USUARIO_CREACION').AsString;
      Materiales.FechaCreacionl:= self.ADODataSet1.FIeldByName('FECHA_CREACION').AsString;
      Materiales.FechaRecepcion:= self.ADODataSet1.fieldByName('PLN_FECHA_REC').AsString;
      Materiales.UsuarioRecepcionl:= self.ADODataSet1.fieldByName('PLN_USUARIO_REC').AsString;

      self.edtDescripcion.Text:= Materiales.Descripcionl;
      self.edtFechaAlta.Text:= Materiales.Fechal;
      self.edtUAlta.Text:= Materiales.UsuarioAltal;
      self.edtFechaApr.Text:= Materiales.FechaAprobacionl;
      self.edtUApr.Text:= Materiales.UsuarioAprobacionl;
      self.edtNroRev.Text:= IntToStr(Materiales.Revisionl);
      self.edtNroEdic.Text:= IntToStr(Materiales.Edicionl);
      self.edtNroRev2.Text:= IntToStr(Materiales.Revisionl + 1 );
      self.edtNroRev2.Enabled:= False;
      self.edtNroRev2.TabStop:= True;
      self.edtDescripcion2.Enabled:= True;
      self.edtDescripcion2.TabStop:= True;
      self.edtDescripcion2.Text:= Materiales.Descripcionl;
      self.edtDescripcion2.SetFocus;
      self.edtFechaSup2.Text:= DateToStr(Date);
      self.Edit1.Text:= Materiales.FechaRecepcion;
      self.Edit2.Text:= Materiales.UsuarioRecepcionl;

      self.ADODataSet1.Open;
      self.ADODataSet1.Close;
    end
    else
    begin
      self.edtCodigo.Color:= clRed;
      showMessage('El c�digo que ingreso no corresponde a una Lista de Materiales en condiciones de ser superada');
      self.edtCodigo.Color:= clwindow;
      self.edtCodigo.SetFocus;
    end;

      TMotorSql.GetInstance.CloseConn;
  end;
end;
procedure TMaterialesSuperarFrm.btnVolverEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Regresa a la pantalla anterior';

end;

procedure TMaterialesSuperarFrm.btnLimpiarEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Vacia todos los casilleros de la pantalla';
end;

procedure TMaterialesSuperarFrm.btnConfirmarEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Supera la Lista de Materiales';
end;

procedure TMaterialesSuperarFrm.edtDescripcion2Enter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Ingrese la descripci�n de la nueva revisi�n de la Lista de Materiales';
end;

procedure TMaterialesSuperarFrm.btnBuscarEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Busca el c�digo de la Lista de Materiales a Superar';
end;

procedure TMaterialesSuperarFrm.btnConfirmarClick(Sender: TObject);
var
 Materiales: TMateriales;
 sSQL: string;
 Usuario: string;
 FechaC : string;
 Varios: TMaterialesAltaFrm;
 HOLA: string;
begin
  self.ADODataSet1.Close;
  self.ADODataSet1.Connection:= TMotorSQl.getinstance.GetConn;
  TMotorSql.GetInstance.OpenConn;

  sSQL:= 'Select PLN_UBICACION '+
         ' FROM MATERIALES ' +
         ' where PLN_CODIGO = ' + QuotedStr(SELF.edtCodigo.Text);

  SELF.ADODataSet1.CommandText:= Ssql;
  SELF.ADODataSet1.Open;


 HOLA:= self.ADODataSet1.fieldByName('PLN_UBICACION').AsString;
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clRed;
    ShowMessage('Debe ingresar el c�digo correspondiente a la Lista de Materiales que desea superar');
    self.edtCodigo.Color:= clWindow;
    self.edtCodigo.SetFocus;
  end;
    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.getInstance.GetConn;
    TmotorSql.GetInstance.OpenConn;
    Usuario:= TSistema.getInstance.getUsuario.Logon;
    FechaC := DateToStr(Date);
    sSql:= 'update MATERIALES ' +
           'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripcion2.Text) +
           ', PLN_NRO_REV = ' + QuotedStr(self.edtNroRev2.Text) +
           ', PLN_FECHA = ' +  QuotedStr(DateToStr(Date)) +
           ', PLN_ESTADO = ' + QuotedStr('PA')+
           ', FECHA_CREACION = ' + QuotedStr(FechaC) +
           ', USUARIO_CREACION = ' +  QuotedStr(Usuario)+
           ', PLN_USUARIO_APR = ' + QuotedStr('') +
           ', PLN_FECHA_APR = ' + QuotedStr('') +
           ', PLN_USUARIO_REC = ' + QuotedStr('') +
           ', PLN_FECHA_REC = ' + QuotedStr('') +
           ', PLN_USUARIO_ALTA = ' + QuotedStr(Usuario) +
           ', PLN_SUPERADO = ' +QuotedStr('NS') +
           'where PLN_CODIGO  = ' +  QuotedStr(self.edtCodigo.Text);

    TMotorSql.GetInstance.ExecuteSQL(sSQL);
    if TMotorSQL.GetInstance.GetStatus = 0 then
    begin
      TMotorSQL.GetInstance.Commit;
    end
    else
    Begin
      TMotorSQL.GetInstance.Rollback;
    end;
    sSQL:= 'insert into HISTORICOMATERIALES (PLN_FECHA,PLN_CODIGO,PLN_DESCRIPCION,PLN_NRO_REV,PLN_ESTADO,PLN_USUARIO_ALTA,PLN_FECHA_APR,PLN_USUARIO_APR,PLN_UBICACION,PLN_USUARIO_REC,PLN_FECHA_REC,PLN_SUPERADO)'+
           ' VALUES ('+QuotedStr(self.edtFechaAlta.Text)+','+QuotedStr(self.edtCodigo.Text)+','+QuotedStr(self.edtDescripcion.Text)+','+QuotedStr(self.edtNroRev.Text)+','+QuotedStr('AC')+','+QuotedStr(self.edtUAlta.Text)+','+QuotedStr(self.edtFechaApr.Text)+','+QuotedStr(self.edtUApr.Text)+','+QuotedStr(HOLA)+','+QuotedStr(self.Edit2.Text)+','+QuotedStr(self.Edit1.Text)+','+QuotedStr('S')+')';
    TMotorSql.GetInstance.ExecuteSQL(sSQL);
     if TMotorSQL.GetInstance.GetStatus = 0 then
    begin
     TMotorSQL.GetInstance.Commit;
    end
    else
    Begin
     TMotorSQL.GetInstance.Rollback;
    end;

    ShowMessage('La Lista de Materiales ' + ' se super� satisfactoriamente');

     self.edtCodigo.Text:= '';
     self.edtNroRev.Text:= '';
     self.edtNroEdic.Text:= '';
     self.edtDescripcion.Text:= '';
     self.edtFechaAlta.Text:= '';
     self.edtUAlta.Text:= '';
     self.edtFechaApr.Text:= '';
     self.edtUApr.Text:= '';
     self.edtNroRev2.Text:= '';
     self.edtDescripcion2.Text:= '';
     self.edtFechaSup2.Text:= '';
     self.Edit1.Text:= '';
     self.Edit2.Text:= '';
     self.btnLimpiarClick(Sender);
     TMotorSQL.GetInstance.CloseConn;
end;

procedure TMaterialesSuperarFrm.edtCodigoEnter(Sender: TObject);
begin
  self.stbMateriales.SimpleText:= 'Ingrese el c�digo de la Lista de Materiales a superar';
end;

end.
