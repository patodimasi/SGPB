unit ProgreesBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  self.ProgressBar1.Max:= StrToInt(self.Edit1.Text);
  self.Timer1.Enabled:= True;
  self.Button1.Enabled:= False;

end;

procedure TForm1.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key In  ['0'..'9',#8]) then
      Key := #0;
end;
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with self.ProgressBar1 do
    begin
      StepIt;
      if Position = Max then
        begin
          Position := 0;
          Self.Timer1.Enabled:= False;
          self.Button1.Enabled:= True;
         end;
     end;
end;          

end.