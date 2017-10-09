unit USistemaF;

interface
uses
  UUsuario, IniFiles, UObjectDB, UUsuarioDB, UPlanoDB;

const
  DB_FILENAME = 'SGPBFotos.jpg';
  INI_FILENAME = 'SGPBFotos.ini';
  INI_DIR_SECTION = 'Directorio';
  INI_DATABASE_KEY = 'Bas';

type
  TAccion = string[1];

  TSistemaF = class(TObjectDB)
  private
    FUsuario: TUsuario;
    FUsuarioDB: TUsuarioDB;
    FIniFile: TIniFile;
    FIniFilename: string;
    constructor Create;
    function SelectPath: string;
  public
    //property PlanoDB: TPlanoDB read FPlanoDB;
    
    property UsuarioDB: TUsuarioDB read FUsuarioDB;
    class function GetInstance: TSistemaF;
    function GetDataBaseFilename: string;
    procedure SetDataBaseFilename(F: string);
    function DataBaseExists: Boolean;
    function GetUsuario: TUsuario;
    destructor Destroy; override;
   // procedure SetSecurity;
    procedure DeleteIniFile;
   { function LockScreen(PLockeada: string; PLockeadora: string): Boolean;
    function UnLockScreen(P: string): Boolean;
    function UnLockAllScreens: Boolean;
    function IsLocked(P: string): Boolean;
    function LockedByUser(P: string): string;
    function LockedByScreen(P: string): string;
    function LockedByScreenDesc(P: string): string;
    }
  end;
implementation
uses
  Forms, SysUtils, UPrincipalFrm, Dialogs, UMotorSQL, ADODB;


var
  // Es una clase singleton
  SistemaF: TSistemaF;

constructor TSistemaF.Create;
var
  F: file;

begin
  FUsuario:= TUsuario.Create;
  FUsuarioDB:= TUsuarioDB.Create;


  // Obtengo el path de la aplicacion y le concateno el nombre del archivo INI
  FIniFilename:= ExtractFilePath(Application.ExeName) + INI_FILENAME;

  // Verifico si el archivo INI existe
  if not FileExists(FIniFilename) then
  begin
    // Si no existe, lo creo
    AssignFile(F, FIniFilename);
    Rewrite(F);
    CloseFile(F);
  end;

  // Creo el objeto que se va a encargar de trabajar sobre el archivo INI
  FIniFile:= TIniFile.Create(FIniFilename);

end;

class function TSistemaF.GetInstance: TSistemaF;
begin
  Result:= SistemaF;
end;
function TSistemaF.SelectPath: string;
var
  OpenDialog: TOpenDialog;

begin
  Result:= '';
  OpenDialog:= TOpenDialog.Create(nil);
  try
    OpenDialog.Title:= 'Seleccione la carpeta de fotos ';
    //OpenDialog.Filter := 'Base de Datos Access (*.mdb)|*.mdb';
    //OpenDialog.DefaultExt:= 'mdb';
    if OpenDialog.Execute then
    begin
      if FileExists(OpenDialog.FileName) then
      begin
        SetDataBaseFilename(OpenDialog.FileName);
        Result:= OpenDialog.FileName;
      end
      else
        ShowMessage('El archivo ' + OpenDialog.FileName + ' no existe');
    end;
  except
    ShowMessage('No se pudo seleccionar la ubicación de la base de datos');
  end;
end;

function TSistemaF.GetDataBaseFilename: string;
begin
  Result:= FIniFile.ReadString(INI_DIR_SECTION, INI_DATABASE_KEY, '');
end;
procedure TSistemaF.SetDataBaseFilename(F: string);
begin
  FIniFile.WriteString(INI_DIR_SECTION, INI_DATABASE_KEY, F);
end;
function TSistemaF.DataBaseExists: Boolean;
var
  Filename: string;
begin
  Result:= False;
  Filename:= GetDataBaseFilename;
  if (Filename <> '') and FileExists(Filename) then
  begin
    Result:= True;
  end
  else
  begin
    Filename:= SelectPath;
    if Filename <> '' then
    begin
      SetDataBaseFilename(Filename);
      Result:= True;
    end;
  end;
end;
function TSistemaF.GetUsuario: TUsuario;
begin
  Result:= FUsuario;
end;
Destructor TSistemaF.Destroy;
begin
  FUsuario.Free;
  //FPlanoDB.Free;
  FUsuarioDB.Free;
  FIniFile.Free;
end;
procedure TSistemaF.DeleteIniFile;
begin
  DeleteFile(FIniFilename);
end;
initialization

if not Assigned(SistemaF) then
  SistemaF:= TSistemaF.Create;

finalization

if Assigned(SistemaF) then
begin
  SistemaF.Free;
end;

end.
 