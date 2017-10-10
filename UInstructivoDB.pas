unit UInstructivoDB;

interface
uses
  UObjectDB, UMotorSQL, UInstructivo, ComCtrls;
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
  TInstructivoDB = class(TObjectDB)
  public
   function Consulta(ListView: TListView; SQL: string): Boolean;
   function Alta(I: TInstructivo; Tabla: string;superado: string): Integer;
   function GenerarInstructivo(I: TInstructivo): Boolean;
  end;

implementation
uses
  SysUtils, ADODB, USistema, Classes, StrUtils;

function TInstructivoDB.GenerarInstructivo(I: TInstructivo): Boolean;
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

    sSQL:= 'select max(PLN_CODIGO) as CodMax from INSTRUCTIVOSPRODUCCION ';

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
        I.Codigo:= 'IB'+IntToStr(CodSerie)+'-'+LPad(IntToStr(CodNum), 3, '0');

      end
      else
       I.Codigo:= 'IB9-001';

       Dst.Close;
       MSQL.CloseConn;
       Result:= True;
    finally
      Dst.Free;
    end;
  end;
end;

function TInstructivoDB.Alta(I: TInstructivo; Tabla: string;superado: string): Integer;
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
                    , [Formatear(I.Codigo), Formatear(I.Descripcion), I.Revision,
                       I.Edicion, Formatear(I.Estado), Formatear(I.Fecha),
                       Formatear(I.UsuarioAlta),
                       Formatear(I.UsuarioAprobacion), Formatear(I.FechaAprobacion),
                       Formatear(I.UsuarioRecepcion), Formatear(I.FechaRecepcion),
                       Formatear(I.Ubicacion), QuotedStr(superado),
                       Formatear(I.UsuarioCreacion), Formatear(I.FechaCreacion),
                       Formatear(I.UsuarioModif), Formatear(I.FechaModif)]);
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

function TInstructivoDB.Consulta(ListView: TListView; SQL: string): Boolean;
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

end.
