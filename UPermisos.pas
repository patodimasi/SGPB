unit UPermisos;

interface
type
  TPermisos = class(TObject)
  private
    FCodigo: Integer;
    FConsultar: Char;
    FAlta: Char;
    FBaja: Char;
    FModificar: Char;
    FSuperar: Char;
    FAprobar: Char;
    FRecibir: Char;
    FAdministrar: Char;

  public
    constructor Create;
    property Codigo: Integer read FCodigo write FCodigo;
    property Consultar: Char read FConsultar write FConsultar;
    property Alta: Char read FAlta write FAlta;
    property Baja: Char read FBaja write FBaja;
    property Modificar: Char read FModificar write FModificar;
    property Superar: Char read FSuperar write FSuperar;
    property Aprobar: Char read FAprobar write FAprobar;
    property Recibir: Char read FRecibir write FRecibir;
    property Administrar: Char read FAdministrar write FAdministrar;

  end;

implementation
constructor TPermisos.Create;
begin
  FCodigo:= 1;
  FConsultar:= 'N';
  FAlta:= 'N';
  FBaja:= 'N';
  FModificar:= 'N';
  FSuperar:= 'N';
  FAprobar:= 'N';
  FRecibir:= 'N';
  FAdministrar:= 'N';
end;

end.
