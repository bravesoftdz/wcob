program SelecionaDiretorio;

uses
  Forms,
  uChConf in 'uChConf.pas' {FrmDiretorios};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := '';
  Application.Title := 'Configura��o p/ atualiza��o eCob';
  Application.CreateForm(TFrmDiretorios, FrmDiretorios);
  Application.Run;
end.
