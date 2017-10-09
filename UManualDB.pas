unit UManualDB;

interface
uses
  UObjectDB, UMotorSQL, UManuales,UPlano, ComCtrls;
  const
  PLN_ALTA_OK = 1;
  PLN_ALTA_FAILED = 2;
  PLN_APR_OK = 1;
  PLN_APR_FAILED = 2;
  PLN_REC_OK = 1;
  PLN_REC_FAILED = 2;
  PLN_MODIF_OK = 1;
  PLN_MODIF_FAILED = 2;
  PLN_SUPERAR_OK = 1;
  PLN_SUPERAR_FAILED = 2;
  PLN_BAJA_OK = 1;
  PLN_BAJA_FAILED = 2;
  PLN_MIG_OK = 1;
  PLN_MIG_FAILED = 2;

  PLN_SEL_ERRONEA = 3;

  PLN_PEND_TODOS = 1;
  PLN_PEND_APR = 2;
  PLN_PEND_REC = 3;

  PLN_BAJA = 1;
  PLN_RECUPERAR = 2;

  type
  TManualDB = class(TObjectDB)
  public
    function Alta(M: TManuales; Tabla: string): Integer;
    function Baja(M: TManuales; Tabla: string): Integer;
    function Modificacion(M: TManuales): Integer;
    function Aprobar(M: TManuales): Integer;
    function Recibir(M: TManuales): Integer;
    function GetManual(M: TManuales;E: TEstadoManual): Boolean;
    function GenerarManual(M: TManuales): Boolean;
    function Superar(MH: TManuales; MN: TManuales): Integer;
    function Consulta(ListView: TListView; SQL: string): Boolean;
    {function AltaMasiva(P: TPlano; TablaIns: string; TablaSel: string): Integer;
    function Baja(P: TPlano; Tabla: string): Integer;
    function BajaMasiva(Tabla: string): Integer;
    function Modificacion(P: TPlano): Integer;
    function Consulta(ListView: TListView; SQL: string): Boolean;
    function ConsultaPendientes(ListView: TListView; TipoPend: Integer): Boolean;
    function ConsultaPurgar(ListView: TListView): Boolean;
    function Superar(PH: TPlano; PN: TPlano): Integer;
    function ConsultaBaja(ListView: TListView; Plano: TPlano; Tipo: Integer): Boolean;
    function MigrarBaja(P: TPlano): Integer;
    function Recuperar(P: TPlano): Integer;
    function CumplirTareasTodos(TipoPend: Integer): Integer;
    function CumplirTareasSel(TipoPend: Integer; sCodigos: string): Integer;}
  end;

implementation
uses
  SysUtils, ADODB, USistema, Classes, StrUtils;

function TManualDB.Consulta(ListView: TListView; SQL: string): Boolean;
var
  MSQL: TMotorSQL;
  Dst: TADODataset;
  ItemPln: TListItem;

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
          ItemPln:= ListView.Items.Add;
          ItemPln.Caption:= Dst.FieldByName('PLN_FECHA').AsString;
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_CODIGO').AsString);
          ItemPln.SubItems.Add(IntToStr(Dst.FieldByName('PLN_NRO_REV').AsInteger));
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_DESCRIPCION').AsString);
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_USUARIO_ALTA').AsString);
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_USUARIO_APR').AsString);
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_FECHA_APR').AsString);
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_USUARIO_REC').AsString);
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_FECHA_REC').AsString);
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_UBICACION').AsString);
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_ESTADO').AsString);
          ItemPln.SubItems.Add(Dst.FieldByName('PLN_SUPERADO').AsString);

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

function TManualDB.Alta(M: TManuales; Tabla: string): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;
begin
  Result:= PLN_ALTA_FAILED;
  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

   // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    sSQL:= Format('insert into ' + Tabla +
                  ' ( PLN_CODIGO ' +
                  ', PLN_DESCRIPCION ' +
                  ', PLN_NRO_REV ' +
                  ', PLN_NRO_EDIC ' +
                  ', PLN_ESTADO ' +
                  ', PLN_FECHA ' +
                  ', PLN_USUARIO_ALTA ' +
                  ', PLN_USUARIO_APR ' +
                  ', PLN_FECHA_APR ' +
                  ', PLN_USUARIO_REC ' +
                  ', PLN_FECHA_REC ' +
                  ', PLN_UBICACION ' +
                  ', USUARIO_CREACION ' +
                  ', FECHA_CREACION ' +
                  ', USUARIO_MODIF ' +
                  ', FECHA_MODIF )' +
                  ' VALUES (%s, %s, %d, %d, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
                    , [Formatear(M.CodigoM), Formatear(M.DescripcionM), M.RevisionM,
                       M.EdicionM,Formatear(M.EstadoM), Formatear(M.FechaM),
                       Formatear(M.UsuarioAltaM),
                       Formatear(M.UsuarioAprobacionM), Formatear(M.FechaAprobacionM),
                       Formatear(M.UsuarioRecepcionM), Formatear(M.FechaRecepcionM),
                       Formatear(M.UbicacionM),
                       Formatear(M.UsuarioCreacionM), Formatear(M.FechaCreacionM),
                       Formatear(M.UsuarioModifM), Formatear(M.FechaModifM)]);
    try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= PLN_ALTA_OK;

        MSQL.CloseConn;
      end;
    except
      Result:= PLN_ALTA_FAILED;
    end;
  end;
