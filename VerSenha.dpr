program VerSenha;

uses
  Forms,
  Windows,
  MidasLib,
  Controls,
  uVerSenha in 'uVerSenha.pas';

{Dados: TDataModule}

{$R *.res}


begin
  Application.Initialize;
  Application.Title := 'wCob Gest�o de Cobran�as';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
