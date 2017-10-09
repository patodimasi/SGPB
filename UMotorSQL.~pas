unit UMotorSQL;

interface
uses
  ADODB,UUSuario;

type
  TMotorSQL = class(TObject)
  private
    FStatus: Integer;
    FConn: TADOConnection;
    FDataBase: string;
    constructor Create;
  public
    function GetStatus: Integer;
    class function GetInstance: TMotorSQL;
    destructor Destroy; override;
    procedure SetDataBase(S: string);
    procedure OpenConn;
    function GetConn: TADOConnection;
    procedure CloseConn;
    function ExecuteSQL(SQL: string):integer;
    procedure Commit;
    procedure Rollback;
    procedure LeerArchivoError(Error,Error1,usu,dia: string);
    //function DatabaseCompact: Boolean;
  end;

implementation
uses
  SysUtils,Usistema;

var
  // Es una clase singleton
  MotorSQL: TMotorSQL;

function TMotorSQL.GetStatus: Integer;
begin
  Result:= FStatus;
end;

class function TMotorSQL.GetInstance: TMotorSQL;
begin
  Result:= MotorSQL;
end;

constructor TMotorSQL.Create;
begin
  FConn:= nil;
  FStatus:= 0;
end;

procedure TMotorSQL.SetDataBase(S: string);
begin
  FDataBase:= S;
end;

procedure TMotorSQL.OpenConn;
begin
  FStatus:= 0;
  try
    FConn:= TADOConnection.Create(nil);
    FConn.ConnectionString:= 'Provider=Microsoft.Jet.OLEDB.4.0;'
                             + 'Data Source='
                             + FDataBase
                             + ';'
                             + 'Persist Security Info=False';
    FConn.LoginPrompt:= False;
    FConn.CursorLocation:= ClUseServer;
    FConn.Open;

  except
    FStatus:= 1;
  end;

end;

function TMotorSQL.GetConn: TADOConnection;
begin
  FStatus:= 0;
  Result:= nil;
  if Assigned(FConn) then
    Result:= FConn
  else
    FStatus:= 1;
end;

destructor TMotorSQL.Destroy;
begin
  if Assigned(FConn) then
     FConn.Free;
end;
procedure TMotorSql.LeerArchivoError(Error,Error1,usu,dia: string);
var
  myFile : TextFile;
  fileString: string;
  sMsj1,sMsj2,sMsj3: string;
  cTemp: string;
begin
  cTemp:= (Copy(Tsistema.getInstance.GetDataBaseFilename,1,Pos('SGPB.mdb',Tsistema.getInstance.GetDataBaseFilename)-1));
  cTemp:= Ctemp + 'Error.txt';
  fileString:=  cTemp;
  AssignFile (myFile,fileString);

     if FileExists(fileString) then
     begin
     try
      Append(myFile);
      WriteLn(myFile,Error);
      WriteLn(myFile,Error1);
      WriteLn(myFile,usu);
       WriteLn(myFile,dia);
       finally
       CloseFile(myfile);
      end;
     end
   else
   begin
     Rewrite(myfile);
     WriteLn(myFile,Error);
     WriteLn(myFile,Error1);
     WriteLn(myFile,usu);
      WriteLn(myFile,dia);
     CloseFile(myfile);
  end;
 end;
procedure TMotorSQL.CloseConn;
begin
  FStatus:= 0;
  if Assigned(FConn) then
    try
      FConn.Close
    except
      FStatus:= 1;
    end
  else
    FStatus:= 1;
end;
function TMotorSQL.ExecuteSQL(SQL: string):integer;
var
 sMsj2,sMsj1: string;
 usuario: TUsuario;
 nombre: string;
 dia: string;
 iRegistrosAfectados:integer;
begin
  iRegistrosAfectados := 0;
  try
    if Assigned(FConn) then
      try
        FConn.BeginTrans;
        FConn.Execute(SQL, iRegistrosAfectados);
      except
      on E: Exception do
        begin
         usuario:= TUsuario.Create;
         usuario:= Tsistema.GetInstance.GetUsuario;
         nombre:= usuario.Nombre;
         dia:= DateToStr(Date);
         sMsj1:= E.Message;
         sMsj2:= 'Tipo de error: ' + E.ClassName;
         self.LeerArchivoError(sMsj2,sMsj1,nombre,dia);
         raise;
        end;
    end;
  finally
    result := iRegistrosAfectados;
  end;
end;
procedure TMotorSQL.Commit;
begin
  FStatus:= 0;
  if Assigned(FConn) then
    try
      FConn.CommitTrans;
    except
      Rollback;
    end
  else
    FStatus:= 1;
end;
procedure TMotorSQL.Rollback;
begin
  FStatus:= 0;

  if Assigned(FConn) then
    try
      FConn.RollbackTrans;
    except
      FStatus:= 1;
    end
  else
    FStatus:= 1;
end;
(*
function TMotorSQL.DatabaseCompact: Boolean;
var
  JE: TJetEngine;
  sTemp: string;
  sTempConn: string;

const
  SProvider = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=';

begin
  Result:= False;

  sTemp:= FDataBase + '$$$';
  sTempConn := SProvider + sdbtemp;
  if FileExists(sTemp) then
    DeleteFile(sTemp);

  JE:= TJetEngine.Create(Application);
  try
    try
      JE.CompactDatabase(SProvider + FDataBase, sTempConn);
      DeleteFile(FDataBase);
      RenameFile(sTemp, FDataBase);
    except
      on E:Exception do
        ShowMessage('No se pudo compactar la base de datos');
    end;
  finally
    JE.FreeOnRelease;
    Result:= True;
  end;
end;
*)
initialization

if not Assigned(MotorSQL) then
  MotorSQL:= TMotorSQL.Create;

finalization

if Assigned(MotorSQL) then
begin
  MotorSQL.Free;
end;

end.
