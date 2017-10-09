unit TreeUtils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;



function IsDuplicateName(  Node : TTreeNode;
                           sNewName : string;
                           bInclusive : boolean
                         ) : boolean;


implementation

function IsDuplicateName(  Node : TTreeNode;
                           sNewName : string;
                           bInclusive : boolean
                         ) : boolean;
var
   TestNode : TTreeNode;
begin
   if(  Node = nil  ) then
   begin
      Result := false;
      Exit;
   end;

      {Include this Node?}
   if(  bInclusive  ) then
      if(   CompareText(  Node.Text,  sNewName  ) = 0   ) then
      begin
         Result := true;
         Exit;
      end;


      {Test all previous siblings}
   TestNode := Node;
   repeat
         {Get next}
      TestNode := TestNode.GetPrevSibling;

      if(  TestNode <> nil  ) then
            {Is this a duplicate}
         if(   CompareText(  TestNode.Text,  sNewName  ) = 0   ) then
         begin
            Result := true;
            Exit;
         end;
   until (TestNode = nil);


      {Test all next siblings}
   TestNode := Node;
   repeat
         {Get next}
      TestNode := TestNode.GetNextSibling;

      if(  TestNode <> nil  ) then
            {Is this a duplicate}
         if(   CompareText(  TestNode.Text,  sNewName  ) = 0   ) then
         begin
            Result := true;
            Exit;
         end;
   until (TestNode = nil);

   Result := false;
end;





end.
