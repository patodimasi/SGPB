unit UObjectDB;

interface
type
  TObjectDB = class(TObject)
  protected
    function Formatear(S: string): string;
    function LPad(S: string; N: Integer; C: Char): string;
  end;

implementation
uses
  SysUtils;

function TObjectDB.Formatear(S: string): string;
begin
  if S = '' then
    Result:= 'NULL'
  else
    Result:= QuotedStr(S);
end;

function TObjectDB.LPad(S: string; N: Integer; C: Char): string;
var
  Ret: string;
  Len: Integer;
  I: Integer;
begin
  Ret:= '';
  Len:= Length(S);
  if Len <= N then
  begin
    Ret:= S;
    for I:= 1 to N-Len do
      Ret:= C + Ret;
  end;

  Result:= Ret;
end;

end.
 