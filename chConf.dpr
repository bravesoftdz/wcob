program chConf;

uses
  Forms,
  uChConf in 'uChConf.pas' {FrmDiretorios};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := '';
  Application.Title := 'Configura��o p/ atualiza��o SGT';
  Application.CreateForm(TFrmDiretorios, FrmDiretorios);
  Application.Run;
end.
