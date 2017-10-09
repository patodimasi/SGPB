unit UInstructivo;

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
  TEstadoInstructivo = string[2];

  TInstructivo = class(TObject)
  private
    FCodigoI: string;
    FDescripcionI: string;
    FRevisionI: Integer;
    FEdicionI: Integer;
    FEstadoI: TEstadoInstructivo;
    FFechaI: string;
    FUsuarioAltaI: string;
    FUsuarioAprobacionI: string;
    FFechaAprobacionI: string;
    FUsuarioRecepcionI: string;
    FFechaRecepcionI: string;
    FUbicacionI: string;
    FSuperadoI: string;
    FUsuarioCreacionI: string;
    FFechaCreacionI: string;
    FUsuarioModifI: string;
    FFechaModifI: string;

    public
    constructor Create;
    property Codigo: string read FCodigoI write FCodigoI;
    property Descripcion: string read FDescripcionI write FDescripcionI;
    property Revision: Integer read FRevisionI write FRevisionI;
    property Edicion: Integer read FEdicionI write FEdicionI;
    property Estado: TEstadoInstructivo read FEstadoI write FEstadoI;
    property Fecha: string read FFechaI write FFechaI;
    property UsuarioAlta: string read FUsuarioAltaI write FUsuarioAltaI;
    property UsuarioAprobacion: string read FUsuarioAprobacionI write FUsuarioAprobacionI;
    property FechaAprobacion: string read FFechaAprobacionI write FFechaAprobacionI;
    property UsuarioRecepcion: string read FUsuarioRecepcionI write FUsuarioRecepcionI;
    property FechaRecepcion: string read FFechaRecepcionI write FFechaRecepcionI;
    property Ubicacion: string read FUbicacionI write FUbicacionI;
    property Superado: string read FSuperadoI write FSuperadoI;
    property UsuarioCreacion: string read FUsuarioCreacionI write FUsuarioCreacionI;
    property FechaCreacion: string read FFechaCreacionI write FFechaCreacionI;
    property UsuarioModif: string read FUsuarioModifI write FUsuarioModifI;
    property FechaModif: string read FFechaModifI write FFechaModifI;
    property CodigoL: string read FCodigoI write FCodigoI;
    function Copiar(I: TInstructivo): Boolean;

  end;

implementation

constructor TInstructivo.Create;
begin
  FCodigoI:= '';
  FDescripcionI:= '';
  FEstadoI:= PLN_EST_CREADO;
end;

function TInstructivo.Copiar(I: TInstructivo): Boolean;
begin
 Result:= True;
  if Assigned(I) then
  begin
    FCodigoI:= I.Codigo;
    FDescripcionI:= I.Descripcion;
    FRevisionI:= I.Revision;
    FEdicionI:= I.Edicion;
    FEstadoI:= I.Estado;
    FFechaI:= I.Fecha;
    FUsuarioAltaI:= I.UsuarioAlta;
    FUsuarioAprobacionI:= I.UsuarioAprobacion;
    FFechaAprobacionI:= I.FechaAprobacion;
    FUsuarioRecepcionI:= I.UsuarioRecepcion;
    FFechaRecepcionI:= I.FechaRecepcion;
    FUbicacionI:= I.Ubicacion;
    FSuperadoI:= I.Superado;
    FUsuarioCreacionI:= I.UsuarioCreacion;
    FFechaCreacionI:= I.FechaCreacion;
    FUsuarioModifI:= I.UsuarioModif;
    FFechaModifI:= I.FechaModif;
  end
  else
    Result:= False;

end;

end.
