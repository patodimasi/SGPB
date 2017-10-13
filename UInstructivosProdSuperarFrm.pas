unit UInstructivosProdSuperarFrm;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UInstructivo, UPantallaFrm, DB, ADODB;

type
  TSuperarInstructivosProdFrm = class(TPantallaFrm)
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

    private
      FInstructivo: TInstructivo;
      procedure Limpiar;
      procedure LockScreen;
     //procedure UnLockScreen;
   end;

var
  SuperarInstructivosProdFrm: TSuperarInstructivosProdFrm;

implementation
uses
  USistema, UInstructivoDB;

{$R *.dfm}

procedure TSuperarInstructivosProdFrm.LockScreen;
begin
  lblCodigo.Enabled:= False;
  edtCodigo.Enabled:= False;
  lblDescripcion.Enabled:= False;
  lblDescripcion2.Enabled:= False;
  edtDescripcion2.Enabled:= False;
  lblNroRev.Enabled:= False;
  lblNroRev2.Enabled:= False;
  lblNroEdic.Enabled:= False;
  lblFechaAlta.Enabled:= False;
  lblFechaApr.Enabled:= False;
 // lblFechaSup.Enabled:= False;
  lblUAlta.Enabled:= False;
  lblUApr.Enabled:= False;
 //lblUSup.Enabled:= False;
  gbNueva.Enabled:= False;
  lblFechaSup2.Enabled:= False;
  btnBuscar.Visible:= False;
  btnConfirmar.Visible:= False;
  btnLimpiar.Visible:= False;
  btnVolver.SetFocus;
end;

procedure TSuperarInstructivosProdFrm.Limpiar;
begin
  if Assigned(FInstructivo) then
  begin
    FInstructivo.Free;
    FInstructivo:= nil;
  end;

  lblCodigo.Enabled:= True;
  edtCodigo.Enabled:= True;
  edtCodigo.Text:= '';
  edtNroRev.Text:= '';
  edtNroEdic.Text:= '';
  edtDescripcion.Text:= '';
  edtFechaAlta.Text:= '';
  edtFechaApr.Text:= '';
  edtUAlta.Text:= '';
  edtUApr.Text:= '';
  edtNroRev2.Text:= '';
  edtDescripcion2.Text:= '';
  self.edtFechaSup2.Text:= '';
  edtDescripcion2.Enabled:= False;
  self.Edit1.Text:= '';
  self.Edit2.Text:= '';

  btnBuscar.Enabled:= True;
  btnConfirmar.Enabled:= False;
  edtCodigo.SetFocus;

end;

procedure TSuperarInstructivosProdFrm.btnVolverClick(Sender: TObject);
begin
 { if not FLocked then
  begin
    TSistema.GetInstance.UnLockScreen(SCR_INSTRUCTIVOSPROD_RECIBIR);
    TSistema.GetInstance.UnLockScreen(SCR_INSTRUCTIVOSPROD_SUPERAR);
    TSistema.GetInstance.UnLockScreen(SCR_INSTRUCTIVOSPROD_BAJA);
    TSistema.GetInstance.UnLockScreen(SCR_INSTRUCTIVOSPROD_MODIF);
  end
  else
  begin
    UnLockScreen;
    FLocked:= False;
  end;
  if Assigned(FInstructivo) then
  begin
    FInstructivo.Free;
    FInstructivo:= nil;
  end;
  MainForm.Enabled:= True;
  MainForm.Show;
  Hide;
  MainForm:= nil;
  }
end;

procedure TSuperarInstructivosProdFrm.btnLimpiarClick(Sender: TObject);
begin
  self.Limpiar;
end;

end.
