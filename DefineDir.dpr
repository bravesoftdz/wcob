program DefineDir;

uses
  Forms,
  uDefineDir in 'uDefineDir.pas' {FrmDiretorios};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := '';
  Application.Title := 'Configura��o p/ atualiza��o WigCred';
  Application.CreateForm(TFrmDiretorios, FrmDiretorios);
  Application.Run;
end.