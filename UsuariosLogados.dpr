program UsuariosLogados;

uses
  Forms,
  Windows,
  MidasLib,
  Controls,
  uUsuariosLogados in 'uUsuariosLogados.pas';

{Dados: TDataModule}

{$R *.res}


begin
  Application.Initialize;
  Application.Title := 'wCob Gest�o de Cobran�as';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
