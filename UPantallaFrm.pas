unit UPantallaFrm;

interface
uses
  Forms, UPlanoDB;

type
  TPantallaFrm = class(TForm)
    protected
      FMainForm: TForm;
      FLocked: Boolean;
      function PantallaLockeada(Pantalla: string): Boolean;
    published
      property MainForm: TForm read FMainForm write FMainForm;
  end;

implementation
uses
  USistema, Dialogs;


function TPantallaFrm.PantallaLockeada(Pantalla: string): Boolean;
var
  P: string;
  U: string;
begin
  Result:= False;
  if TSistema.GetInstance.IsLocked(Pantalla) then
  begin
    U:= TSistema.GetInstance.LockedByUser(Pantalla);
    P:= TSistema.GetInstance.LockedByScreenDesc(Pantalla);
    ShowMessage('La pantalla permanecerá inhabilitada hasta que el usuario ' +
                U + ' abandone la pantalla de ' + P);
    FLocked:= True;
    Result:= True;
  end;
end;

end.