end;

function TManualDB.Superar(MH: TManuales; MN: TManuales): Integer;
var
  CodRet: Integer;
begin
  CodRet:= PLN_SUPERAR_FAILED;
  if Alta(MH, TAB_HISTORICO_MANUAL) = PLN_ALTA_OK then
    if Baja(MH, TAB_MANUAL) = PLN_BAJA_OK then
      if Alta(MN, TAB_MANUAL) = PLN_ALTA_OK then
        CodRet:= PLN_SUPERAR_OK;

  Result:= CodRet;

end;
//-----------------------------------------------------------------------------
function TManualDB.Baja(M: TManuales; Tabla: string): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;

begin
  Result:= PLN_BAJA_FAILED;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    sSQL:= 'delete from ' + Tabla + ' where PLN_CODIGO = ' + Formatear(M.CodigoM)+ ' and PLN_NRO_REV = ' + IntToStr(M.RevisionM) +
           ' and PLN_DESCRIPCION = ' + Formatear(M.DescripcionM);

    try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= PLN_BAJA_OK;

        MSQL.CloseConn;
      end;
    except
      Result:= PLN_BAJA_FAILED;
    end;
  end;
end;
//-----------------------------------------------------------------------------

function TManualDB.Modificacion(M: TManuales): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;

begin
  Result:= PLN_MODIF_FAILED;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    sSQL:= Format('update MANUALESPRODUCTO ' +
                  'set PLN_DESCRIPCION = %s ' +
                  ', PLN_UBICACION = %s ' +
                  ', USUARIO_MODIF = %s ' +
                  ', FECHA_MODIF = %s ' +
                  'where PLN_CODIGO = %s'
                    , [Formatear(M.DescripcionM),
                       Formatear(M.UbicacionM),
                       Formatear(TSistema.GetInstance.GetUsuario.Logon),
                       Formatear(DateToStr(Date)),
                       Formatear(M.CodigoM)]);
    try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= PLN_MODIF_OK;

        MSQL.CloseConn;
      end;
    except
      Result:= PLN_MODIF_FAILED;
    end;
  end;
end;
//-----------------------------------------------------------------------------

function TManualDB.Aprobar(M: TManuales): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;

begin
  Result:= PLN_APR_FAILED;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    sSQL:= Format('update MANUALESPRODUCTO ' +
                  'set PLN_USUARIO_APR = %s ' +
                  ', PLN_FECHA_APR = %s ' +
                  ', PLN_ESTADO = %s ' +
                  ', USUARIO_MODIF = %s ' +
                  ', FECHA_MODIF = %s ' +
                  'where PLN_CODIGO = %s'
                    , [Formatear(TSistema.GetInstance.GetUsuario.Logon),
                       Formatear(DateToStr(Date)),
                       Formatear(PLN_EST_PEND_REC),
                       Formatear(TSistema.GetInstance.GetUsuario.Logon),
                       Formatear(DateToStr(Date)),
                       Formatear(M.Codigom)]);
    try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= PLN_APR_OK;

        MSQL.CloseConn;
      end;
    except
      Result:= PLN_APR_FAILED;
    end;
  end;
end;
//-----------------------------------------------------------------------------
function TManualDB.Recibir(M: TManuales): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;

begin
  Result:= PLN_REC_FAILED;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    sSQL:= Format('update MANUALESPRODUCTO ' +
                  'set PLN_USUARIO_REC = %s ' +
                  ', PLN_FECHA_REC = %s ' +
                  ', PLN_ESTADO = %s ' +
                  ', USUARIO_MODIF = %s ' +
                  ', FECHA_MODIF = %s ' +
                  'where PLN_CODIGO = %s'
                    , [Formatear(TSistema.GetInstance.GetUsuario.Logon),
                       Formatear(DateToStr(Date)),
                       Formatear(PLN_EST_ACTIVO),
                       Formatear(TSistema.GetInstance.GetUsuario.Logon),
                       Formatear(DateToStr(Date)),
                       Formatear(M.CodigoM)]);
    try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= PLN_REC_OK;

        MSQL.CloseConn;
      end;
    except
      Result:= PLN_REC_FAILED;
    end;
  end;
