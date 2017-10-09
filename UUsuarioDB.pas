unit UUsuarioDB;

interface
uses
  UObjectDB, UUsuario, UMotorSQL, ComCtrls;

const
  LOGON_VALID = 1;
  LOGON_INVALID = 0;
  NOT_AUTHORIZATION = -2;
  USER_INVALID = -3;
  PASS_INVALID = -4;
  LOGON_FAILED = -1;
  CONS_USR_LOGON = 1;
  CONS_USR_NYA = 2;
  USR_ALTA_OK = 1;
  USR_ALTA_FAILED = 2;
  USR_ALTA_LOGON_DUP = 3;

type
  TUsuarioDB = class(TObjectDB)
  public
    function Alta(U: TUsuario): Integer;
    function Modificacion(U: TUsuario): Boolean;
    function Baja(U: TUsuario): Boolean;
    function GenerarLogon(U: TUsuario): string;
    function ConsultarLogon(U: TUsuario): Integer;
    function GetUsuario(U: TUsuario; TipoConsulta: Integer): Boolean;
    function Consulta(ListView: TListView; SQL: string): Boolean;
    function CambiarPass(Usuario: string; PassAnt: string; PassNue: string): Boolean;

  end;

implementation
uses
  SysUtils, ADODB, USistema, Classes, StrUtils, UPermisosDB;

{function TUsuarioDB.Alta(U: TUsuario): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;

begin
  Result:= USR_ALTA_FAILED;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    sSQL:= 'select 1 as Existe from USUARIO where USR_LOGON = ' + Formatear(U.Logon);

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= sSQL;
      Dst.Open;
      if Dst.Eof then
      begin
        Dst.Close;
        Dst.Free;

        // Genero un nuevo ID de usuario
        sSQL:= 'select max(USR_CODIGO)+1 as NuevoId from USUARIO';
        Dst:= TADODataset.Create(nil);
        try
          // Obtengo la conexion a la BD
          Dst.Connection:= MSQL.GetConn;
          Dst.CommandText:= sSQL;
          // Realizo la consulta
          Dst.Open;
          U.Codigo:= Dst.FieldByName('NuevoId').AsInteger;
          Dst.Close;

          sSQL:= Format('insert into USUARIO ' +
                        '( USR_CODIGO ' +
                        ', USR_NOMBRE ' +
                        ', USR_APELLIDO ' +
                        ', USR_LOGON ' +
                        ', USR_PASS ' +
                        ', USR_ESTADO ' +
                        ', USR_FECHA_ALTA ' +
                        ', USR_FECHA_BAJA ' +
                        ', PER_CODIGO ' +
                        ', USUARIO_CREACION ' +
                        ', FECHA_CREACION ' +
                        ', USUARIO_MODIF ' +
                        ', FECHA_MODIF ' +
                       // ', USR_IMAGEN ' +
                        ' VALUES (%d, %s, %s, %s, %s, %s, %s, %s, %d, %s, %s, %s, %s)'
                        , [U.Codigo, Formatear(U.Nombre), Formatear(U.Apellido),
                           Formatear(U.Logon), Formatear(U.Logon), Formatear(U.Estado),
                           Formatear(U.FechaAlta), Formatear(U.FechaBaja),
                           U.Permisos.Codigo, Formatear(TSistema.GetInstance.GetUsuario.Logon),
                           Formatear(DateToStr(Date)), Formatear(''),
                           Formatear('')]);
          try
            MSQL.ExecuteSQL(sSQL);
            if MSQL.GetStatus = 0 then
            begin
              MSQL.Commit;
              if MSQL.GetStatus = 0 then
                Result:= USR_ALTA_OK;

              MSQL.CloseConn;
            end;
          except
            Result:= USR_ALTA_FAILED;
          end;
        finally
          Dst.free;
        end;
      end
      else
      begin
        Dst.Close;
        Dst.Free;
        Result:= USR_ALTA_LOGON_DUP;
      end;
    except
      Dst.Free;
    end;
 end;
end;}
function TUsuarioDB.Alta(U: TUsuario): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;

