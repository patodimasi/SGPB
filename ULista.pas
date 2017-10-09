unit ULista;

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
  TEstadoLista = string[2];

  TLista = class(TObject)

  private
    FCodigoL: string;
    FDescripcionL: string;
    FRevisionL: Integer;
    FEdicionL: Integer;
    FEstadoL: TEstadoLista;
    FFechaL: string;
    FUsuarioAltaL: string;
    FUsuarioAprobacionL: string;
    FFechaAprobacionL: string;
    FUsuarioRecepcionL: string;
    FFechaRecepcionL: string;
    FUbicacionL: string;
    FSuperadoL: string;
    FUsuarioCreacionL: string;
    FFechaCreacionL: string;
    FUsuarioModifL: string;
    FFechaModifL: string;

  public
    constructor Create;
    property Codigo: string read FCodigoL write FCodigoL;
    property Descripcion: string read FDescripcionL write FDescripcionL;
    property Revision: Integer read FRevisionL write FRevisionL;
    property Edicion: Integer read FEdicionL write FEdicionL;
    property Estado: TEstadoLista read FEstadoL write FEstadoL;
    property Fecha: string read FFechaL write FFechaL;
    property UsuarioAlta: string read FUsuarioAltaL write FUsuarioAltaL;
    property UsuarioAprobacion: string read FUsuarioAprobacionL write FUsuarioAprobacionL;
    property FechaAprobacion: string read FFechaAprobacionL write FFechaAprobacionL;
    property UsuarioRecepcion: string read FUsuarioRecepcionL write FUsuarioRecepcionL;
    property FechaRecepcion: string read FFechaRecepcionL write FFechaRecepcionL;
    property Ubicacion: string read FUbicacionL write FUbicacionL;
    property Superado: string read FSuperadoL write FSuperadoL;
    property UsuarioCreacion: string read FUsuarioCreacionL write FUsuarioCreacionL;
    property FechaCreacion: string read FFechaCreacionL write FFechaCreacionL;
    property UsuarioModif: string read FUsuarioModifL write FUsuarioModifL;
    property FechaModif: string read FFechaModifL write FFechaModifL;
    function Copiar(L: TLista): Boolean;

    end;
implementation

Constructor TLista.create;
begin
  self.FCodigoL:= '';
  self.FDescripcionL:= '';
  FEstadoL:= PLN_EST_CREADO;
end;

function TLista.Copiar(L: TLista): Boolean;
begin
  Result:= True;
  if Assigned(L) then
  begin
    FCodigoL:= L.Codigo;
    FDescripcionL:= L.Descripcion;
    FRevisionL:= L.Revision;
    FEdicionL:= L.Edicion;
    FEstadoL:= L.Estado;
    FFechaL:= L.Fecha;
    FUsuarioAltaL:= L.UsuarioAlta;
    FUsuarioAprobacionL:= L.UsuarioAprobacion;
    FFechaAprobacionL:= L.FechaAprobacion;
    FUsuarioRecepcionL:= L.UsuarioRecepcion;
    FFechaRecepcionL:= L.FechaRecepcion;
    FUbicacionL:= L.Ubicacion;
    FSuperadoL:= L.Superado;
    FUsuarioCreacionL:= L.UsuarioCreacion;
    FFechaCreacionL:= L.FechaCreacion;
    FUsuarioModifL:= L.UsuarioModif;
    FFechaModifL:= L.FechaModif;
  end
  else
    Result:= False;

end;
end.
