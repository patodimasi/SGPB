unit UUsuario;

interface
uses
  UPermisos;

const
  USR_EST_CREADO = 'CR';
  USR_EST_ACTIVO = 'AC';
  USR_EST_INACTIVO = 'IN';
  USR_EST_BAJA = 'BA';
  USR_EST_ERROR = 'ER';

  USR_LEN_USUARIO = 10;

type
  TEstadoUsuario = string[2];

  TUsuario = class(TObject)
  private
    FCodigo: Integer;
    FNombre: string;
    FApellido: string;
    FLogon: string;
    FPass: string;
    FEstado: TEstadoUsuario;
    FFechaAlta: string;
    FFechaBaja: string;
    FPermisos: TPermisos;
    FImagen: string;
  public
    constructor Create; overload;
    constructor Create(sLogon: string); overload;
    destructor Destroy; override;
    property Codigo: Integer read FCodigo write FCodigo;
    property Nombre: string read FNombre write FNombre;
    property Apellido: string read FApellido write FApellido;
    property Logon: string read FLogon write FLogon;
    property Pass: string read FPass write FPass;
    property Estado: TEstadoUsuario read FEstado write FEstado;
    property FechaAlta: string read FFechaAlta write FFechaAlta;
    property FechaBaja: string read FFechaBaja write FFechaBaja;
    property Permisos: TPermisos read FPermisos write FPermisos;
    property Imagen: string read FImagen write FImagen;
  end;

implementation

constructor TUsuario.Create;
begin
  FPermisos:= TPermisos.Create;
  FCodigo:= -1;
  FNombre:= '';
  FApellido:= '';
  FLogon:= '';
  FPass:= '';
  FEstado:= USR_EST_CREADO;
  FFechaAlta:= '';
  FImagen:= '';
end;

constructor TUsuario.Create(sLogon: string);
begin
  Create;
  FLogon:= sLogon;
end;

destructor TUsuario.Destroy;
begin
  FPermisos.Free;
end;

end.
