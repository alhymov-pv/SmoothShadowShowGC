program sssGC;

uses
  Vcl.Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  GDIPChildFormUnit in 'GDIPChildFormUnit.pas',
  VCLChildFormUnit in 'VCLChildFormUnit.pas',
  GDIPlusImport in 'GDIPlusImport.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
