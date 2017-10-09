unit UPlanoDB;

interface
uses
  UObjectDB, UMotorSQL, UPlano, ComCtrls;

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
  TPlanoDB = class(TObjectDB)
  public
    function Alta(P: TPlano; Tabla: string;superado: string): Integer;
    function AltaMasiva(P: TPlano; TablaIns: string; TablaSel: string): Integer;
    function Baja(P: TPlano; Tabla: string): Integer;
    function BajaMasiva(Tabla: string): Integer;
    function Modificacion(P: TPlano): Integer;
    function Aprobar(P: TPlano): Integer;
    function Recibir(P: TPlano): Integer;
    function GetPlano(P: TPlano; E: TEstadoPlano): Boolean;
    function GenerarPlano(P: TPlano): Boolean;
    function Consulta(ListView: TListView; SQL: string): Boolean;
    function ConsultaPendientes(ListView: TListView; TipoPend: Integer): Boolean;
    function ConsultaPurgar(ListView: TListView): Boolean;
    function Superar(PH: TPlano; PN: TPlano): Integer;
    function ConsultaBaja(ListView: TListView; Plano: TPlano; Tipo: Integer): Boolean;
    function MigrarBaja(P: TPlano): Integer;
    function Recuperar(P: TPlano): Integer;
    function CumplirTareasTodos(TipoPend: Integer): Integer;
    function CumplirTareasSel(TipoPend: Integer; sCodigos: string): Integer;
  end;

implementation
uses
  SysUtils, ADODB, USistema, Classes, StrUtils;

function TPlanoDB.ConsultaPendientes(ListView: TListView; TipoPend: Integer): Boolean;
var
  MSQL: TMotorSQL;
  Dst: TADODataset;
  ItemPl: TListItem;
  Estado: string;
  sSQL: string;

begin
  Result:= False;
  Estado:= '';
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
      case TipoPend of
        PLN_PEND_TODOS:
          sSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION, PLN_ESTADO, PLN_UBICACION ' +
                 'from PLANO where PLN_ESTADO in (''PA'', ''PR'')';
        PLN_PEND_APR:
          sSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION, PLN_ESTADO, PLN_UBICACION ' +
                 'from PLANO where PLN_ESTADO in (''PA'')';
        PLN_PEND_REC:
          sSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION, PLN_ESTADO, PLN_UBICACION ' +
                 'from PLANO where PLN_ESTADO in (''PR'')';
      end;

      Dst.CommandText:= sSQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        while not Dst.Eof do
        begin
          ItemPl:= ListView.Items.Add;
          ItemPl.Caption:= Dst.FieldByName('PLN_CODIGO').AsString;
          ItemPl.SubItems.Add(Dst.FieldByName('PLN_NRO_REV').AsString);
          ItemPl.SubItems.Add(Dst.FieldByName('PLN_DESCRIPCION').AsString);
          Estado:= Dst.FieldByName('PLN_ESTADO').AsString;

          if Estado = PLN_EST_PEND_APR then
            ItemPl.SubItems.Add('Pendiente de aprobación')
          else if Estado = PLN_EST_PEND_REC then
            ItemPl.SubItems.Add('Pendiente de recepción');

          ItemPl.SubItems.Add(Dst.FieldByName('PLN_UBICACION').AsString);

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
// DA DE ALTA EL PLANO
//-----------------------------------------------------------------------------
function TPlanoDB.Alta(P: TPlano; Tabla: string; superado: string): Integer;
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
                  ', PLN_SUPERADO ' +
                  ', USUARIO_CREACION ' +
                  ', FECHA_CREACION ' +
                  ', USUARIO_MODIF ' +
                  ', FECHA_MODIF )' +
                  ' VALUES (%s, %s, %d, %d, %s, %s, %s, %s, %s, %s, %s, %s,%s, %s, %s, %s, %s)'
                    , [Formatear(P.Codigo), Formatear(P.Descripcion), P.Revision,
                       P.Edicion, Formatear(P.Estado), Formatear(P.Fecha),
                       Formatear(P.UsuarioAlta),
                       Formatear(P.UsuarioAprobacion), Formatear(P.FechaAprobacion),
                       Formatear(P.UsuarioRecepcion), Formatear(P.FechaRecepcion),
                       Formatear(P.Ubicacion), QuotedStr(superado),
                       Formatear(P.UsuarioCreacion), Formatear(P.FechaCreacion),
                       Formatear(P.UsuarioModif), Formatear(P.FechaModif)]);
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
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// ALTA MASIVA DE PLANOS
//-----------------------------------------------------------------------------
function TPlanoDB.AltaMasiva(P: TPlano; TablaIns: string; TablaSel: string): Integer;
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
    sSQL:= 'insert into ' + TablaIns +
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
           ' select PLN_CODIGO ' +
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
           'from ' + TablaSel + ' where PLN_CODIGO = ' + Formatear(P.Codigo);
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
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// APROBAR PLANO
//-----------------------------------------------------------------------------
function TPlanoDB.Modificacion(P: TPlano): Integer;
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
    sSQL:= Format('update PLANO ' +
                  'set PLN_DESCRIPCION = %s ' +
                  ', PLN_UBICACION = %s ' +
                  ', USUARIO_MODIF = %s ' +
                  ', FECHA_MODIF = %s ' +
                  'where PLN_CODIGO = %s'
                    , [Formatear(P.Descripcion),
                       Formatear(P.Ubicacion),
                       Formatear(TSistema.GetInstance.GetUsuario.Logon),
                       Formatear(DateToStr(Date)),
                       Formatear(P.Codigo)]);
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


