unit uPermissao;

interface


uses
  Variants,
  Buttons,
  Dialogs,
  Classes,
  ComCtrls,
  Controls,
  DB,
  ExtCtrls,
  Forms,
  Graphics,
  ImgList,
  Menus,
  ucLayUsuario,
  ucLayUsuario_Menu,
  StdCtrls,
  NumericEdit;

type
  PTreeMenu = ^TTreeMenu;

  TTreeMenu = record
    Selecionado : Integer;
    MenuName    : String;
    TagName     : String;
  end;

  TfrmPermissao = class(TForm)
    Panel1:       TPanel;
    lblTitulo: TLabel;
    Image1:       TImage;
    Panel3:       TPanel;
    BtLibera:     TBitBtn;
    BtBloqueia:   TBitBtn;
    ImageList1:   TImageList;
    PC:           TPageControl;
    PageMenu:     TTabSheet;
    TreeMenu:     TTreeView;
    pnOpcoes: TPanel;
    pnRodape: TPanel;
    BtGrava: TBitBtn;
    BtCancel: TBitBtn;
    ckPrivilegiado: TCheckBox;
    ckAtivo: TCheckBox;
    pnUsuarioId: TPanel;
    edNomeCompleto: TEdit;
    edNomeUsuario: TEdit;
    edSenha1: TEdit;
    edSenha2: TEdit;
    lblID: TLabel;
    lblUsuario: TLabel;
    lblSenha1: TLabel;
    lblSenha2: TLabel;
    lblNomeCompleto: TLabel;
    btnLimpar: TBitBtn;
    procedure BtGravaClick(Sender: TObject);
    procedure TreeMenuClick(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
    procedure BtLiberaClick(Sender: TObject);
    procedure BtBloqueiaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreeActionClick(Sender: TObject);
    procedure TreeControlsClick(Sender: TObject);
    procedure TreeMenuCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
    procedure TreeMenuKeyPress(Sender: TObject; var Key: char);
    procedure TreeMenuMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ieUsuarioExit(Sender: TObject);
    procedure ieUsuarioBtnClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    FUsuario      :  TUSUARIO;
    FUsuario_Menu :  TUSUARIO_MENU;

    ieUsuarioId   :  TIntegerEdit;
    FMenu         :  TMenu;
    FActions      :  TObject;
    FChangingTree :  Boolean;
    FTempMPointer :  PTreeMenu;
    FTempLista    :  TStringList;
    FListaMenu    :  array of PTreeMenu;
    FTempIdUser   :  Integer;
    procedure TrataItem(IT: TMenuItem; node: TTreeNode); overload;
    procedure TreeMenuItem(marca: Boolean);
    procedure Atualiza(Selec: Boolean);
    procedure TreeActionItem(marca: Boolean);
    procedure UnCheckChild(node: TTreeNode);
    procedure TreeControlItem(marca: Boolean);
    procedure CarregaTreeviews;
    procedure plAbrirTabelas;
    procedure plFecharTabelas;
    procedure plComponentes;
    procedure plCarregaAcessoUsuario;
    procedure plHabilitaTreeMenu(cHabilita : Boolean);
    procedure plLimpar;
  public

  end;

  Procedure PermissaoUsuarios(cMenu : TMenu);


implementation

uses
  Messages,
  SysUtils,
  uCodifica,
  Windows;

{$R *.dfm}

procedure PermissaoUsuarios(cMenu : TMenu);
var
  frmPermissao: TfrmPermissao;
Begin
  frmPermissao := TfrmPermissao.Create(Application);
  Try
    frmPermissao.FMenu := cMenu;
    frmPermissao.ShowModal;
  Finally
    frmPermissao.Free;
  End;
End;


procedure TfrmPermissao.BtGravaClick(Sender: TObject);
var
  Contador: Integer;
begin
  Try
    If   Trim(edSenha1.Text) = Trim(edSenha2.Text) Then
         Raise Exception.Create('senhas n�o consistem!');
  If   ieUsuarioId.IntegerNumber = 0 Then
      Begin
        If   FUsuario.FindByInd_Usuario(Trim(edNomeUsuario.Text)) Then
             Raise Exception.Create('J� existe esse usuario!');
        FUsuario.Insert;
        FUsuario.USUARIO      := edNomeUsuario.Text;
        FUsuario.SENHA        := Criptografar(Trim(edSenha1.Text));
        FUsuario.NOME         := edNomeCompleto.Text;
        FUsuario.TIPO_USUARIO := ckPrivilegiado.Checked;
        FUsuario.ATIVO        := ckAtivo.Checked;
        FUsuario.Post;
      End
  Else
      Begin
        If   Not FUsuario.FindBypk_Id(ieUsuarioId.IntegerNumber) Then
             Raise Exception.Create('Usuario inexistente"');
        FUsuario.Edit;
        FUsuario.SENHA        := Criptografar(Trim(edSenha1.Text));
        FUsuario.NOME         := edNomeCompleto.Text;
        FUsuario.TIPO_USUARIO := ckPrivilegiado.Checked;
        FUsuario.ATIVO        := ckAtivo.Checked;
        FUsuario.Post;
        for Contador := 0 to TreeMenu.Items.Count - 1 do
          If   PTreeMenu(TreeMenu.Items[Contador].Data).Selecionado = 1 then
               Begin
                 If   Not FUsuario_Menu.FindByPk_IdUsuario_IdMenu(FUsuario.ID,PTreeMenu(TreeMenu.Items[Contador].Data).TagName) Then
                      Begin
                        FUsuario_Menu.Insert;
                        FUsuario_Menu.IDUSUARIO := FUsuario.ID;
                        FUsuario_Menu.IDMENU    := PTreeMenu(TreeMenu.Items[Contador].Data).TagName;
                        FUsuario_Menu.Post;
                      End;
               End
          Else
               Begin
                 If   FUsuario_Menu.FindByPk_IdUsuario_IdMenu(FUsuario.ID,PTreeMenu(TreeMenu.Items[Contador].Data).TagName) Then
                      FUsuario_Menu.Delete;
               End;
      End;
  Except
    On E: Exception Do
       ShowMessage(e.Message);
  End;
end;

procedure TfrmPermissao.TrataItem(IT: TMenuItem; node: TTreeNode);
var
  contador: Integer;
  TempNode: TTreeNode;
begin
  for contador := 0 to IT.Count - 1 do
    if IT.Items[Contador].Caption <> '-' then
      if IT.Items[Contador].Count > 0 then
      begin
        New(FTempMPointer);
        SetLength(FListaMenu, Length(FListaMenu) + 1);  //Adicionado por Luiz 18/01/06
        FListaMenu[High(FListaMenu)] := FTempMPointer;  //Adicionado por Luiz 18/01/06
        FTempMPointer.Selecionado    := 0;
        FTempMPointer.MenuName       := IT.Items[Contador].Caption;
        FTempMPointer.TagName        := IntToStr(IT.Items[Contador].Tag);
        TempNode                     := TreeMenu.Items.AddChildObject(node, StringReplace(IT.Items[Contador].Caption, '&', '', [rfReplaceAll])+' - '+IntToStr(IT.Items[Contador].Tag), FTempMPointer);
        TrataItem(IT.Items[Contador], TempNode);
      end
      else
      begin
        New(FTempMPointer);
        SetLength(FListaMenu, Length(FListaMenu) + 1);  //Adicionado por Luiz 18/01/06
        FListaMenu[High(FListaMenu)] := FTempMPointer;  //Adicionado por Luiz 18/01/06
        FTempMPointer.Selecionado    := 0;
        FTempMPointer.MenuName       := IT.Items[Contador].Caption;
        FTempMPointer.TagName        := IntToStr(IT.Items[Contador].Tag);
        TreeMenu.Items.AddChildObject(node, StringReplace(IT.Items[Contador].Caption, '&', '', [rfReplaceAll])+' - '+IntToStr(IT.Items[Contador].Tag), FTempMPointer);
      end;
end;

procedure TfrmPermissao.CarregaTreeviews;
var
  Contador: Integer;
  TempNode: TTreeNode;
  Temp:     String;
  Temp2:    String;
  Desc:     String;
begin
  FChangingTree := False;
  PC.ActivePage := PageMenu;

//  Self.FMenu              := TUserControl(Owner).ControlRight.MainMenu;

  if Assigned(FMenu) then
  begin
    TreeMenu.Items.Clear;
    for Contador := 0 to FMenu.Items.Count - 1 do
      if FMenu.Items[Contador].Count > 0 then
      begin
        New(FTempMPointer);
        SetLength(FListaMenu, Length(FListaMenu) + 1);  //Adicionado por Luiz 18/01/06
        FListaMenu[High(FListaMenu)] := FTempMPointer;  //Adicionado por Luiz 18/01/06
        FTempMPointer.Selecionado    := 0;
        FTempMPointer.MenuName       := FMenu.Items[Contador].Caption;
        FTempMPointer.TagName        := IntToStr(FMenu.Items[Contador].Tag);
        TempNode                     := TreeMenu.Items.AddObject(nil, StringReplace(FMenu.Items[Contador].Caption, '&', '', [rfReplaceAll])+' - '+IntToStr(FMenu.Items[Contador].Tag), FTempMPointer);
        TrataItem(FMenu.Items[Contador], TempNode);
      end
      else
        if FMenu.Items[Contador].Caption <> '-' then
        begin
          New(FTempMPointer);
          SetLength(FListaMenu, Length(FListaMenu) + 1);  //Adicionado por Luiz 18/01/06
          FListaMenu[High(FListaMenu)] := FTempMPointer;  //Adicionado por Luiz 18/01/06
          FTempMPointer.Selecionado    := 0;
          FTempMPointer.MenuName       := FMenu.Items[Contador].Caption;
          FTempMPointer.TagName        := IntToStr(FMenu.Items[Contador].Tag);
          TreeMenu.Items.AddObject(nil, StringReplace(FMenu.Items[Contador].Caption, '&', '', [rfReplaceAll])+' - '+IntToStr(FMenu.Items[Contador].Tag), FTempMPointer);
        end;
    TreeMenu.FullExpand;
    TreeMenu.Perform(WM_VSCROLL, SB_TOP, 0);
  end;

  PageMenu.TabVisible := Assigned(FMenu);

end;

procedure TfrmPermissao.UnCheckChild(node: TTreeNode);
var
  child: TTreeNode;
begin
  PTreemenu(node.Data).Selecionado := 0;
  node.ImageIndex                  := 0;
  node.SelectedIndex               := 0;
  child                            := node.GetFirstChild;
  repeat
    if child.HasChildren then
      UnCheckChild(child)
    else
    begin
      PTreemenu(child.Data).Selecionado := 0;
      child.ImageIndex                  := 0;
      child.SelectedIndex               := 0;
    end;
    child := node.GetNextChild(child);
  until child = nil;
end;

procedure TfrmPermissao.TreeMenuItem(Marca: Boolean);
var
  AbsIdx: Integer;
begin
  if Marca then
    if PTreemenu(TreeMenu.Selected.Data).Selecionado < 2 then
    begin
      if PTreemenu(TreeMenu.Selected.Data).Selecionado = 0 then //marcar
      begin
        AbsIdx := TreeMenu.Selected.AbsoluteIndex;
        while AbsIdx > -1 do
        begin
          PTreemenu(TreeMenu.Items.Item[AbsIdx].Data).Selecionado := 1;
          TreeMenu.Items.Item[AbsIdx].ImageIndex                  := 1;
          TreeMenu.Items.Item[AbsIdx].SelectedIndex               := 1;
          if TreeMenu.Items.Item[AbsIdx].Parent <> nil then
          begin
            AbsIdx := TreeMenu.Items.Item[AbsIdx].Parent.AbsoluteIndex;
            if PTreemenu(TreeMenu.Items.Item[AbsIdx].Data).Selecionado = 2 then
              AbsIdx := -1;
          end
          else
            AbsIdx := -1;
        end;
      end
      else
        if TreeMenu.Selected.HasChildren then
          UnCheckChild(TreeMenu.Selected)
        else
        begin
          PTreemenu(TreeMenu.Selected.Data).Selecionado := 0;
          TreeMenu.Selected.ImageIndex                  := 0;
          TreeMenu.Selected.SelectedIndex               := 0;
        end; //desmarcar
      TreeMenu.Repaint;
    end;
end;

procedure TfrmPermissao.TreeActionItem(marca: Boolean);
begin
end;

procedure TfrmPermissao.TreeControlItem(marca: Boolean);
begin
end;

procedure TfrmPermissao.TreeMenuClick(Sender: TObject);
begin
  if not FChangingTree then
    TreeMenuItem(True);
end;

procedure TfrmPermissao.BtCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPermissao.BtLiberaClick(Sender: TObject);
begin
  Atualiza(True);
end;

procedure TfrmPermissao.Atualiza(Selec: Boolean);
var
  Contador: Integer;
  Temp:     Integer;
begin
  if Selec then
    Temp := 1
  else
    Temp := 0;

  if PC.ActivePage = PageMenu then
  begin
    for Contador := 0 to TreeMenu.Items.Count - 1 do
      if PTreeMenu(TreeMenu.Items[Contador].Data).Selecionado < 2 then
      begin
        PTreeMenu(TreeMenu.Items[Contador].Data).Selecionado := Temp;
        TreeMenu.Items[Contador].ImageIndex                  := Temp;
        TreeMenu.Items[Contador].SelectedIndex               := Temp;
      end;
    TreeMenu.Repaint;
  end;
end;


procedure TfrmPermissao.BtBloqueiaClick(Sender: TObject);
begin
  Atualiza(False);
end;

procedure TfrmPermissao.FormShow(Sender: TObject);
begin
  //carrega itens do menu, actions e controles
  CarregaTreeviews;
end;

procedure TfrmPermissao.TreeActionClick(Sender: TObject);
begin
  if not FChangingTree then
    TreeActionItem(True);
end;

procedure TfrmPermissao.TreeControlsClick(Sender: TObject);
begin
  if not FChangingTree then
    TreeControlItem(True);
end;

procedure TfrmPermissao.TreeMenuCollapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
begin
  if (Self.Showing) and (TTreeView(Sender).Focused) then
    FChangingTree := True;
end;

procedure TfrmPermissao.TreeMenuKeyPress(Sender: TObject; var Key: char);
begin
  if Key = ' ' then
  begin
    TTreeView(Sender).OnClick(Sender);
    Key := #0;
  end;
end;

procedure TfrmPermissao.TreeMenuMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FChangingTree := False;
end;

procedure TfrmPermissao.FormDestroy(Sender: TObject);
var
  Contador: Integer;
begin
  // Adicionado por Luiz 18/01/06

  if Assigned(FTempLista) then
    FreeAndNil(FTempLista);

  for Contador := 0 to High(FListaMenu) do
    Dispose(FListaMenu[Contador]);

  plFecharTabelas;
end;

procedure TfrmPermissao.plAbrirTabelas;
begin
  FUsuario      := TUSUARIO.Create(Self);
  FUsuario_Menu := TUSUARIO_MENU.Create(Self);
end;

procedure TfrmPermissao.plFecharTabelas;
begin
  FUsuario.Free;
  FUsuario_Menu.Free;
end;

procedure TfrmPermissao.FormCreate(Sender: TObject);
begin
  plAbrirTabelas;
  plComponentes;
end;

procedure TfrmPermissao.plComponentes;
begin
  ieUsuarioId := TIntegerEdit.Create(Self);
  With ieUsuarioId Do
    Begin
      Parent      := pnUsuarioId;
      Name        := 'ieUsuarioId';
      Width       := pnUsuarioId.ClientWidth;
      ShowButton  := True;
      OnExit      := ieUsuarioExit;
      OnBtnClick  := ieUsuarioBtnClick;
    End;
end;

procedure TfrmPermissao.plCarregaAcessoUsuario;
var
  Contador: Integer;
  Selec:    Integer;
begin
//  FUsuario.ID := FTempIdUser;
//  FSUsuario.CarregaSQL;
  // Adcionado por Luiz
  SetLength(FListaMenu, 0);
//  lbUser.Caption := FSUsuario.USUARIO;
  for Contador := 0 to TreeMenu.Items.Count - 1 do
  begin
    FUsuario_Menu.Carrega(False);
    If   FUsuario_Menu.FindByPk_IdUsuario_IdMenu(FUsuario.ID,PTreeMenu(TreeMenu.Items[Contador].Data).TagName) Then
         Selec := 1
    else Selec := 0;

    PTreeMenu(TreeMenu.Items[Contador].Data).Selecionado := Selec;
    TreeMenu.Items[Contador].ImageIndex                  := Selec;
    TreeMenu.Items[Contador].SelectedIndex               := Selec;
  end;

  TreeMenu.Repaint;
  FChangingTree := False;
end;

procedure TfrmPermissao.ieUsuarioExit(Sender: TObject);
begin
  Try
   edNomeUsuario.Enabled := ieUsuarioId.IntegerNumber = 0;
   If   ieUsuarioId.IntegerNumber > 0 Then
        Begin
          FUsuario.Carrega(False);
          If   FUsuario.FindBypk_Id(ieUsuarioId.IntegerNumber) Then
               Begin
                 edNomeUsuario.Text     := FUsuario.USUARIO;
                 edSenha1.Text          := FUsuario.SENHA;
                 edSenha2.Text          := FUsuario.SENHA;
                 edNomeCompleto.Text    := FUsuario.NOME;
                 ckPrivilegiado.Checked := FUsuario.TIPO_USUARIO;
                 ckAtivo.Checked        := FUsuario.ATIVO;
                 plHabilitaTreeMenu(True);
                 plCarregaAcessoUsuario;
               End
          Else Raise Exception.Create('Usuario n�o encontrado!');
        End;
  Except
    On E: Exception Do
       Begin
         ShowMessage(E.Message);
         ieUsuarioId.SetFocus;
       End;
  End
end;

procedure TfrmPermissao.ieUsuarioBtnClick(Sender: TObject);
begin
  //
end;

procedure TfrmPermissao.plHabilitaTreeMenu(cHabilita: Boolean);
begin
  TreeMenu.Enabled   := cHabilita;
  BtLibera.Enabled   := cHabilita;
  BtBloqueia.Enabled := cHabilita;
end;

procedure TfrmPermissao.btnLimparClick(Sender: TObject);
begin
  plLimpar;
end;

procedure TfrmPermissao.plLimpar;
begin
  Atualiza(False);
  plHabilitaTreeMenu(False);
  ckPrivilegiado.Checked := False;
  ckAtivo.Enabled        := False;
  edNomeCompleto.Text    := EmptyStr;
  edNomeUsuario.Text     := EmptyStr;
  edSenha1.Text          := EmptyStr;
  edSenha2.Text          := EmptyStr;
  ieUsuarioId.IntegerNumber := 0;
  ieUsuarioId.SetFocus;
end;

end.
