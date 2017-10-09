unit UPlano;

interface
const
  PLN_EST_CREADO = 'CR';
  PLN_EST_ACTIVO = 'AC';
  PLN_EST_INACTIVO = 'IN';
  PLN_EST_BAJA = 'BA';
  PLN_EST_SUPERABLE = 'SU';
  PLN_EST_ERROR = 'ER';
  PLN_EST_PEND_APR = 'PA';
  PLN_EST_PEND_REC = 'PR';
  PLN_EST_TODOS = '*';


type
  TEstadoPlano = string[2];

  TPlano = class(TObject)
  private
    FCodigo: string;
    FDescripcion: string;
    FRevision: Integer;
    FEdicion: Integer;
    FEstado: TEstadoPlano;
    FFecha: string;
    FUsuarioAlta: string;
    FUsuarioAprobacion: string;
    FFechaAprobacion: string;
    FUsuarioRecepcion: string;
    FFechaRecepcion: string;
    FUbicacion: string;
    FSuperado: string;
    FUsuarioCreacion: string;
    FFechaCreacion: string;
    FUsuarioModif: string;
    FFechaModif: string;

  public
    constructor Create;
    property Codigo: string read FCodigo write FCodigo;
    property Descripcion: string read FDescripcion write FDescripcion;
    property Revision: Integer read FRevision write FRevision;
    property Edicion: Integer read FEdicion write FEdicion;
    property Estado: TEstadoPlano read FEstado write FEstado;
    property Fecha: string read FFecha write FFecha;
    property UsuarioAlta: string read FUsuarioAlta write FUsuarioAlta;
    property UsuarioAprobacion: string read FUsuarioAprobacion write FUsuarioAprobacion;
    property FechaAprobacion: string read FFechaAprobacion write FFechaAprobacion;
    property UsuarioRecepcion: string read FUsuarioRecepcion write FUsuarioRecepcion;
    property FechaRecepcion: string read FFechaRecepcion write FFechaRecepcion;
    property Ubicacion: string read FUbicacion write FUbicacion;
    property Superado: string read FSuperado write FSuperado;
    property UsuarioCreacion: string read FUsuarioCreacion write FUsuarioCreacion;
    property FechaCreacion: string read FFechaCreacion write FFechaCreacion;
    property UsuarioModif: string read FUsuarioModif write FUsuarioModif;
    property FechaModif: string read FFechaModif write FFechaModif;
    property CodigoL: string read FCodigo write FCodigo;
    function Copiar(P: TPlano): Boolean;

  end;

implementation

constructor TPlano.Create;
begin
  FCodigo:= '';
  FDescripcion:= '';
  FEstado:= PLN_EST_CREADO;
end;

function TPlano.Copiar(P: TPlano): Boolean;
begin
  Result:= True;
  if Assigned(P) then
  begin
    FCodigo:= P.Codigo;
    FDescripcion:= P.Descripcion;
    FRevision:= P.Revision;
    FEdicion:= P.Edicion;
    FEstado:= P.Estado;
    FFecha:= P.Fecha;
    FUsuarioAlta:= P.UsuarioAlta;
    FUsuarioAprobacion:= P.UsuarioAprobacion;
    FFechaAprobacion:= P.FechaAprobacion;
    FUsuarioRecepcion:= P.UsuarioRecepcion;
    FFechaRecepcion:= P.FechaRecepcion;
    FUbicacion:= P.Ubicacion;
    FSuperado:= P.Superado;
    FUsuarioCreacion:= P.UsuarioCreacion;
    FFechaCreacion:= P.FechaCreacion;
    FUsuarioModif:= P.UsuarioModif;
    FFechaModif:= P.FechaModif;
  end
  else
    Result:= False;

end;

end.