//-----------------------------------------------------------------------------
// RECUPERA EL PLANO SOLICITADO
//-----------------------------------------------------------------------------
function TPlanoDB.GetPlano(P: TPlano; E: TEstadoPlano): Boolean;
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
            ' from PLANO ' +
            ' where PLN_CODIGO = ' + Formatear(P.Codigo);


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
        P.Codigo:= Dst.FieldByName('PLN_CODIGO').AsString;
        P.Descripcion:= Dst.FieldByName('PLN_DESCRIPCION').AsString;
        P.Revision:= Dst.FieldByName('PLN_NRO_REV').AsInteger;
        P.Edicion:= Dst.FieldByName('PLN_NRO_EDIC').AsInteger;
        P.Estado:= Dst.FieldByName('PLN_ESTADO').AsString;
        P.Fecha:= Dst.FieldByName('PLN_FECHA').AsString;
        P.UsuarioAlta:= Dst.FieldByName('PLN_USUARIO_ALTA').AsString;
        P.UsuarioAprobacion:= Dst.FieldByName('PLN_USUARIO_APR').AsString;
        P.FechaAprobacion:= Dst.FieldByName('PLN_FECHA_APR').AsString;
        P.UsuarioRecepcion:= Dst.FieldByName('PLN_USUARIO_REC').AsString;
        P.FechaRecepcion:= Dst.FieldByName('PLN_FECHA_REC').AsString;
        P.Ubicacion:= Dst.FieldByName('PLN_UBICACION').AsString;
        P.UsuarioCreacion:= Dst.FieldByName('USUARIO_CREACION').AsString;
        P.FechaCreacion:= Dst.FieldByName('FECHA_CREACION').AsString;
        P.UsuarioModif:= Dst.FieldByName('USUARIO_MODIF').AsString;
        P.FechaModif:= Dst.FieldByName('FECHA_MODIF').AsString;
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
// GENERAR NUEVO PLANO
//-----------------------------------------------------------------------------
function TPlanoDB.GenerarPlano(P: TPlano): Boolean;
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

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin

    sSQL:= 'select max(PLN_CODIGO) as CodMax from PLANO ';

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
       // CodNum:= StrToInt(Copy(CodMax, 5, 3))+1;
       CodNum:= StrToInt(Copy(CodMax, 5, 4))+1;

        //if CodNum > 999 then
        if CodNum > 9999 then
        begin
          Inc(CodSerie);
          CodNum:= 1;
        end;

        //P.Codigo:= 'DB'+IntToStr(CodSerie)+'-'+LPad(IntToStr(CodNum), 3, '0');
          P.Codigo:= 'DB'+IntToStr(CodSerie)+'-'+LPad(IntToStr(CodNum), 4, '0');
      end
      else
        //P.Codigo:= 'DB4-001';
        P.Codigo:= 'DB4-0001';

      Dst.Close;
      MSQL.CloseConn;
      Result:= True;
    finally
      Dst.Free;
    end;
  end;
end;
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// APROBAR PLANO
//-----------------------------------------------------------------------------
function TPlanoDB.Aprobar(P: TPlano): Integer;
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
    sSQL:= Format('update PLANO ' +
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
                       Formatear(P.Codigo)]);
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

//-----------------------------------------------------------------------------
// RECIBIR PLANO
//-----------------------------------------------------------------------------
function TPlanoDB.Recibir(P: TPlano): Integer;
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
    sSQL:= Format('update PLANO ' +
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
                       Formatear(P.Codigo)]);
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

