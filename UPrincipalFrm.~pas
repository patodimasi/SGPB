unit UPrincipalFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls,UMaterialesAltaForm, ActnList, ImgList, ToolWin,
  ExtCtrls, StdCtrls, Jpeg, ShellApi,ShlObj, DB, ADODB,UUtiles,IniFiles;

const
  INI_DIR_SECTION = 'Directorios';
  INI_DATABASE_KEY = 'Foto';
type
  TPrincipalFrm = class(TForm)
    mmMenuPrincipal: TMainMenu;
    mmiConsultas: TMenuItem;
    mmiAcercaDe: TMenuItem;
    mmiSalir: TMenuItem;
    mmiHerramientas: TMenuItem;
    mmiBaseDeDatos: TMenuItem;
    mmiCopiaDeSeguridad: TMenuItem;
    mmiPurgarTablas: TMenuItem;
    mmiUsuarios: TMenuItem;
    mmiAltaUsuario: TMenuItem;
    mmiConsultasUsuario: TMenuItem;
    mmiTareas: TMenuItem;
    mmiPendientes: TMenuItem;
    mmAprobar: TMenuItem;
    mmiRecibirPlano: TMenuItem;
    mmiSuperar: TMenuItem;
    mmiGestion: TMenuItem;
    mmiAlta: TMenuItem;
    mmiBaja: TMenuItem;
    mmiModificar: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    stbEstado: TStatusBar;
    mmiAplicacion: TMenuItem;
    mmiDeslockear: TMenuItem;
    mmiSeleccionar: TMenuItem;
    mmiCambiar: TMenuItem;
    mmiRestablecer: TMenuItem;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ActionList1: TActionList;
    Consulta: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Planos: TAction;
    ToolButton4: TToolButton;
    Manuales: TAction;
    ToolButton5: TToolButton;
    Lista_Materiales: TAction;
    Grabar: TAction;
    ToolButton9: TToolButton;
    Salir: TAction;
    ToolButton11: TToolButton;
    Alta: TAction;
    Baja: TAction;
    Pendientes: TAction;
    mmiPlano: TMenuItem;
    mmiMateriales: TMenuItem;
    mmiAltaL: TMenuItem;
    mmiBajaL: TMenuItem;
    mmiManuales: TMenuItem;
    mmiAltaM: TMenuItem;
    mmiBajaM: TMenuItem;
    mmiModificacionM: TMenuItem;
    mmiModificacionL: TMenuItem;
    Timer1: TTimer;
    mmiAprobarMateriales: TMenuItem;
    Plano1: TMenuItem;
    Materiales1: TMenuItem;
    RecibirListadeMateriales1: TMenuItem;
    Image: TImage;
    Label2: TLabel;
    SuperarListadeMateriales1: TMenuItem;
    ToolButton16: TToolButton;
    PopupMenuABMPlano: TPopupMenu;
    Alta1: TMenuItem;
    Baja1: TMenuItem;
    Modificacion1: TMenuItem;
    PopupMenuABMMateriales: TPopupMenu;
    Alta2: TMenuItem;
    Baja2: TMenuItem;
    Modificacion2: TMenuItem;
    ToolButton15: TToolButton;
    ToolButton17: TToolButton;
    ToolButton20: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton13: TToolButton;
    PopupMenuABMManuales: TPopupMenu;
    Alta3: TMenuItem;
    Baja3: TMenuItem;
    Modificacion3: TMenuItem;
    Manual1: TMenuItem;
    AprobarManual1: TMenuItem;
    RecibirManual1: TMenuItem;
    SuperarManual1: TMenuItem;
    ADODataSet1: TADODataSet;
    ADODataSet1USR_IMAGEN: TWideStringField;
    SeleccionarFoto1: TMenuItem;
    DocumentosVarios1: TMenuItem;
    InstructivosdeProduccin1: TMenuItem;
    Alta4: TMenuItem;
    Modificacin1: TMenuItem;
    Baja4: TMenuItem;
    DocumentosVarios2: TMenuItem;
    InstructivosProduccion1: TMenuItem;
    Aprobar1: TMenuItem;
    Recibir1: TMenuItem;
    Superar1: TMenuItem;
    SubinstructivosdeProduccin1: TMenuItem;
    Alta5: TMenuItem;
    Baja5: TMenuItem;
    Modificar1: TMenuItem;
    SubinstructivosdeProduccin2: TMenuItem;
    Aprobar2: TMenuItem;
    Recibir2: TMenuItem;
    Superar2: TMenuItem;
    MenuBandeja: TPopupMenu;
    procedure mmiSalirClick(Sender: TObject);
    procedure mmiAcercaDeClick(Sender: TObject);
    procedure mmiCopiaDeSeguridadClick(Sender: TObject);
    procedure mmiAltaUsuarioClick(Sender: TObject);
    procedure mmiConsultasUsuarioClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmiPendientesClick(Sender: TObject);
    procedure mmiAltaClick(Sender: TObject);
    procedure mmAprobarClick(Sender: TObject);
    procedure mmiRecibirPlanoClick(Sender: TObject);
    procedure mmiModificarClick(Sender: TObject);
    procedure mmiConsultasClick(Sender: TObject);
    procedure mmiBajaClick(Sender: TObject);
    procedure mmiSuperarClick(Sender: TObject);
    procedure mmiGenerarPlanillaClick(Sender: TObject);
    procedure mmiPurgarTablasClick(Sender: TObject);
    procedure mmiRecuperarPlanoClick(Sender: TObject);
    procedure mmiDeslockearClick(Sender: TObject);
    procedure mmiSeleccionarClick(Sender: TObject);
    procedure mmiCambiarClick(Sender: TObject);
    procedure mmiRestablecerClick(Sender: TObject);
    procedure AltadeMateriales1Click(Sender: TObject);
    procedure SalirExecute(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure mmiAltaLClick(Sender: TObject);
    procedure mmiBajaLClick(Sender: TObject);
    procedure mmiModificacionLClick(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure mmiAprobarMaterialesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
//    procedure FormPaint(Sender: TObject);
    procedure SuperarListadeMateriales1Click(Sender: TObject);
    procedure RecibirListadeMateriales1Click(Sender: TObject);
    procedure Alta1Click(Sender: TObject);
    procedure Baja1Click(Sender: TObject);
//    procedure Modificacion1Click(Sender: TObject);
    procedure Alta2Click(Sender: TObject);
    procedure Baja2Click(Sender: TObject);
    procedure Modificacion2Click(Sender: TObject);
    procedure mmiAltaMClick(Sender: TObject);
    procedure mmiBajaMClick(Sender: TObject);
    procedure mmiModificacionMClick(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure Alta3Click(Sender: TObject);
    procedure Baja3Click(Sender: TObject);
    procedure Modificacion3Click(Sender: TObject);
    procedure AprobarManual1Click(Sender: TObject);
    procedure RecibirManual1Click(Sender: TObject);
    procedure SuperarManual1Click(Sender: TObject);
    function SetDataBase: Boolean;
    procedure SeleccionarFoto1Click(Sender: TObject);
    procedure Alta4Click(Sender: TObject);
    procedure Modificacin1Click(Sender: TObject);
    procedure Baja4Click(Sender: TObject);
    procedure Aprobar1Click(Sender: TObject);
    procedure Recibir1Click(Sender: TObject);
    procedure Superar1Click(Sender: TObject);
    procedure Alta5Click(Sender: TObject);
    procedure Baja5Click(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Aprobar2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Recibir2Click(Sender: TObject);
    procedure Superar2Click(Sender: TObject);
    procedure Alta6Click(Sender: TObject);
    procedure Baja6Click(Sender: TObject);
    procedure Modificacin2Click(Sender: TObject);
    procedure Aprobar3Click(Sender: TObject);
    procedure Recibir3Click(Sender: TObject);
    procedure Superar3Click(Sender: TObject);
    procedure Alta7Click(Sender: TObject);
    procedure Baja7Click(Sender: TObject);
    procedure Modificacin3Click(Sender: TObject);
    procedure Recibir4Click(Sender: TObject);
    procedure Superar4Click(Sender: TObject);
    procedure Alta8Click(Sender: TObject);
    procedure Baja8Click(Sender: TObject);
    procedure Modificacin4Click(Sender: TObject);
    procedure Aprobar4Click(Sender: TObject);
    procedure Recibir5Click(Sender: TObject);
    procedure Superar5Click(Sender: TObject);
    procedure MostrarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);


  private
   procedure CargarFoto;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrincipalFrm: TPrincipalFrm;

implementation

uses
  UAcercaDeFrm, USistema, ULogonFrm, UUsuarioFrm, UAlta, UBaja, UModificacion,
  UConsultaUsuariosFrm, UTareasPendientes, UPlanoAltaFrm, UPlanoAprobarFrm,
  UAprobar, URecibir, UPlanoSuperarFrm, UConsultasFrm, UPurgarPlanosFrm,
  URecuperar, UPlanoBajaFrm, UMotorSQL, UPassFrm, UCambiarPass, URestablecerPass,
  UMaterialesAltaFrm, UMaterialesBajaFrm, UMaterialesModificarFrm,
  UMaterialesSuperarFrm, URecibirMaterialesfrm,UManualesAltaFrm ,
  UManualesBajaFrm, UManualModificarfrm, UManualSuperarFrm, USistemaF,
  UInstructivosProdAltaFrm, UInstructivosProdModificarFrm, UInstructivosProdBaja,UInstructivosProdAprobarFrm,
  UInstructivosProdRecibirFrm, UInstructivosProdSuperarFrm, USubinstructivosProdAltaFrm, USubinstructivosBajaFrm,
  USubinstructivosProdModificarFrm, USubinstructivosProdAprobarFrm, USubinstructivosProdRecibirFrm, USubinstructivosProdSuperarFrm,
  UInstructivos_SubinstructivosAltaFrm, UInstructivos_SubinstructivosBajaFrm, UInstructivos_SubinstructivosModificarFrm,
  UInstructivos_SubinstructivosAprobarFrm, UInstructivos_SubinstructivosRecibirFrm, UInstructivos_SubinstructivosSuperarFrm, UDocumentosClientesAltaFrm,
  UDocumentosClientesBajaFrm, UDocumentosClientesModificarFrm, UDocumentosClientesRecibirFrm, UDocumentosClientesSuperarFrm, UEspecificacionesTecnicasAltaFrm,
  UEspecificacionesTecnicasBajaFrm, UEspecificacionesTecnicasModificarFrm, UEspecificacionesTecnicasAprobarFrm,UEspecificacionesTecnicasRecibirFrm,
  UEspecificacionesTecnicasSuperarFrm, UManualAprobarFrm,
  UMaterialesAprobarFrm;

{$R *.dfm}
procedure TPrincipalFrm.mmiSalirClick(Sender: TObject);
begin
  //LogonFrm.Close;
  Close;
end;

procedure TPrincipalFrm.mmiAcercaDeClick(Sender: TObject);
begin
  Enabled:= False;
  AcercaDeFrm.Show;
end;

procedure TPrincipalFrm.mmiCopiaDeSeguridadClick(Sender: TObject);
var
  BackupFilename: string;
  DataBaseFilename: string;
  Msg: string;
  BackupFile: TFileStream;
  DataBaseFile: TFileStream;
begin
  try
    SaveDialog.Filter := 'Base de Datos Access (*.mdb)|*.mdb';
    SaveDialog.DefaultExt:= 'mdb';
    if SaveDialog.Execute then
    begin
      BackupFilename:= SaveDialog.FileName;
      DataBaseFilename:= TSistema.GetInstance().GetDataBaseFilename();

      Msg := Format( '¿ Esta seguro que desea realizar copia de seguridad del '
                   + 'archivo %s en el archivo %s ?'
                   , [DataBaseFilename, BackupFilename]);

      if MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) = mrOK then
      begin
        DataBaseFile := TFileStream.Create(DataBaseFilename, fmOpenRead or fmShareDenyWrite);
        try
          BackupFile := TFileStream.Create(BackupFilename, fmCreate);
          try
            BackupFile.CopyFrom(DataBaseFile, DataBaseFile.Size);
            ShowMessage('Se realizó con éxito la copia de seguridad');
          finally
            FreeAndNil(BackupFile);
          end;
        finally
          FreeAndNil(DataBaseFile);
        end;
      end;
    end;
  except
    on E: Exception do ShowMessage(E.message);
  end;
end;

procedure TPrincipalFrm.mmiAltaUsuarioClick(Sender: TObject);
begin
//  Enabled:= False;
  UsuarioFrm.MainForm:= Self;
  UsuarioFrm.Operacion:= TAlta.Create;
  UsuarioFrm.Show;
end;

procedure TPrincipalFrm.mmiConsultasUsuarioClick(Sender: TObject);
begin
  Enabled:= False;
  ConsultaUsuariosFrm.MainForm:= Self;
  ConsultaUsuariosFrm.Show;
end;


procedure TPrincipalFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LogonFrm.Close;
end;

procedure TPrincipalFrm.mmiPendientesClick(Sender: TObject);
begin
  Enabled:= False;
  TareasPendientesFrm.MainForm:= Self;
  TareasPendientesFrm.Show;
end;

procedure TPrincipalFrm.mmiAltaClick(Sender: TObject);
begin
  Enabled:= False;
  PlanoAltaFrm.MainForm:= Self;
  PlanoAltaFrm.Show;
end;

procedure TPrincipalFrm.mmAprobarClick(Sender: TObject);
begin
  Enabled:= False;
  PlanoAprobarFrm.Operacion:= TAprobar.Create;
  PlanoAprobarFrm.MainForm:= Self;
  PlanoAprobarFrm.Show;
end;

procedure TPrincipalFrm.mmiRecibirPlanoClick(Sender: TObject);
begin
  Enabled:= False;
  PlanoAprobarFrm.Operacion:= TRecibir.Create;
  PlanoAprobarFrm.MainForm:= Self;
  PlanoAprobarFrm.Show;
end;

procedure TPrincipalFrm.mmiModificarClick(Sender: TObject);
begin
  Enabled:= False;
  PlanoAprobarFrm.Operacion:= TModificacion.Create;
  PlanoAprobarFrm.MainForm:= self;
  PlanoAprobarFrm.Show;
end;

procedure TPrincipalFrm.mmiConsultasClick(Sender: TObject);
begin
  Enabled:= False;
  ConsultasFrm.MainForm:= Self;
  ConsultasFrm.Show;
end;

procedure TPrincipalFrm.mmiBajaClick(Sender: TObject);
begin
  Enabled:= False;
  PlanoBajaFrm.Operacion:= TBaja.Create;
  PlanoBajaFrm.MainForm:= Self;
  PlanoBajaFrm.Show;
end;

procedure TPrincipalFrm.mmiSuperarClick(Sender: TObject);
begin
  Enabled:= False;
  PlanoSuperarFrm.MainForm:= Self;
  PlanoSuperarFrm.Show;
end;

procedure TPrincipalFrm.mmiGenerarPlanillaClick(Sender: TObject);
begin
  ShowMessage('EN CONSTRUCCION');
end;

procedure TPrincipalFrm.mmiPurgarTablasClick(Sender: TObject);
begin
  Enabled:= False;
  PurgarPlanosFrm.MainForm:= Self;
  PurgarPlanosFrm.Show;
end;

procedure TPrincipalFrm.mmiRecuperarPlanoClick(Sender: TObject);
begin
  Enabled:= False;
  PlanoBajaFrm.Operacion:= TRecuperar.Create;
  PlanoBajaFrm.MainForm:= Self;
  PlanoBajaFrm.Show;
end;

procedure TPrincipalFrm.mmiDeslockearClick(Sender: TObject);
begin
  if MessageDlg('¿ Esta seguro que desea deslockear todas las pantallas ?', mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    if TSistema.GetInstance.UnLockAllScreens then
      ShowMessage('Todas las pantallas han sido deslockeadas satisfactoriamente');
  end;
end;

procedure TPrincipalFrm.mmiSeleccionarClick(Sender: TObject);
begin
  try
    OpenDialog.Filter := 'Base de Datos Access (*.mdb)|*.mdb';
    OpenDialog.DefaultExt:= 'mdb';
    if OpenDialog.Execute then
    begin
      if FileExists(OpenDialog.FileName) then
      begin
        TSistema.GetInstance.SetDataBaseFilename(OpenDialog.FileName);
        TMotorSQL.GetInstance.SetDataBase(OpenDialog.FileName);
      end
      else
        ShowMessage('El archivo ' + OpenDialog.FileName + ' no existe');
    end;
  except
    ShowMessage('No se seleccionó ninguna base de datos');
  end;
end;

procedure TPrincipalFrm.mmiCambiarClick(Sender: TObject);
begin
  Enabled:= False;
  PassFrm.MainForm:= Self;
  PassFrm.Operacion:= TCambiarPass.Create;
  PassFrm.Show;
end;

procedure TPrincipalFrm.mmiRestablecerClick(Sender: TObject);
begin
  Enabled:= False;
  PassFrm.MainForm:= Self;
  PassFrm.Operacion:= TRestablecerPass.Create;
  PassFrm.Show;
end;

procedure TPrincipalFrm.AltadeMateriales1Click(Sender: TObject);
begin
  FormAltaMateriales.Show;
end;

procedure TPrincipalFrm.SalirExecute(Sender: TObject);
begin
  self.mmiSalir.Click
end;

procedure TPrincipalFrm.ToolButton11Click(Sender: TObject);
begin
  self.mmiSalir.Click
end;

procedure TPrincipalFrm.ToolButton1Click(Sender: TObject);
begin
  self.mmiConsultas.Click
end;

procedure TPrincipalFrm.mmiAltaLClick(Sender: TObject);
begin
 MaterialesAltaFrm.MainForm := Self;
 MaterialesAltaFrm.Show;
end;

procedure TPrincipalFrm.mmiBajaLClick(Sender: TObject);
begin
//  self.Enabled:= False;
 // MaterialesBajaFrm.MainForm:= self;
  MaterialesBajaFrm.Show;

end;
{Procedure TPrincipalFrm.mmiModificacionLClick(Sender: TObject);
begin}

procedure TPrincipalFrm.mmiModificacionLClick(Sender: TObject);
begin
  //self.Enabled:= False;
 // ListaMaterialesModificarFrm.MainForm:= self;
  ListaMaterialesModificarFrm.Show;

end;

procedure TPrincipalFrm.ToolButton9Click(Sender: TObject);
begin
  self.mmiCopiaDeSeguridad.Click;
end;

procedure TPrincipalFrm.mmiAprobarMaterialesClick(Sender: TObject);
begin
  Enabled:= False;
  MaterialesAprobarFrm.Operacion:= TAprobar.Create;
  MaterialesAprobarFrm.MainForm:= Self;
  MaterialesAprobarFrm.Show;
 end;
 
Procedure TPrincipalFrm.FormShow(Sender: TObject);
var
 Usuario: string;
begin
   Usuario:= TSistema.getInstance.getUsuario.Logon;
   self.Label2.Caption:= Usuario;
   Self.CargarFoto;
//  UsuarioFrm.Button1.Show;

end;
procedure TPrincipalFrm.ImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  const
      SC_DragMove = $F012;  { a magic number }
begin
    ReleaseCapture;
      image.perform(WM_SysCommand, SC_DragMove, 0);
end;

{procedure TPrincipalFrm.FormPaint(Sender: TObject);

   var
   i: Integer;

   procedure MakeShadow(control: TControl; Width: Integer; Color: TColor);
   var
     rect: TRect;
     old: TColor;
   begin
     // Bordes del control
     // Borders of controls
     rect := control.boundsrect;
     rect.Left := rect.Left + width;
     rect.Top := rect.Top + width;
     rect.Right := rect.Right + width;
     rect.Bottom := rect.Bottom + width;
     // Guardar el color
     // Save the old color
     old := Self.canvas.brush.color;
     // Pintar la sombra
     // Paint the shadow
     Self.canvas.brush.Color := color;
     Self.canvas.fillrect(rect);
     Self.canvas.brush.Color := old;
   end;
 begin
   // Revisar todos los componentes del form
   // Go trough all form components
   for i:=0 to Self.ControlCount-1 do
     MakeShadow(Self.Controls[i],2,clGray);
 end;
  }
  
procedure TPrincipalFrm.SuperarListadeMateriales1Click(Sender: TObject);
begin
  MaterialesSuperarFrm.Show
end;

procedure TPrincipalFrm.RecibirListadeMateriales1Click(Sender: TObject);
begin
  Enabled:= False;
  MaterialesAprobarFrm.Operacion:= TRecibir.Create;
  MaterialesAprobarFrm.MainForm:= Self;
  MaterialesAprobarFrm.Show;
end;

procedure TPrincipalFrm.Alta1Click(Sender: TObject);
begin
  PlanoAltaFrm.MainForm:= self;
  PlanoAltaFrm.Show;
end;

procedure TPrincipalFrm.Baja1Click(Sender: TObject);
begin
 PlanoBajaFrm.MainForm:= self;
 PlanoBajaFrm.Show;
end;

{procedure TPrincipalFrm.Modificacion1Click(Sender: TObject);
begin
  PlanoModificarFrm.MainForm:= self;
  PlanoModificarFrm.Show;
end;
 }
procedure TPrincipalFrm.Alta2Click(Sender: TObject);
begin
  MaterialesAltaFrm.MainForm:= self;
  MaterialesAltaFrm.Show;
end;

procedure TPrincipalFrm.Baja2Click(Sender: TObject);
begin
  MaterialesBajaFrm.MainForm:= self;
  MaterialesBajaFrm.Show;
end;

procedure TPrincipalFrm.Modificacion2Click(Sender: TObject);
begin
  ListaMaterialesModificarFrm.MainForm:= self;
  ListaMaterialesModificarFrm.Show;

end;
procedure TPrincipalFrm.mmiAltaMClick(Sender: TObject);
begin
  Enabled:= False;
  ManualesAltaFrm.MainForm:= Self;
  ManualesAltaFrm.Show;
end;

procedure TPrincipalFrm.mmiBajaMClick(Sender: TObject);
begin
//  self.Enabled:= False;
  ManualesBajaFrm.MainForm:= self;
  ManualesBajaFrm.Show;

end;
procedure TPrincipalFrm.mmiModificacionMClick(Sender: TObject);
begin
  Enabled:= False;
  ManualAprobarFrm.Operacion:= TModificacion.Create;
  ManualAprobarFrm.MainForm:= Self;
  ManualAprobarFrm.Show;
end;

procedure TPrincipalFrm.ToolButton15Click(Sender: TObject);
begin
  Self.PopupMenuABMMateriales.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

end;
procedure TPrincipalFrm.ToolButton16Click(Sender: TObject);
begin
  Self.PopupMenuABMPlano.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

end;

procedure TPrincipalFrm.ToolButton5Click(Sender: TObject);
begin
  self.PopupMenuABMManuales.Popup(Mouse.CursorPos.X,Mouse.CursorPos.y);
end;

procedure TPrincipalFrm.Alta3Click(Sender: TObject);
begin
  ManualesAltaFrm.MainForm:= self;
  ManualesAltaFrm.Show;
end;

procedure TPrincipalFrm.Baja3Click(Sender: TObject);
begin
  ManualesBajaFrm.MainForm:= self;
  ManualesBajaFrm.Show;
end;

procedure TPrincipalFrm.Modificacion3Click(Sender: TObject);
begin
    ManualModificarfrm.MainForm:= self;
    ManualModificarfrm.Show;
end;

procedure TPrincipalFrm.AprobarManual1Click(Sender: TObject);
begin
  Enabled:= False;
  ManualAprobarFrm.Operacion:= TAprobar.Create;
  ManualAprobarFrm.MainForm:= Self;
  ManualAprobarFrm.Show;
end;

procedure TPrincipalFrm.RecibirManual1Click(Sender: TObject);
begin
  Enabled:= False;
  ManualAprobarFrm.Operacion:= TRecibir.Create;
  ManualAprobarFrm.MainForm:= Self;
  ManualAprobarFrm.Show;
end;

procedure TPrincipalFrm.SuperarManual1Click(Sender: TObject);
begin
//  self.Enabled:= False;
  ManualSuperarFrm.MainForm:= self;
  ManualSuperarFrm.Show;
end;

function TPrincipalFrm.SetDataBase: Boolean;
begin
  Result:= False;
    if TSistemaF.GetInstance.DataBaseExists then
  begin
      TMotorSql.GetInstance.SetDataBase(TSistemaF.GetInstance.GetDataBaseFilename);
    Result:= True;
  end
  else
     TSIstemaF.GetInstance.DeleteIniFile;
end;

procedure TPrincipalFrm.CargarFoto;
var
  Ini: TIniFile;
  sFoto : string;
  //Usuario: string;
  OpenPictureDialog: TOpenDialog;
begin
 try
  Ini := TIniFile.Create(SysUtils.ExtractFilePath(Application.ExeName)+'\SGPBFotos.INI');
  sFoto := Ini.ReadString('Directorio', TSistema.GetInstance.GetUsuario.Logon,'');
  if Length(sFoto)>0 then
  Begin
    Image.Picture.LoadFromFile(sFoto);
  end;
  except
   showMessage('Vuelva a seleccionar la foto');
   OpenPictureDialog:= TOpenDialog.Create(nil);
   OpenPictureDialog.Title:= 'Seleccione la carpeta de fotos';
    if OpenPictureDialog.Execute then
 begin
// try
   PrincipalFrm.Image.Picture.LoadFromFile(OpenPictureDialog.FileName);
  // Usuario:= OpenPictureDialog.FileName;
   ini.WriteString(INI_DIR_SECTION, self.Label2.Caption,OpenPictureDialog.FileName);
end;
end;
end;
procedure TPrincipalFrm.SeleccionarFoto1Click(Sender: TObject);
  var
OpenPictureDialog: TOpenDialog;
Usuario: string;
Ini: TIniFile;
begin
  OpenPictureDialog:= TOpenDialog.Create(nil);
 OpenPictureDialog.Title:= 'Seleccione la carpeta de fotos';
 if OpenPictureDialog.Execute then
 begin
 try
   PrincipalFrm.Image.Picture.LoadFromFile(OpenPictureDialog.FileName);
   Usuario:= OpenPictureDialog.FileName;

   Ini := TIniFile.Create(SysUtils.ExtractFilePath(Application.ExeName)+'\SGPBFotos.INI');
   Ini.WriteString( 'Directorio', TSistema.GetInstance.GetUsuario.Logon, Usuario);
   Ini.Free;
  except
    on EIntError do
    showMessage('Error inesperado');
    else
    showMessage('Seleccione imagenes con terminacion .jpg/bmp');
end;
end;
end;
procedure TPrincipalFrm.Alta4Click(Sender: TObject);
begin
  InstructivosMaterialesAltaFrm.Show;
end;

procedure TPrincipalFrm.Modificacin1Click(Sender: TObject);
begin
  InstructivosProduccionModificarFrm.Show;
end;
procedure TPrincipalFrm.Baja4Click(Sender: TObject);
begin
  InstructivosProdBajaFrm.Show;
end;
procedure TPrincipalFrm.Aprobar1Click(Sender: TObject);
begin
  InstructivosProdAprobarFrm.Show;
end;
procedure TPrincipalFrm.Recibir1Click(Sender: TObject);
begin
  RecibirInstructivosProdFrm.Show;
end;
procedure TPrincipalFrm.Superar1Click(Sender: TObject);
begin
  SuperarInstructivosProdFrm.Show;
end;

procedure TPrincipalFrm.Alta5Click(Sender: TObject);
begin
  SubinstructivosProdAltaFrm.Show;
end;
procedure TPrincipalFrm.Baja5Click(Sender: TObject);
begin
  SubinstructivosProdBajaFrm.Show;
end;

procedure TPrincipalFrm.Modificar1Click(Sender: TObject);
begin
  SubinstructivosProdAprobarFrm.Operacion:= TModificacion.Create;
  SubinstructivosProdAprobarFrm.Show;
end;

procedure TPrincipalFrm.Aprobar2Click(Sender: TObject);
begin
  //Enabled:= False;
  SubinstructivosProdAprobarFrm.Operacion:= TAprobar.Create;
 // SubinstructivosProdAprobarFrm.MainForm:= Self;
  SubinstructivosProdAprobarFrm.Show;
end;

procedure TPrincipalFrm.FormCreate(Sender: TObject);
begin
  self.stbEstado.Panels[1].Text:= DateToStr(Date);
  self.stbEstado.Panels[2].Text:= TimeToStr(Time);
end;

procedure TPrincipalFrm.Recibir2Click(Sender: TObject);
begin
  SubinstructivosProdAprobarFrm.Operacion:= TRecibir.Create;
  SubinstructivosProdAprobarFrm.Show;
end;

procedure TPrincipalFrm.Superar2Click(Sender: TObject);
begin
  SubinstructivosProdSuperarFrm.Show;
end;

procedure TPrincipalFrm.Alta6Click(Sender: TObject);
begin
  Instructivos_SubinstructivosAltaFrm.Show;
end;
procedure TPrincipalFrm.Baja6Click(Sender: TObject);
begin
  Instructivos_Subinstructivos_EnsayosBajaFrm.Show;
end;

procedure TPrincipalFrm.Modificacin2Click(Sender: TObject);
begin
  Instructivos_SubinstructivosModificarFrm.Show;
end;

procedure TPrincipalFrm.Aprobar3Click(Sender: TObject);
begin
  Instructivos_SubinstructivosAprobarFrm.Show;
end;

procedure TPrincipalFrm.Recibir3Click(Sender: TObject);
begin
  Instructivos_SubinstructivosRecibirFrm.Show;
end;

procedure TPrincipalFrm.Superar3Click(Sender: TObject);
begin
  Instructivos_SubinstructivosSuperarFrm.Show;
end;

procedure TPrincipalFrm.Alta7Click(Sender: TObject);
begin
  DocumentosClientesAltaFrm.Show;
end;

procedure TPrincipalFrm.Baja7Click(Sender: TObject);
begin
  DocumentosClientesBajaFrm.Show;
end;

procedure TPrincipalFrm.Modificacin3Click(Sender: TObject);
begin
  DocumentosClientesModificarFrm.Show;
end;

procedure TPrincipalFrm.Recibir4Click(Sender: TObject);
begin
  RecibirDocumentosClientesFrm.Show;
end;

procedure TPrincipalFrm.Superar4Click(Sender: TObject);
begin
  SuperarDocumentosClientesFrm.Show;
end;

procedure TPrincipalFrm.Alta8Click(Sender: TObject);
begin
  EspecificacionesTecnicasAltaFrm.Show;
end;

procedure TPrincipalFrm.Baja8Click(Sender: TObject);
begin
  EspecificacionesTecnicasBajaFrm.Show;
end;

procedure TPrincipalFrm.Modificacin4Click(Sender: TObject);
begin
  EspecificacionesTecnicasModificarFrm.Show;
end;

procedure TPrincipalFrm.Aprobar4Click(Sender: TObject);
begin
  EspecificacionesTecnicasAprobarFrm.Show;
end;

procedure TPrincipalFrm.Recibir5Click(Sender: TObject);
begin
  EspecificacionesTecnicasRecibirFrm.Show;
end;

procedure TPrincipalFrm.Superar5Click(Sender: TObject);
begin
  SuperarEspecificacionesTecnicasFrm.Show;
end;
procedure TPrincipalFrm.MostrarClick(Sender: TObject);
var
IconData: TNotifyIconData;
begin
   PrincipalFrm.Show;
   ShowWindow( Application.Handle, SW_SHOW );
   Shell_NotifyIcon( NIM_DELETE, @IconData );
   IconData.Wnd := 0;
end;   
procedure TPrincipalFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
   close;
  end;
end;


end.