end;

//-----------------------------------------------------------------------------

function TManualDB.GetManual(M: TManuales;E: TEstadoManual): Boolean;
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

    sSQL:= 'select PLN_CODIGO ' +
                  ', PLN_DESCRIPCION ' +
                  ', PLN_NRO_REV ' +
                  ', PLN_NRO_EDIC ' +
                  ', PLN_ESTADO ' +
                  ', PLN_FECHA ' +
                  ', PLN_USUARIO_ALTA ' +
                  ', PLN_USUARIO_APR ' +
                  ', PLN_FECHA_APR ' +
                  ', PLN_USUARIO_REC ' +
                  ', PLN_FECHA_REC ' +
                  ', PLN_UBICACION ' +
                  ', USUARIO_CREACION ' +
                  ', FECHA_CREACION ' +
                  ', USUARIO_MODIF ' +
                  ', FECHA_MODIF ' +
            ' from MANUALESPRODUCTO ' +
            ' where PLN_CODIGO = ' + Formatear(M.CodigoM);


    if E = PLN_EST_SUPERABLE then
    //  sSQL:= sSQL + ' and PLN_ESTADO in (''AC'', ''PR'')'
     sSQL:= sSQL + ' and PLN_ESTADO in (''AC'')'
    else if E <> PLN_EST_TODOS then
      sSQL:= sSQL + ' and PLN_ESTADO = ''' + E + '''';

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= sSQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        M.CodigoM:= Dst.FieldByName('PLN_CODIGO').AsString;
        M.DescripcionM:= Dst.FieldByName('PLN_DESCRIPCION').AsString;
        M.RevisionM:= Dst.FieldByName('PLN_NRO_REV').AsInteger;
        M.EdicionM:= Dst.FieldByName('PLN_NRO_EDIC').AsInteger;
        M.EstadoM:= Dst.FieldByName('PLN_ESTADO').AsString;
        M.FechaM:= Dst.FieldByName('PLN_FECHA').AsString;
        M.UsuarioAltaM:= Dst.FieldByName('PLN_USUARIO_ALTA').AsString;
        M.UsuarioAprobacionM:= Dst.FieldByName('PLN_USUARIO_APR').AsString;
        M.FechaAprobacionM:= Dst.FieldByName('PLN_FECHA_APR').AsString;
        M.UsuarioRecepcionM:= Dst.FieldByName('PLN_USUARIO_REC').AsString;
        M.FechaRecepcionM:= Dst.FieldByName('PLN_FECHA_REC').AsString;
        M.UbicacionM:= Dst.FieldByName('PLN_UBICACION').AsString;
        M.UsuarioCreacionM:= Dst.FieldByName('USUARIO_CREACION').AsString;
        M.FechaCreacionM:= Dst.FieldByName('FECHA_CREACION').AsString;
        M.UsuarioModifM:= Dst.FieldByName('USUARIO_MODIF').AsString;
        M.FechaModifM:= Dst.FieldByName('FECHA_MODIF').AsString;
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

 function TManualDB.GenerarManual(M: TManuales): Boolean;
 var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;
  CodNum: Integer;
  CodSerie: Integer;
  CodMax: string;
 begin
  Result:= False;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

   if MSQL.GetStatus = 0 then
  begin

    sSQL:= 'select max(PLN_CODIGO) as CodMax from MANUALESPRODUCTO';

    Dst:= TADODataset.Create(nil);
    try
      // Obtengo la conexion a la BD
      Dst.Connection:= MSQL.GetConn;
      Dst.CommandText:= sSQL;
      Dst.Open;
      CodMax:= Dst.FieldByName('CodMax').AsString;
      if CodMax <> '' then
      begin
        CodSerie:= StrToInt(Copy(CodMax, 3, 1));
        CodNum:= StrToInt(Copy(CodMax, 5, 3))+1;

        if CodNum > 999 then
        begin
          Inc(CodSerie);
          CodNum:= 1;
        end;
          M.CodigoM:= 'EB'+IntToStr(CodSerie)+'-'+LPad(IntToStr(CodNum), 3, '0');
      end
      else

        M.CodigoM:= 'EB4-001';

        Dst.Close;
        MSQL.CloseConn;
        Result:= True;
    finally
      Dst.Free;
    end;
  end;

 end;
 //-----------------------------------------------------------------------------
end.