//-----------------------------------------------------------------------------
// CONSULTA DE PLANOS A PURGAR
//-----------------------------------------------------------------------------
function TPlanoDB.ConsultaPurgar(ListView: TListView): Boolean;
var
  MSQL: TMotorSQL;
  Dst: TADODataset;
  ItemPl: TListItem;
  sSQL: string;

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
      sSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION, FECHA_CREACION, USUARIO_CREACION ' +
                 'from BAJA order by PLN_CODIGO, PLN_NRO_REV';
      Dst.CommandText:= sSQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        while not Dst.Eof do
        begin
          ItemPl:= ListView.Items.Add;
          ItemPl.Caption:= Dst.FieldByName('PLN_CODIGO').AsString;
          ItemPl.SubItems.Add(Dst.FieldByName('PLN_NRO_REV').AsString);
          ItemPl.SubItems.Add(Dst.FieldByName('PLN_DESCRIPCION').AsString);
          ItemPl.SubItems.Add(Dst.FieldByName('FECHA_CREACION').AsString);
          ItemPl.SubItems.Add(Dst.FieldByName('USUARIO_CREACION').AsString);

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
// DA DE ALTA EL PLANO EN EL HISTORICO
//-----------------------------------------------------------------------------
function TPlanoDB.MigrarBaja(P: TPlano): Integer;
var
  CodRet: Integer;

begin
  CodRet:= PLN_MIG_FAILED;
  if AltaMasiva(P, TAB_BAJA, TAB_PLANO) = PLN_ALTA_OK then
    if Baja(P, TAB_PLANO) = PLN_BAJA_OK then
      if AltaMasiva(P, TAB_BAJA, TAB_HISTORICO) = PLN_ALTA_OK then
        if Baja(P, TAB_HISTORICO) = PLN_BAJA_OK then
          CodRet:= PLN_MIG_OK;
   Result:= CodRet;
end;
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// DA DE BAJA EL PLANO
//-----------------------------------------------------------------------------
function TPlanoDB.Baja(P: TPlano; Tabla: string): Integer;
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
    sSQL:= 'delete from ' + Tabla + ' where PLN_CODIGO = ' + Formatear(P.Codigo)+ ' and PLN_NRO_REV = ' + IntToStr(P.Revision) +
           ' and PLN_DESCRIPCION = ' + Formatear(P.Descripcion);

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

//-----------------------------------------------------------------------------
// BORRA TODOS LOS REGISTROS DE LA TABLA
//-----------------------------------------------------------------------------
function TPlanoDB.BajaMasiva(Tabla: string): Integer;
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
    sSQL:= 'delete from ' + Tabla;
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

//-----------------------------------------------------------------------------
// SUPERA EL PLANO DEL PRIMER OP CON EL PLANO DEL SEGUNDO OP
//-----------------------------------------------------------------------------
function TPlanoDB.Superar(PH: TPlano; PN: TPlano): Integer;
var
  CodRet: Integer;

begin
  CodRet:= PLN_SUPERAR_FAILED;
  if Alta(PH, TAB_HISTORICO,'S') = PLN_ALTA_OK then
    if Baja(PH, TAB_PLANO) = PLN_BAJA_OK then
      if Alta(PN, TAB_PLANO,'NS') = PLN_ALTA_OK then
        CodRet:= PLN_SUPERAR_OK;

  Result:= CodRet;

end;
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CONSULTA TODAS LAS VERSIONES DEL PLANO A DAR DE BAJA
//-----------------------------------------------------------------------------
function TPlanoDB.ConsultaBaja(ListView: TListView; Plano: TPlano; Tipo: Integer): Boolean;
var
  MSQL: TMotorSQL;
  Dst: TADODataset;
  ItemPl: TListItem;
  Estado: string;
  sSQL: string;

begin
  Result:= False;
  Estado:= '';

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
      case Tipo of
        PLN_BAJA:
          sSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION ' +
                 'from PLANO where PLN_CODIGO = ' + Formatear(Plano.Codigo) +
                 ' union ' +
                 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION ' +
                 'from HISTORICO where PLN_CODIGO = ' + Formatear(Plano.Codigo);
        PLN_RECUPERAR:
          sSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION ' +
                 'from BAJA where PLN_CODIGO = ' + Formatear(Plano.Codigo);
      end;

      Dst.CommandText:= sSQL;
      Dst.Open;
      if not Dst.Eof then
      begin
        while not Dst.Eof do
        begin
          ItemPl:= ListView.Items.Add;
          ItemPl.Caption:= Dst.FieldByName('PLN_CODIGO').AsString;
          ItemPl.SubItems.Add(Dst.FieldByName('PLN_NRO_REV').AsString);
          ItemPl.SubItems.Add(Dst.FieldByName('PLN_DESCRIPCION').AsString);

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
// RECUPERA EL PLANO DADO DE BAJA
//-----------------------------------------------------------------------------
function TPlanoDB.Recuperar(P: TPlano): Integer;
begin
  Result:= 0;
end;
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// APROBAR O RECIBIR TODOS LOS PLANOS
//-----------------------------------------------------------------------------
function TPlanoDB.CumplirTareasTodos(TipoPend: Integer): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;
  iFailed: Integer;
  iOk: Integer;