begin
  Result:= USR_ALTA_FAILED;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    sSQL:= 'select 1 as Existe from USUARIO where USR_LOGON = ' + Formatear(U.Logon);

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= sSQL;
      Dst.Open;
      if Dst.Eof then
      begin
        Dst.Close;
        Dst.Free;

        // Genero un nuevo ID de usuario
        sSQL:= 'select max(USR_CODIGO)+1 as NuevoId from USUARIO';
        Dst:= TADODataset.Create(nil);
        try
          // Obtengo la conexion a la BD
          Dst.Connection:= MSQL.GetConn;
          Dst.CommandText:= sSQL;
          // Realizo la consulta
          Dst.Open;
          U.Codigo:= Dst.FieldByName('NuevoId').AsInteger;
          Dst.Close;

          sSQL:= Format('insert into USUARIO ' +
                        '( USR_CODIGO ' +
                        ', USR_NOMBRE ' +
                        ', USR_APELLIDO ' +
                        ', USR_LOGON ' +
                        ', USR_PASS ' +
                        ', USR_ESTADO ' +
                        ', USR_FECHA_ALTA ' +
                        ', USR_FECHA_BAJA ' +
                        ', PER_CODIGO ' +
                        ', USUARIO_CREACION ' +
                        ', FECHA_CREACION ' +
                        ', USUARIO_MODIF ' +
                        ', FECHA_MODIF )' +
                        ' VALUES (%d, %s, %s, %s, %s, %s, %s, %s, %d, %s, %s, %s, %s)'
                        , [U.Codigo, Formatear(U.Nombre), Formatear(U.Apellido),
                           Formatear(U.Logon), Formatear(U.Logon), Formatear(U.Estado),
                           Formatear(U.FechaAlta), Formatear(U.FechaBaja),
                           U.Permisos.Codigo, Formatear(TSistema.GetInstance.GetUsuario.Logon),
                           Formatear(DateToStr(Date)), Formatear(''),
                           Formatear('')]);
          try
            MSQL.ExecuteSQL(sSQL);
            if MSQL.GetStatus = 0 then
            begin
              MSQL.Commit;
              if MSQL.GetStatus = 0 then
                Result:= USR_ALTA_OK;

              MSQL.CloseConn;
            end;
          except
            Result:= USR_ALTA_FAILED;
          end;
        finally
          Dst.free;
        end;
      end
      else
      begin
        Dst.Close;
        Dst.Free;
        Result:= USR_ALTA_LOGON_DUP;
      end;
    except
      Dst.Free;
    end;
  end;
end;



function TUsuarioDB.Modificacion(U: TUsuario): Boolean;
var
  sSQL: string;
  MSQL: TMotorSQL;

begin
  Result:= False;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    // Genero un nuevo ID de usuario
    sSQL:= Format('update USUARIO ' +
                  'set USR_ESTADO = %s' +
                   ' , USR_FECHA_BAJA = %s' +
                   ' , PER_CODIGO = %d' +
                   ' , USUARIO_MODIF = %s' +
                   ' , FECHA_MODIF = %s' +
                  ' where USR_LOGON = %s'
                 , [Formatear(U.Estado), Formatear(U.FechaBaja), U.Permisos.Codigo,
                    Formatear(TSistema.GetInstance.GetUsuario.Logon),
                    Formatear(DateToStr(Date)), Formatear(U.Logon)]);
   try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= True;

        MSQL.CloseConn;

      end;
    except
      Result:= False;
    end;
  end;
end;


function TUsuarioDB.Baja(U: TUsuario): Boolean;
var
  sSQL: string;
  MSQL: TMotorSQL;

begin
  Result:= False;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then

    sSQL:= Format('delete from USUARIO ' +
                  'where USR_CODIGO = %d'
                 ,[U.Codigo]);
    try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= True;

        MSQL.CloseConn;
      end;
  except
    Result:= False;
  end;
end;

//-----------------------------------------------------------------------------
// DETERMINA SI EL NOMBRE DE USUARIO CON EL QUE INTENTA LOGGEARSE ES VALIDO
//-----------------------------------------------------------------------------
function TUsuarioDB.ConsultarLogon(U: TUsuario): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;
  sEstado: string;
  sPass: string;

