program wCob;

uses
  Forms,
  Windows,
  MidasLib,
  Controls,
  uPrincipal in 'uPrincipal.pas';

{Dados: TDataModule}

{$R *.res}


begin
  Application.Initialize;
  Application.Title := 'wCob Gest�o de Cobran�as';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