begin
  iFailed:= PLN_APR_FAILED;
  iOk:= PLN_APR_OK;

  if TipoPend = PLN_PEND_REC then
  begin
    iFailed:= PLN_REC_FAILED;
    iOk:= PLN_REC_OK;
  end;

  Result:= iFailed;

  // Establezco una conexion con la BD
  MSQL:= TMotorSQL.GetInstance();
  MSQL.OpenConn;

  // Si se pudo realizar...
  if MSQL.GetStatus = 0 then
  begin
    case TipoPend of
      PLN_PEND_APR:
        sSQL:= 'update PLANO ' +
               'set PLN_USUARIO_APR = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
               ' , PLN_FECHA_APR = ' + Formatear(DateToStr(Date)) +
               ' , PLN_ESTADO = ' + Formatear(PLN_EST_PEND_REC) +
               ' , USUARIO_MODIF = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
               ' , FECHA_MODIF = ' + Formatear(DateToStr(Date)) +
               ' where PLN_ESTADO = ''PA''';
      PLN_PEND_REC:
        sSQL:= 'update PLANO ' +
               'set PLN_USUARIO_REC = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
               ' , PLN_FECHA_REC = ' + Formatear(DateToStr(Date)) +
               ' , PLN_ESTADO = ' + Formatear(PLN_EST_ACTIVO) +
               ' , USUARIO_MODIF = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
               ' , FECHA_MODIF = ' + Formatear(DateToStr(Date)) +
               ' where PLN_ESTADO = ''PR''';
    end;

    try
      MSQL.ExecuteSQL(sSQL);
      if MSQL.GetStatus = 0 then
      begin
        MSQL.Commit;
        if MSQL.GetStatus = 0 then
          Result:= iOk;

        MSQL.CloseConn;
      end;
    except
      Result:= iFailed;
    end;
  end;
end;
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// APROBAR O RECIBIR LOS PLANOS SELECCIONADOS
//-----------------------------------------------------------------------------
function TPlanoDB.CumplirTareasSel(TipoPend: Integer; sCodigos: string): Integer;
var
  sSQL: string;
  MSQL: TMotorSQL;
  Dst: TADODataset;
  iFailed: Integer;
  iOk: Integer;

begin
  iFailed:= PLN_APR_FAILED;
  iOk:= PLN_APR_OK;

  if TipoPend = PLN_PEND_REC then
  begin
    iFailed:= PLN_REC_FAILED;
    iOk:= PLN_REC_OK;
  end;

  Result:= iFailed;

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
      case TipoPend of
        PLN_PEND_APR:
          sSQL:= 'select 1 as Existe ' +
                 'from PLANO ' +
                 ' where PLN_CODIGO in (' + sCodigos + ') ' +
                 ' and PLN_ESTADO = ''PR''';
        PLN_PEND_REC:
          sSQL:= 'select 1 as Existe ' +
                 'from PLANO ' +
                 ' where PLN_CODIGO in (' + sCodigos + ') ' +
                 ' and PLN_ESTADO = ''PA''';
      end;

      Dst.CommandText:= sSQL;
      Dst.Open;
      if Dst.IsEmpty then
      begin
        case TipoPend of
          PLN_PEND_APR:
            sSQL:= 'update PLANO ' +
                   'set PLN_USUARIO_APR = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
                   ' , PLN_FECHA_APR = ' + Formatear(DateToStr(Date)) +
                   ' , PLN_ESTADO = ' + Formatear(PLN_EST_PEND_REC) +
                   ' , USUARIO_MODIF = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
                   ' , FECHA_MODIF = ' + Formatear(DateToStr(Date)) +
                   ' where PLN_CODIGO in (' + sCodigos + ') ' +
                   ' and PLN_ESTADO = ''PA''';
          PLN_PEND_REC:
            sSQL:= 'update PLANO ' +
                   'set PLN_USUARIO_REC = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
                   ' , PLN_FECHA_REC = ' + Formatear(DateToStr(Date)) +
                   ' , PLN_ESTADO = ' + Formatear(PLN_EST_ACTIVO) +
                   ' , USUARIO_MODIF = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
                   ' , FECHA_MODIF = ' + Formatear(DateToStr(Date)) +
                   ' where PLN_CODIGO in (' + sCodigos + ') ' +
                   ' and PLN_ESTADO = ''PR''';
        end;

        try
          MSQL.ExecuteSQL(sSQL);
          if MSQL.GetStatus = 0 then
          begin
            MSQL.Commit;
            if MSQL.GetStatus = 0 then
              Result:= iOk;

          end;
        except
          Result:= iFailed;
        end;
      end
      else
        Result:= PLN_SEL_ERRONEA;

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
function TPlanoDB.Consulta(ListView: TListView; SQL: string): Boolean;
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
//-----------------------------------------------------------------------------


end.

