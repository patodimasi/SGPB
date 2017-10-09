unit UInstructivosProdSuperarFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB,UDVarios, USistema, UMotorSql;

type
  TSuperarInstructivosProdFrm = class(TForm)
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
    stbInstructivosProd: TStatusBar;
    ADODataSet1: TADODataSet;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    procedure btnVolverClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SuperarInstructivosProdFrm: TSuperarInstructivosProdFrm;

implementation

{$R *.dfm}

procedure TSuperarInstructivosProdFrm.btnVolverClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSuperarInstructivosProdFrm.btnLimpiarClick(Sender: TObject);
begin
  self.lblCodigo.Enabled:= True;
  self.edtCodigo.Enabled:= True;
  self.edtCodigo.Text:= '';
  self.edtNroRev.Text:= '';
  self.edtNroEdic.Text:= '';
  self.edtDescripcion.Text:= '';
  self.edtFechaAlta.Text:= '';
  self.edtUAlta.Text:= '';
  self.edtFechaApr.Text:= '';
  self.edtUApr.Text:= '';
  self.edtNroRev2.Text:= '';
  self.edtFechaSup2.Text:= '';
  self.edtDescripcion2.Text:= '';
  self.btnBuscar.Enabled:= True;
  self.btnConfirmar.Enabled:= False;
  self.edtCodigo.SetFocus;
end;

procedure TSuperarInstructivosProdFrm.btnBuscarClick(Sender: TObject);
var
 sSQL: string;
 Varios: TDVarios;
begin
 if self.edtCodigo.Text = '' then
 begin
   self.edtCodigo.Color:= clRed;
   showMessage ('Debe ingresar el código correspondiente al Documento que desea superar');
   self.edtCodigo.Color:= clWindow;
   self.edtCodigo.SetFocus;
 end
 else
 begin
   self.btnConfirmar.Enabled:= True;
   self.edtCodigo.Text:= UpperCase(self.edtCodigo.Text);
   Varios:= TDVarios.Create;
   Varios.CodigoDV:= self.edtCodigo.Text;
   self.ADODataSet1.Close;
   self.ADODataSet1.Connection:= TMotorSql.getInstance().GetConn;
   TMotorSql.GetInstance.OpenConn;
   Varios.UsuarioCreacionDV:= TSistema.getInstance.getUsuario.Logon;
   Varios.FechaCreacionDV:= DateToStr(Date);
   sSQL:= 'select PLN_CODIGO ' +
          ', PLN_DESCRIPCION ' +
          ', PLN_NRO_REV ' +
          ', PLN_NRO_EDIC ' +
          ', PLN_FECHA ' +
          ', PLN_USUARIO_ALTA ' +
          ', PLN_USUARIO_APR ' +
          ', PLN_FECHA_APR ' +
          ', PLN_USUARIO_REC ' +
          ', PLN_UBICACION ' +
          ', USUARIO_CREACION ' +
          ', FECHA_CREACION ' +
          ', USUARIO_MODIF ' +
          ', FECHA_MODIF ' +
          ', PLN_USUARIO_REC' +
          ', PLN_FECHA_REC ' +
          ' from INSTRUCTIVOSPRODUCCION ' +
          ' where PLN_CODIGO like ' + QuotedStr(self.edtCodigo.Text + '%') +
          ' and PLN_ESTADO in (''AC'',''PR'')';
   self.ADODataSet1.CommandText:= sSQL;
   self.ADODataSet1.Open;
   if not(self.ADODataSet1.Eof) then
   begin
     self.edtCodigo.Enabled:= False;
     self.edtNroRev.Enabled:= False;
     self.edtNroEdic.Enabled:= False;
     self.edtDescripcion.Enabled:= False;
     self.edtFechaAlta.Enabled:= False;
     self.edtUAlta.Enabled:= False;
     self.edtUApr.Enabled:= False;
     self.edtFechaApr.Enabled:= False;
     self.edtNroRev2.Enabled:= False;
     self.edtFechaSup2.Enabled:= False;
     self.Edit1.Enabled:= false;
     self.Edit2.Enabled:= false;

     Varios.CodigoDV:= self.ADODataSet1.fieldByName('PLN_CODIGO').AsString;
     Varios.RevisionDV:= self.ADODataSet1.fieldByName('PLN_NRO_REV').AsInteger;
     Varios.EdicionDV:= self.ADODataSet1.fieldByName('PLN_NRO_REV').AsInteger;
     Varios.DescripcionDV:= self.ADODataSet1.fieldByName('PLN_DESCRIPCION').AsString;
     Varios.FechaDV:= self.ADODataSet1.fieldByName('PLN_FECHA').AsString;
     Varios.UsuarioAltaDV:= self.ADODataSet1.fieldByName('PLN_USUARIO_ALTA').AsString;
     Varios.FechaAprobacionDV:= self.ADODataSet1.fieldByName('PLN_FECHA_APR').AsString;
     Varios.UsuarioAprobacionDv:= self.ADODataSet1.fieldByName('PLN_USUARIO_APR').AsString;
     Varios.UsuarioCreacionDV:= self.ADODataSet1.fieldByName('USUARIO_CREACION').AsString;
     Varios.FechaCreacionDV:= self.ADODataSet1.fieldByName('FECHA_CREACION').AsString;
     Varios.UsuarioRecepcionDV:= self.ADODataSet1.fieldByName('PLN_USUARIO_REC').AsString;
     Varios.FechaRecepcionDV:= self.ADODataSet1.fieldByNAme('PLN_FECHA_REC').AsString;

     self.edtDescripcion.Text:= Varios.DescripcionDV;
     self.edtFechaAlta.Text:= Varios.FechaDV;
     self.edtUAlta.Text:= Varios.UsuarioAltaDV;
     self.edtFechaApr.Text:= Varios.FechaAprobacionDV;
     self.edtUApr.Text:= Varios.UsuarioAprobacionDv;
     self.edtNroRev.Text:= IntToStr(Varios.RevisionDV);
     self.edtNroEdic.Text:= IntToStr(Varios.EdicionDV);
     self.edtNroRev2.Text:= IntToStr(Varios.RevisionDV + 1 );
     self.edtNroRev2.Enabled:= False;
     self.edtNroRev2.TabStop:= True;
     self.edtDescripcion2.Enabled:= True;
     self.edtDescripcion2.TabStop:= True;
     self.edtDescripcion2.Text:= Varios.DescripcionDV;
     self.edtDescripcion2.SetFocus;
     self.edtFechaSup2.Text:= DateToStr(Date);
     self.Edit1.Text:= Varios.FechaRecepcionDV;
     self.Edit2.Text:= Varios.UsuarioRecepcionDV;

     self.ADODataSet1.Open;
     self.ADODataSet1.Close;
  end
  else
  begin
    self.edtCodigo.Color:= clRed;
    showMessage('El código que ingreso no corresponde ningun Documento en condiciones de ser superado');
    self.edtCodigo.Color:= clwindow;
    self.edtCodigo.SetFocus;
  end;

    TMotorSql.GetInstance.CloseConn;
 end;
