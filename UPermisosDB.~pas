unit UPermisosDB;

interface
uses
  UObjectDB, UPermisos;

type
  TPermisosDB = class(TObjectDB)
  public
    function GetPermisos(P: TPermisos): Boolean;
    function GetCodigo(P: TPermisos; var Cod: Integer): Boolean;
  end;

implementation
uses
  SysUtils, ADODB, UMotorSQL;


function TPermisosDB.GetPermisos(P: TPermisos): Boolean;
var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;

begin
  Result:= False;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin

    sSQL:= 'select PER_CONSULTAR, PER_ALTA, PER_BAJA, PER_MODIFICAR ' +
                ', PER_SUPERAR, PER_APROBAR, PER_RECIBIR, PER_ADMINISTRAR ' +
            ' from PERMISOS where PER_CODIGO = ' + IntToStr(P.Codigo);

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= sSQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        P.Consultar:= Dst.FieldByName('PER_CONSULTAR').AsString[1];
        P.Alta:= Dst.FieldByName('PER_ALTA').AsString[1];
        P.Baja:= Dst.FieldByName('PER_BAJA').AsString[1];
        P.Modificar:= Dst.FieldByName('PER_MODIFICAR').AsString[1];
        P.Superar:= Dst.FieldByName('PER_SUPERAR').AsString[1];
        P.Aprobar:= Dst.FieldByName('PER_APROBAR').AsString[1];
        P.Recibir:= Dst.FieldByName('PER_RECIBIR').AsString[1];
        P.Administrar:= Dst.FieldByName('PER_ADMINISTRAR').AsString[1];

        Result:= True;
      end;
      Dst.Close;
      MSQL.CloseConn;
    finally
      Dst.Free;
    end;
  end;
end;


function TPermisosDB.GetCodigo(P: TPermisos; var Cod: Integer): Boolean;
var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;

begin
  Result:= False;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin

    sSQL:= 'select PER_CODIGO from PERMISOS where ' +
           ' ( PER_CONSULTAR = ' + Formatear(P.Consultar) +
           ' and PER_ALTA = ' + Formatear(P.Alta) +
           ' and PER_BAJA = ' + Formatear(P.Baja) +
           ' and PER_MODIFICAR = ' + Formatear(P.Modificar) +
           ' and PER_SUPERAR = ' + Formatear(P.Superar) +
           ' and PER_APROBAR = ' + Formatear(P.Aprobar) +
           ' and PER_RECIBIR = ' + Formatear(P.Recibir) +
           ' and PER_ADMINISTRAR = ''N'')' +
           ' or ' +
           ' ( PER_ADMINISTRAR = ''S''' +
           ' and ' + Formatear(P.Administrar) + ' = ''S'')';

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= sSQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        Cod:= Dst.FieldByName('PER_CODIGO').AsInteger;
        Result:= True;
      end;
      Dst.Close;
      MSQL.CloseConn;
    finally
      Dst.Free;
    end;
  end;
end;


end.
