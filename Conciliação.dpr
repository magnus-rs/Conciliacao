program Conciliação;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {Form1},
  Divergências in 'Divergências.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
