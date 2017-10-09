unit UDVarios;

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
  //TEstadoVarios = string[2];
  TDVarios= class(TObject)

  private
   FCodigoDV: string;
   FDescripcionDV: string;
   FRevisionDV: integer;
   FEdicionDV: integer;
   FFechaDV: string;
   FUsuarioAltaDV: string;
   FUsuarioAprobacionDV: string;
   FFechaAprobacionDV: string;
   FUsuarioRecepcionDV: string;
   FUbicacionDV: string;
   FUsuarioCreacionDV: string;
   FFechaCreacionDV: string;
   FUsuarioModifDV: string;
   FFechaModifDV: string;
   //FEstado: TEstadoVarios;
   FFechaRecepcionDV: string;

  public
   Constructor Create;
   property CodigoDV: string read FCodigoDV write FCodigoDV;
   property DescripcionDV: string read FDescripcionDV write FDescripcionDV;
   property RevisionDV: integer read FRevisionDV write FRevisionDV;
   property EdicionDV: integer read FEdicionDV write FEdicionDV;
   property FechaDV: string read FFechaDV write FFechaDV;
   property UsuarioAltaDV: string read FUsuarioAltaDV write FUsuarioAltaDV;
   property UsuarioAprobacionDv: string read FUsuarioAprobacionDV write FUsuarioAprobacionDV;
   property FechaAprobacionDV: string read FFechaAprobacionDv write FFechaAprobacionDV;
   property UsuarioRecepcionDV: string read FUsuarioRecepcionDV write FUsuarioRecepcionDV;
   property UbicacionDv: string read FUbicacionDV write FUbicacionDV;
   property UsuarioCreacionDV: string read FUsuarioCreacionDV write FUsuarioCreacionDv;
   property FechaCreacionDV: string read FFechaCreacionDV write FFechaCreacionDV;
   property UsuarioModifDV: string read FUsuarioModifDV write FUsuarioModifDV;
   property FechaModifDV: string read FFechaModifDV write FFechaModifDv;
   property FechaRecepcionDV: string read FFechaRecepcionDV write FFechaRecepcionDV;
   function Copiar(DV: TDVarios) : Boolean;
 end;

implementation

Constructor TDVarios.Create;
begin
  self.FCodigoDV:= '';
  self.FDescripcionDV:= '';
end;
function TDVarios.Copiar(DV: TDVarios): Boolean;
begin
  Result:= True;
  if Assigned(DV) then
  begin
     self.FCodigoDV:= DV.CodigoDV;
     self.FDescripcionDV:= DV.DescripcionDV;
     self.FRevisionDV:= DV.RevisionDV;
     self.FEdicionDV:= DV.EdicionDV;
     self.FFechaDV:= DV.FechaDV;
     self.FUsuarioAltaDV:= DV.UsuarioAltaDV;
     self.FUsuarioAprobacionDV:= DV.UsuarioAprobacionDv;
     self.FFechaAprobacionDV:= DV.FechaAprobacionDV;
     self.FUsuarioRecepcionDV:= DV.UsuarioRecepcionDV;
     self.FUbicacionDV:= DV.UbicacionDv;
     self.FUsuarioCreacionDV:= DV.UsuarioCreacionDV;
     self.FFechaCreacionDV:= DV.FechaCreacionDV;
     self.FUsuarioModifDV:= DV.UsuarioModifDV;
     self.FFechaModifDV:= DV.FechaModifDV;
   end
    else
      Result:= False;
  end;
end.