end;

procedure TSuperarInstructivosProdFrm.btnConfirmarClick(Sender: TObject);
var
 Varios: TDVarios;
 sSQL: string;
 Usuario: string;
 FechaC : string;
begin
  if self.edtCodigo.Text = '' then
  begin
    self.edtCodigo.Color:= clRed;
    ShowMessage('Debe ingresar el código correspondiente al Documento que desea superar');
    self.edtCodigo.Color:= clWindow;
    self.edtCodigo.SetFocus;
  end;
    self.ADODataSet1.Close;
    self.ADODataSet1.Connection:= TMotorSql.getInstance.GetConn;
    TmotorSql.GetInstance.OpenConn;
    Usuario:= TSistema.getInstance.getUsuario.Logon;
    FechaC := DateToStr(Date);
    {sSql:= 'insert INSTRUCTIVOSPRODUCCION ' +
           'set PLN_DESCRIPCION = ' + QuotedStr(self.edtDescripcion2.Text) +
           ', PLN_NRO_REV = ' + QuotedStr(self.edtNroRev2.Text) +
           ', PLN_FECHA = ' +  QuotedStr(DateToStr(Date)) +
           ', PLN_ESTADO = ' + QuotedStr('PA')+
           ', FECHA_CREACION = ' + QuotedStr(FechaC) +
           ', USUARIO_CREACION = ' +  QuotedStr(Usuario)+
           ', PLN_USUARIO_APR = ' +  QuotedStr('') +
           ', PLN_FECHA_APR = ' + QuotedStr('') +
           ', PLN_USUARIO_REC = ' + QuotedStr('') +
           ', PLN_FECHA_REC = ' + QuotedStr('') +
           'where PLN_CODIGO  = ' +  QuotedStr(self.edtCodigo.Text);  }
   sSQL:= 'insert into INSTRUCTIVOSPRODUCCION (PLN_CODIGO,PLN_DESCRIPCION,PLN_NRO_REV,PLN_FECHA,PLN_ESTADO,PLN_USUARIO_ALTA)'+
           ' VALUES ('+QuotedStr(self.edtCodigo.Text)+','+QuotedStr(self.edtDescripcion2.Text)+','+QuotedStr(self.edtNroRev2.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr('PA')+','+QuotedStr(Usuario)+')';
                                                 
    TMotorSql.GetInstance.OpenConn;
    TMotorSql.GetInstance.ExecuteSQL(sSQL);

    if TMotorSQL.GetInstance.GetStatus = 0 then
    begin                                                  
      TMotorSQL.GetInstance.Commit;
    end
    else
    Begin
      TMotorSQL.GetInstance.Rollback;
    end;
     sSQL:= 'insert into DOCUMENTOSVARIOS (PLN_CODIGO,PLN_DESCRIPCION,PLN_NRO_REV,PLN_FECHA,PLN_ESTADO,PLN_USUARIO_ALTA)'+
           ' VALUES ('+QuotedStr(self.edtCodigo.Text)+','+QuotedStr(self.edtDescripcion2.Text)+','+QuotedStr(self.edtNroRev2.Text)+','+QuotedStr(DateToStr(Date))+','+QuotedStr('PA')+','+QuotedStr(Usuario)+')';

     TMotorSql.GetInstance.ExecuteSQL(sSQL);
     if TMotorSQL.GetInstance.GetStatus = 0 then
    begin
     TMotorSQL.GetInstance.Commit;
    end
    else
    Begin
     TMotorSQL.GetInstance.Rollback;
    end;       
    
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
end.
