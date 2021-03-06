unit UListaDB;

interface
uses
  UObjectDB, UMotorSQL, ULista, ComCtrls;

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
  TListaDB = class(TObjectDB)
  public
     function ConsultaPendientes(ListView: TListView; TipoPend: Integer): Boolean;
     function CumplirTareasSel(TipoPend: Integer; sCodigos: string): Integer;
     function CumplirTareasTodos(TipoPend: Integer): Integer;
     function Consulta(ListView: TListView; SQL: string): Boolean;
     function Aprobar(L: TLista): Integer;
     function Recibir(L: TLista): Integer;
     function GetLista(L: TLista; E: TEstadoLista): Boolean;
     function Modificacion(L: TLista): Integer;
  
  end;

implementation
uses
  SysUtils, ADODB, USistema, Classes, StrUtils;


function TListaDB.Modificacion(L: TLista): Integer;
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
    sSQL:= Format('update MATERIALES ' +
                  'set PLN_DESCRIPCION = %s ' +
                  ', PLN_UBICACION = %s ' +
                  ', USUARIO_MODIF = %s ' +
                  ', FECHA_MODIF = %s ' +
                  'where PLN_CODIGO = %s'
                    , [Formatear(L.Descripcion),
                       Formatear(L.Ubicacion),
                       Formatear(TSistema.GetInstance.GetUsuario.Logon),
                       Formatear(DateToStr(Date)),
                       Formatear(L.Codigo)]);
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

function TListaDB.Recibir(L: TLista): Integer;
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
    sSQL:= Format('update MATERIALES ' +
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
                       Formatear(L.Codigo)]);
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

function TListaDB.GetLista(L: TLista; E: TEstadoLista): Boolean;
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
            ' from MATERIALES ' +
            ' where PLN_CODIGO = ' + Formatear(L.Codigo);


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
        L.Codigo:= Dst.FieldByName('PLN_CODIGO').AsString;
        L.Descripcion:= Dst.FieldByName('PLN_DESCRIPCION').AsString;
        L.Revision:= Dst.FieldByName('PLN_NRO_REV').AsInteger;
        L.Edicion:= Dst.FieldByName('PLN_NRO_EDIC').AsInteger;
        L.Estado:= Dst.FieldByName('PLN_ESTADO').AsString;
        L.Fecha:= Dst.FieldByName('PLN_FECHA').AsString;
        L.UsuarioAlta:= Dst.FieldByName('PLN_USUARIO_ALTA').AsString;
        L.UsuarioAprobacion:= Dst.FieldByName('PLN_USUARIO_APR').AsString;
        L.FechaAprobacion:= Dst.FieldByName('PLN_FECHA_APR').AsString;
        L.UsuarioRecepcion:= Dst.FieldByName('PLN_USUARIO_REC').AsString;
        L.FechaRecepcion:= Dst.FieldByName('PLN_FECHA_REC').AsString;
        L.Ubicacion:= Dst.FieldByName('PLN_UBICACION').AsString;
        L.UsuarioCreacion:= Dst.FieldByName('USUARIO_CREACION').AsString;
        L.FechaCreacion:= Dst.FieldByName('FECHA_CREACION').AsString;
        L.UsuarioModif:= Dst.FieldByName('USUARIO_MODIF').AsString;
        L.FechaModif:= Dst.FieldByName('FECHA_MODIF').AsString;
        Result:= True;
      end;
      Dst.Close;
      MSQL.CloseConn;
    finally
      Dst.Free;
    end;
  end;
end;

function TListaDB.Aprobar(L: TLista): Integer;
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
    sSQL:= Format('update MATERIALES ' +
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
                       Formatear(L.Codigo)]);
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
// CONSULTA
//-----------------------------------------------------------------------------
function TListaDB.Consulta(ListView: TListView; SQL: string): Boolean;
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

//-----------------------------------------------------------------------------
// APROBAR O RECIBIR TODAS LAS LISTAS DE MATERIALES
//-----------------------------------------------------------------------------
function TListaDB.CumplirTareasTodos(TipoPend: Integer): Integer;
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
        sSQL:= 'update MATERIALES ' +
               'set PLN_USUARIO_APR = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
               ' , PLN_FECHA_APR = ' + Formatear(DateToStr(Date)) +
               ' , PLN_ESTADO = ' + Formatear(PLN_EST_PEND_REC) +
               ' , USUARIO_MODIF = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
               ' , FECHA_MODIF = ' + Formatear(DateToStr(Date)) +
               ' where PLN_ESTADO = ''PA''';
      PLN_PEND_REC:
        sSQL:= 'update MATERIALES ' +
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
// APROBAR O RECIBIR LAS LISTAS SELECCIONADOS
//-----------------------------------------------------------------------------
function TListaDB.CumplirTareasSel(TipoPend: Integer; sCodigos: string): Integer;
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
                 'from MATERIALES ' +
                 ' where PLN_CODIGO in (' + sCodigos + ') ' +
                 ' and PLN_ESTADO = ''PR''';
        PLN_PEND_REC:
          sSQL:= 'select 1 as Existe ' +
                 'from MATERIALES ' +
                 ' where PLN_CODIGO in (' + sCodigos + ') ' +
                 ' and PLN_ESTADO = ''PA''';
      end;

      Dst.CommandText:= sSQL;
      Dst.Open;
      if Dst.IsEmpty then
      begin
        case TipoPend of
          PLN_PEND_APR:
            sSQL:= 'update MATERIALES ' +
                   'set PLN_USUARIO_APR = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
                   ' , PLN_FECHA_APR = ' + Formatear(DateToStr(Date)) +
                   ' , PLN_ESTADO = ' + Formatear(PLN_EST_PEND_REC) +
                   ' , USUARIO_MODIF = ' + Formatear(TSistema.GetInstance.GetUsuario.Logon) +
                   ' , FECHA_MODIF = ' + Formatear(DateToStr(Date)) +
                   ' where PLN_CODIGO in (' + sCodigos + ') ' +
                   ' and PLN_ESTADO = ''PA''';
          PLN_PEND_REC:
            sSQL:= 'update MATERIALES ' +
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

function TListaDB.ConsultaPendientes(ListView: TListView; TipoPend: Integer): Boolean;
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
                 'from MATERIALES where PLN_ESTADO in (''PA'', ''PR'')';
        PLN_PEND_APR:
          sSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION, PLN_ESTADO, PLN_UBICACION ' +
                 'from MATERIALES where PLN_ESTADO in (''PA'')';
        PLN_PEND_REC:
          sSQL:= 'select PLN_CODIGO, PLN_NRO_REV, PLN_DESCRIPCION, PLN_ESTADO, PLN_UBICACION ' +
                 'from MATERIALES where PLN_ESTADO in (''PR'')';
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

end.