begin

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    //Result:= LOGON_INVALID;
    sSQL:= 'select USR_CODIGO, USR_NOMBRE, USR_APELLIDO, USR_LOGON, USR_PASS ' +
                ', USR_ESTADO , USR_FECHA_ALTA, USR.PER_CODIGO ' +
                ', PER_CONSULTAR, PER_ALTA, PER_BAJA, PER_MODIFICAR ' +
                ', PER_SUPERAR, PER_APROBAR, PER_RECIBIR, PER_ADMINISTRAR ' +
            ' from USUARIO  USR, PERMISOS  PER ' +
           ' where USR_LOGON  = ' + Formatear(U.Logon) +
             ' and USR.PER_CODIGO = PER.PER_CODIGO';

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= sSQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        sEstado:= Dst.FieldByName('USR_ESTADO').AsString;
        sPass:= Dst.FieldByName('USR_PASS').AsString;
        if sEstado <> USR_EST_ACTIVO then
          Result:= NOT_AUTHORIZATION
        else if sPass <> U.Pass then
          Result:= PASS_INVALID
        else
        begin
          with U do
          begin
            Codigo:= Dst.FieldByName('USR_CODIGO').AsInteger;
            Nombre:= Dst.FieldByName('USR_NOMBRE').AsString;
            Apellido:= Dst.FieldByName('USR_APELLIDO').AsString;
            Estado:= Dst.FieldByName('USR_ESTADO').AsString;
            FechaAlta:= Dst.FieldByName('USR_FECHA_ALTA').AsString;
            FechaBaja:= '';
            Permisos.Codigo:= Dst.FieldByName('PER_CODIGO').AsInteger;
            Permisos.Consultar:= Dst.FieldByName('PER_CONSULTAR').AsString[1];
            Permisos.Alta:= Dst.FieldByName('PER_ALTA').AsString[1];
            Permisos.Baja:= Dst.FieldByName('PER_BAJA').AsString[1];
            Permisos.Modificar:= Dst.FieldByName('PER_MODIFICAR').AsString[1];
            Permisos.Superar:= Dst.FieldByName('PER_SUPERAR').AsString[1];
            Permisos.Aprobar:= Dst.FieldByName('PER_APROBAR').AsString[1];
            Permisos.Recibir:= Dst.FieldByName('PER_RECIBIR').AsString[1];
            Permisos.Administrar:= Dst.FieldByName('PER_ADMINISTRAR').AsString[1];
          end;
          Result:= LOGON_VALID;
        end;
      end
      else
        Result:= USER_INVALID;

      Dst.Close;
      MSQL.CloseConn;
    finally
      Dst.Free;
    end;
  end
  else
    Result:= LOGON_FAILED;
end;


//-----------------------------------------------------------------------------
// GENERAR NOMBRE DE USUARIO DE FORMA AUTOMATICA
//-----------------------------------------------------------------------------
function TUsuarioDB.GenerarLogon(U: TUsuario): string;
var
  sNombre: string;
  sApellido: string;
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;
  Lista: TStrings;
  I: Integer;
  Existe: Integer;

begin
  Result:= '';

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    //Inicio el proceso de generación de nombres de usuarios
    Lista:= TStringList.Create;
    sNombre:= UpperCase(Trim(U.Nombre));
    sApellido:= UpperCase(Trim(U.Apellido));

    //Forma1: NApellido
    Lista.Add(LeftStr(LeftStr(sNombre,1)+sApellido, USR_LEN_USUARIO));

    //Forma2: ApellidoN
    Lista.Add(LeftStr(sApellido+LeftStr(sNombre,1), USR_LEN_USUARIO));

    //Forma3: ANombre
    Lista.Add(LeftStr(LeftStr(sApellido,1)+sNombre, USR_LEN_USUARIO));

    //Forma4: NombreA
    Lista.Add(LeftStr(sNombre+LeftStr(sApellido,1), USR_LEN_USUARIO));

    //Forma5: Nombre
    Lista.Add(LeftStr(sNombre, USR_LEN_USUARIO));

    //Forma6: Apellido
    Lista.Add(LeftStr(sApellido, USR_LEN_USUARIO));

    //Forma7: NomApe
    Lista.Add(LeftStr(LeftStr(sNombre,3)+LeftStr(sApellido,3), USR_LEN_USUARIO));

    //Forma8: ApeNom
    Lista.Add(LeftStr(LeftStr(sApellido,3)+LeftStr(sNombre,3), USR_LEN_USUARIO));

    I:= 0;
    while I < 8 do
    begin
      // Busco si el nombre de usuario existe
      sSQL:= 'select count(*) as Cont from USUARIO where USR_LOGON = ' + Formatear(Lista.Strings[I]);
      Dst:= TADODataset.Create(nil);
      try
        // Obtengo la conexion a la BD
        Dst.Connection:= MSQL.GetConn;
        Dst.CommandText:= sSQL;
        // Realizo la consulta
        Dst.Open;
        Existe:= Dst.FieldByName('Cont').AsInteger;
        Dst.Close;

        if Existe > 0 then
          Inc(I)
        else
        begin
          Result:= Lista.Strings[I];
          I:= 8;
        end;
      finally
        Dst.free;
      end;
    end;

    MSQL.CloseConn;
  end;
