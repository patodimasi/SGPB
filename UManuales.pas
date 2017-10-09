unit UManuales;

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

  TEstadoManual = string[2];

 TManuales= class(TObject)
 private
   FCodigoM: string;
   FDescripcionM: string;
   FRevisionM: integer;
   FEdicionM: integer;
   FEstadoM: TEstadoManual;
   FFechaM: string;
   FUsuarioAltaM: string;
   FUsuarioAprobacionM: string;
   FFechaAprobacionM: string;
   FUsuarioRecepcionM: string;
   FUbicacionM: string;
   FUsuarioCreacionM: string;
   FFechaCreacionM: string;
   FUsuarioModifM: string;
   FFechaModifM: string;
   FFechaRecepcionM: string;
 public
   constructor create;
   property CodigoM: string read FCodigoM write FCodigoM;
   property DescripcionM: string read FDescripcionM write FDescripcionM;
   property RevisionM: integer read FRevisionM write FRevisionM;
   property EdicionM: integer read FEdicionM write FEdicionM;
   property EstadoM: TEstadoManual read FEstadoM write FEstadoM;
   property FechaM: string read FFechaM  write FFechaM;
   property UsuarioAltaM: string read FUsuarioAltaM write FUsuarioAltaM;
   property UsuarioAprobacionM: string read FUsuarioAprobacionM write FUsuarioAprobacionM;
   property FechaAprobacionM: string read FFechaAprobacionM write FFechaAprobacionM;
   property UsuarioRecepcionM: string read FUsuarioRecepcionM write FUsuarioRecepcionM;
   property UbicacionM: string read FUbicacionM write FUbicacionM;
   property UsuarioCreacionM: string read FUsuarioCreacionM write FUsuarioCreacionM;
   property FechaCreacionM: string read FFechaCreacionM write FFechaCreacionM;
   property UsuarioModifM: string read FUsuarioCreacionM write FUsuarioCreacionM;
   property FechaModifM: string  read FFechaModifM write FFechaModifM;
   property FechaRecepcionM : string read FFechaRecepcionM write FFechaRecepcionM;
   function Copiar(M: TManuales): Boolean;

 end;
implementation
Constructor TManuales.create;
begin
  self.FCodigoM:= '';
  self.FDescripcionM:= '';
  FEstadoM:= PLN_EST_CREADO;
end;
function TManuales.Copiar(M: TManuales): Boolean;
begin
  Result:= True;
  if Assigned(M) then
  begin
    self.FCodigoM:= M.CodigoM;
    self.FDescripcionM:= M.DescripcionM;
    self.FRevisionM:= M.RevisionM;
    self.FEdicionM:= M.EdicionM;
    self.FEstadoM := M.FEstadoM;
    self.FFechaM:= M.FechaM;
    self.FUsuarioAltaM:= M.UsuarioAltaM;
    self.FUsuarioAprobacionM:= M.UsuarioAprobacionM;
    self.FFechaAprobacionM:= M.FechaAprobacionM;
    self.FUsuarioRecepcionM:= M.FUsuarioRecepcionM;
    self.FUbicacionM:= M.FUbicacionM;
    self.FUsuarioCreacionM:= M.UsuarioCreacionM;
    self.FFechaCreacionM:= M.FechaCreacionM;
    self.FUsuarioModifM:= M.UsuarioModifM;
    self.FFechaModifM:= M.FFechaModifM;
    self.FFechaRecepcionM:= M.FUsuarioRecepcionM;
 end;
  Result:= False;
end;
end.
