program ServidorSac;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FMain},
  ControllerCadastros in 'ControllerCadastros.pas',
  ControllerConfiguracao in 'ControllerConfiguracao.pas',
  ClasseConfiguracao in 'ClasseConfiguracao.pas',
  classeportadores in 'classeportadores.pas',
  classeclientes in 'classeclientes.pas',
  classeprodutos in 'classeprodutos.pas',
  classeprecos in 'classeprecos.pas',
  classecondicao in 'classecondicao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