end;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// RECUPERA EL USUARIO SOLICITADO
//-----------------------------------------------------------------------------
function TUsuarioDB.GetUsuario(U: TUsuario; TipoConsulta: Integer): Boolean;
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

    sSQL:= 'select USR_CODIGO, USR_NOMBRE, USR_APELLIDO, USR_LOGON, USR_PASS ' +
                ', USR_ESTADO, USR_FECHA_ALTA, USR_FECHA_BAJA, USR.PER_CODIGO ' +
                ', PER_CONSULTAR, PER_ALTA, PER_BAJA, PER_MODIFICAR ' +
                ', PER_SUPERAR, PER_APROBAR, PER_RECIBIR, PER_ADMINISTRAR ' +
            ' from USUARIO  USR, PERMISOS  PER ' +
           ' where USR.PER_CODIGO = PER.PER_CODIGO ';

    if TipoConsulta = CONS_USR_LOGON then
    begin
      sSQL:= sSQL + ' and USR_LOGON = ' + Formatear(U.Logon);
    end;

    if TipoConsulta = CONS_USR_NYA then
    begin
      sSQL:= sSQL + ' and USR_NOMBRE = ' + Formatear(U.Nombre) +
             ' and USR_APELLIDO = ' + Formatear(U.Apellido);

    end;

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= sSQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        with U do
        begin
          Pass:= Dst.FieldByName('USR_PASS').AsString;

          Codigo:= Dst.FieldByName('USR_CODIGO').AsInteger;
          Nombre:= Dst.FieldByName('USR_NOMBRE').AsString;
          Apellido:= Dst.FieldByName('USR_APELLIDO').AsString;
          Estado:= Dst.FieldByName('USR_ESTADO').AsString;
          FechaAlta:= Dst.FieldByName('USR_FECHA_ALTA').AsString;
          FechaBaja:= Dst.FieldByName('USR_FECHA_BAJA').AsString;
          Permisos.Codigo:= Dst.FieldByName('PER_CODIGO').AsInteger;

          Permisos.Codigo:= Dst.FieldByName('PER_CODIGO').AsInteger;
          Permisos.Consultar:= Dst.FieldByName('PER_CONSULTAR').AsString[1];
          Permisos.Alta:= Dst.FieldByName('PER_ALTA').AsString[1];
          Permisos.Baja:= Dst.FieldByName('PER_BAJA').AsString[1];
          Permisos.Modificar:= Dst.FieldByName('PER_MODIFICAR').AsString[1];
          Permisos.Superar:= Dst.FieldByName('PER_SUPERAR').AsString[1];
          Permisos.Aprobar:= Dst.FieldByName('PER_APROBAR').AsString[1];
          Permisos.Recibir:= Dst.FieldByName('PER_RECIBIR').AsString[1];
          Permisos.Administrar:= Dst.FieldByName('PER_ADMINISTRAR').AsString[1];
        end;
        Result:= True;
      end;
      Dst.Close;
      MSQL.CloseConn;
    finally
      Dst.Free;
    end;
  end;
end;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// CONSULTA
//-----------------------------------------------------------------------------
function TUsuarioDB.Consulta(ListView: TListView; SQL: string): Boolean;
var
  MSQL: TMotorSQL;
  Dst: TADODataset;
  ItemUs: TListItem;

begin
  Result:= False;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= SQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        while not Dst.Eof do
        begin
          ItemUs:= ListView.Items.Add;
          ItemUs.Caption:= Dst.FieldByName('USR_LOGON').AsString;
          ItemUs.SubItems.Add(Dst.FieldByName('USR_NOMBRE').AsString);
          ItemUs.SubItems.Add(Dst.FieldByName('USR_APELLIDO').AsString);
          ItemUs.SubItems.Add(Dst.FieldByName('USR_ESTADO').AsString);
          Dst.Next;
        end;
        Result:= True;
      end;
      Dst.Close;
      MSQL.CloseConn;
    finally
      Dst.Free;
    end;
  end;
end;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
function TUsuarioDB.CambiarPass(Usuario: string; PassAnt: string; PassNue: string): Boolean;
var
  sSQL: string;
  MSQL: TMotorSQL;

begin
  Result:= False;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    // Genero un nuevo ID de usuario
    sSQL:= Format('update USUARIO ' +
                  'set USR_PASS = %s' +
                   ' , USUARIO_MODIF = %s' +
                   ' , FECHA_MODIF = %s' +
                  ' where USR_LOGON = %s ' +
                  '   and USR_PASS  = %s'
                 , [Formatear(PassNue), Formatear(TSistema.GetInstance.GetUsuario.Logon),
                    Formatear(DateToStr(Date)), Formatear(Usuario), Formatear(PassAnt)]);
   try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= True;

        MSQL.CloseConn;

      end;
    except
      Result:= False;
    end;
  end;
end;
//-----------------------------------------------------------------------------

end.
