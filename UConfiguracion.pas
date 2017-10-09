unit UConfiguracion;

interface
uses
  IniFiles;

const
  INI_PATH = 'cfg\';
  INI_FILENAME = 'conf.ini';
  INI_DIR_SECTION = 'Directorios';
  INI_DATABASE_KEY = 'Base';

type
  TConfiguracion = class(TObject)
  private
    FIniFile: TIniFile;
    constructor Create;
  public
    class function GetInstance: TConfiguracion;
    function GetDataBaseFilename: string;
    procedure SetDataBaseFilename(F: string);
    destructor Destroy; override;
  end;

implementation
uses
  SysUtils, Forms;

var
  // Es una clase singleton
  Configuracion: TConfiguracion;

constructor TConfiguracion.Create;
var
  IniFilename: string;
  F: file;
begin
  // Obtengo el path de la aplicacion y le concateno el nombre del archivo INI
  IniFilename:= ExtractFilePath(Application.ExeName) + INI_PATH + INI_FILENAME;

  // Verifico si el archivo INI existe
  if not FileExists(IniFilename) then
  begin
    // Si no existe, lo creo
    AssignFile(F, IniFilename);
    Rewrite(F);
    CloseFile(F);

    // TODO: Invocar un método que le pida al usuario determinar la ubicacion
    // de la base de datos.
  end;

  // Creo el objeto que se va a encargar de trabajar sobre el archivo INI
  FIniFile:= TIniFile.Create(IniFilename);
end;

class function TConfiguracion.GetInstance: TConfiguracion;
begin
  Result:= Configuracion;
end;

destructor TConfiguracion.Destroy;
begin
  FIniFile.Free;
end;

function TConfiguracion.GetDataBaseFilename: string;
var
  Filename: string;
begin
  Filename:= FIniFile.ReadString(INI_DIR_SECTION, INI_DATABASE_KEY, '');
  if Filename <> '' then
    Result:= Filename;

  // TODO: Si no pudo leer la clave, aplicar la misma lógica que si no
  // existiera el archivo INI
end;

procedure TConfiguracion.SetDataBaseFilename(F: string);
begin
  FIniFile.WriteString(INI_DIR_SECTION, INI_DATABASE_KEY, F);
end;


initialization

if not Assigned(Configuracion) then
  Configuracion:= TConfiguracion.Create;

finalization

if Assigned(Configuracion) then
begin
  Configuracion.Free;
end;

end.
