unit USubinstructivo;

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
  TEstadoS = string[2];

  TSubinstructivo = class(TObject)
  private
    FCodigoS: string;
    FDescripcionS: string;
    FRevisionS: Integer;
    FEdicionS: Integer;
    FEstadoS: TEstadoS;
    FFechaS: string;
    FUsuarioAltaS: string;
    FUsuarioAprobacionS: string;
    FFechaAprobacionS: string;
    FUsuarioRecepcionS: string;
    FFechaRecepcionS: string;
    FUbicacionS: string;
    FUsuarioCreacionS: string;
    FFechaCreacionS: string;
    FUsuarioModifS: string;
    FFechaModifS: string;
    FSuperadoS: string;

 public
    constructor Create;
    property Codigo: string read FCodigoS write FCodigoS;
    property Descripcion: string read FDescripcionS write FDescripcionS;
    property Revision: Integer read FRevisionS write FRevisionS;
    property Edicion: Integer read FEdicionS write FEdicionS;
    property Estado: TEstadoS read FEstadoS write FEstadoS;
    property Fecha: string read FFechaS write FFechaS;
    property UsuarioAlta: string read FUsuarioAltaS write FUsuarioAltaS;
    property UsuarioAprobacion: string read FUsuarioAprobacionS write FUsuarioAprobacionS;
    property FechaAprobacion: string read FFechaAprobacionS write FFechaAprobacionS;
    property UsuarioRecepcion: string read FUsuarioRecepcionS write FUsuarioRecepcionS;
    property FechaRecepcion: string read FFechaRecepcionS write FFechaRecepcionS;
    property Ubicacion: string read FUbicacionS write FUbicacionS;
    property Superado: string read FSuperadoS write FSuperadoS;
    property UsuarioCreacion: string read FUsuarioCreacionS write FUsuarioCreacionS;
    property FechaCreacion: string read FFechaCreacionS write FFechaCreacionS;
    property UsuarioModif: string read FUsuarioModifS write FUsuarioModifS;
    property FechaModif: string read FFechaModifS write FFechaModifS;
    function Copiar(S: TSubinstructivo): Boolean;

   end;

implementation

constructor TSubinstructivo.Create;
begin
  FCodigoS:= '';
  FDescripcionS:= '';
  FEstadoS:= PLN_EST_CREADO;
end;

function  TSubinstructivo.Copiar(S: TSubinstructivo): Boolean;
begin
  Result:= True;
  if Assigned(S) then
  begin
    FCodigoS:= S.Codigo;
    FDescripcionS:= S.Descripcion;
    FRevisionS:= S.Revision;
    FEdicionS:= S.Edicion;
    FEstadoS:= S.Estado;
    FFechaS:= S.Fecha;
    FUsuarioAltaS:= S.UsuarioAlta;
    FUsuarioAprobacionS:= S.UsuarioAprobacion;
    FFechaAprobacionS:= S.FechaAprobacion;
    FUsuarioRecepcionS:= S.UsuarioRecepcion;
    FFechaRecepcionS:= S.FechaRecepcion;
    FUbicacionS:= S.Ubicacion;
    FUsuarioCreacionS:= S.UsuarioCreacion;
    FFechaCreacionS:= S.FechaCreacion;
    FUsuarioModifS:= S.UsuarioModif;
    FFechaModifS:= S.FechaModif;
    FSuperadoS:= S.Superado;
  end
  else
    Result:= False;
 end;

end.
