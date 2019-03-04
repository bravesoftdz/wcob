unit MyImprime;

{
Unit para facilitar impress�o direta com o TCanvas.
Todas as vari�veis, procedimentos e fun��es come�am
com as letras "MP".
� criado um objeto com o nome MPPrinter para controle
da impress�o, com procedimentos privados (acessados
somente por esta unit.
As Procedures e fun��es declaradas logo abaixo de
TMyPrinter poder�o ser "chamadas" por outras units.

Para usar esta unit, esta dever� ser inicializada:
MPInicializa('FontePadr�o',TamanhoPadr�o)
e finalizada:
MPFinaliza;

Unit escrita em Delphi 6.0
Walter de Freitas Peixoto
walterpeixoto@yahoo.com.br
}

interface

uses Printers, Graphics, Classes, SysUtils;

type TMyPrinter = class(TObject)
  private
    MPFonteName: string; // nome da fonte
    MPFonteSize: integer; // tamanho da fonte
    MPMarginTop: integer; // Margem superior da folha - em linhas conf. altura padr�o
    MPMarginLeft: integer; // margem esquerda da p�gina
    MPMarginBotton: integer; // Margem inferior da folha - em linhas conf. altura padr�o
    MPEstilo: TFontStyles; // estilo da fonte
    MPLinha: integer; // linha a ser impressa
    MPColuna: integer; // coluna a ser impressa
    MPTamanho: integer; // largura padr�o de fonte - 'A' p/ contagem de caracter
    MPAltura: integer; // Altura padr�o de Fonte = "A"
    MPAlignment: TAlignment; // alinhamento de impress�o
    MPIfHeaderAll: boolean; // se imprimir cabe�alho em todas as p�ginas
    MPHeaderFont: array of TFont; // para cabe�alho
    MPHeaderString: array of string; // para cabe�alho
    MPHeaderAlign: array of TAlignment; // para cabe�alho
    MPHeaderQtLine: integer; // Qtde linha no cabe�alho
    // MPPage: integer; // n� p�gina
    MPPageHeader: boolean; // se j� imprimiu cabe�alho
    procedure MPImprimeHeader; // imprime cabe�alho
    function MPCentra(vTexto: string): integer;
  end;

procedure MPInicializa(kFonte: string; kSize: integer; kEstilo: TFontStyles = []; kPen: integer = 5);
procedure MPFinaliza;
procedure MPSetFonte(kFonte: string);
procedure MPSetFontStyle(kEstilo: TFontStyles);
procedure MPSetMarginLeft(kMarg: Integer);
procedure MPSetMarginTop(kMarg: integer);
procedure MPSetMarginBotton(kFooter: integer);
procedure MPNewPage;
procedure MPReset;
function MPReplicate(kString: string; kNum: integer): string;
procedure MPImprime(kInc: integer; kCol: integer; kTexto: string; kTam: integer = 0; kAlign: TAlignment = taLeftJustify);
function MPGetHeaderAll: boolean;
procedure MPSetHeaderAll(kValue: boolean);
procedure MPHeaderAdd(kString: string; kAlign: TAlignment = taLeftJustify; kFontSize: integer = 0; kFontStyle: TFontStyles = []);

var
  MPPrinter: TMyPrinter;

implementation

procedure MPInicializa(kFonte: string; kSize: integer; kEstilo: TFontStyles = []; kPen: integer = 5);
begin
  // inicializa MPPrinter
  MPPrinter := TMyPrinter.Create;

  MPPrinter.MPIfHeaderAll := False;
  MPPrinter.MPPageHeader := False;

  // fixa/estabelece valores para vari�veis de impress�o
  MPPrinter.MPFonteName := kFonte;
  MPPrinter.MPFonteSize := kSize;
  MPPrinter.MPEstilo := kEstilo;

  // configura documento para impress�o
  Printer.Orientation := poPortrait;
  Printer.BeginDoc;
  Printer.Canvas.Pen.Width := kPen;
  Printer.Canvas.Font.Name := MPPrinter.MPFonteName;
  Printer.Canvas.Font.Size := MPPrinter.MPFonteSize;
  Printer.Canvas.Font.Style := MPPrinter.MPEstilo;

  MPPrinter.MPMarginTop := 0;
  MPPrinter.MPMarginBotton := 10;
  MPPrinter.MPTamanho := Printer.Canvas.TextWidth('A');
  MPPrinter.MPAltura := Printer.Canvas.TextHeight('A') + 5;
  MPPrinter.MPMarginLeft := 10 + (0 * MPPrinter.MPTamanho);
  MPPrinter.MPLinha := 10 + (MPPrinter.MPMarginTop * MPPrinter.MPAltura);
  MPPrinter.MPColuna := 10 + (MPPrinter.MPMarginLeft * MPPrinter.MPTamanho);

  MPPrinter.MPAlignment := taLeftJustify;

  // cabe�alho
  MPPrinter.MPHeaderQtLine := 0;
end;

procedure MPFinaliza;
var kX: integer;
begin
  Printer.EndDoc;
  if MPPrinter.MPHeaderQtLine > 0 then
    for kX := 0 to MPPrinter.MPHeaderQtLine - 1 do
      MPPrinter.MPHeaderFont[kX].Free;
  MPPrinter.Free;
end;

procedure MPSetFonte(kFonte: string);
begin
  Printer.Canvas.Font.Name := kFonte;
end;

procedure MPSetFontStyle(kEstilo: TFontStyles);
begin
  Printer.Canvas.Font.Style := kEstilo;
end;

procedure MPSetMarginLeft(kMarg: Integer);
begin
  MPPrinter.MPMarginLeft := 10 + (kMarg * MPPrinter.MPTamanho);
end;

procedure MPSetMarginTop(kMarg: integer);
begin
  MPPrinter.MPMarginTop := 10 + (kMarg * MPPrinter.MPAltura);
  if MPPrinter.MPLinha < MPPrinter.MPMarginTop then
    MPPrinter.MPLinha := MPPrinter.MPMarginTop - Printer.Canvas.Font.Height + 5;
end;

procedure MPSetMarginBotton(kFooter: integer);
begin
  MPPrinter.MPMarginBotton := 10 + (kFooter * MPPrinter.MPAltura);
end;

procedure MPNewPage;
begin
  Printer.NewPage;
  MPPrinter.MPLinha := 10 + (MPPrinter.MPMarginTop * MPPrinter.MPAltura);
  if MPPrinter.MPIfHeaderAll then
    MPPrinter.MPImprimeHeader;
end;

procedure MPReset;
begin
  // valores padr�es para Fonte
  Printer.Canvas.Font.Name := MPPrinter.MPFonteName;
  Printer.Canvas.Font.Size := MPPrinter.MPFonteSize;
  Printer.Canvas.Font.Style := MPPrinter.MPEstilo;
end;

function MPReplicate(kString: string; kNum: integer): string;
var x: integer;
begin
  // repete uma string de acordo com o tamanho padr�o de largura
  // e n�o do n� de caracteres de kString
  x := kNum * MPPrinter.MPTamanho;
  result := '';
  while x > Printer.Canvas.TextWidth(result) do
    result := result + kString;
end;

// :::::::::::::::::::::::
procedure MPImprime(kInc: integer; kCol: integer; kTexto: string; kTam: integer = 0; kAlign: TAlignment = taLeftJustify);
begin
  // Se ainda n�o foi impresso o cabe�alho, faz agora
  if not MPPrinter.MPPageHeader then 
  begin
    MPPrinter.MPImprimeHeader;
    MPPrinter.MPPageHeader := true;
  end;
  // se avan�ar para pr�xima linha - kInc incrementa n� linhas
  if kInc > 0 then
    MPPrinter.MPLinha := MPPrinter.MPLinha - (Printer.Canvas.Font.Height * kInc) + (5 * kInc);
  // se posi��o atingiu o rodap� da p�gina - nova p�gina
  if MPPrinter.MPLinha > (Printer.PageHeight - MPPrinter.MPMarginBotton) then
  begin
    // nova p�gina
    Printer.NewPage;
    MPPrinter.MPLinha := 10 + (MPPrinter.MPMarginTop * MPPrinter.MPAltura);
    // -> imprime cabe�alho - se imprimir em todas as p�ginas
    if MPPrinter.MPIfHeaderAll then
      MPPrinter.MPImprimeHeader;
  end;
  // altera o tamanho da fonte se kTam diferente de zero
  if kTam <> 0 then
    Printer.Canvas.Font.Size := kTam;

  // verifica valor de kCol - Se negativo, imprime da direita p/ esquerda
  // alinhando uma coluna � direita... (kCol assume kCol - Tamanho string)
  if kCol < 0 then
  begin
    kCol := MPPrinter.MPMarginLeft + (MPPrinter.MPTamanho * (kCol * -1));
    MPPrinter.MPColuna := kCol - Printer.Canvas.TextWidth(kTexto);
  end
  else
  begin
    // estabelece posi��o para a coluna de acordo com a margem
    MPPrinter.MPAlignment := kAlign;
    if (MPPrinter.MPAlignment = taLeftJustify) then
      MPPrinter.MPColuna := MPPrinter.MPMarginLeft + (MPPrinter.MPTamanho * kCol)
    else if (MPPrinter.MPAlignment = taRightJustify) then
      // if kCol <> 0 assume margem � direita ref a kCol caracteres
      MPPrinter.MPColuna := (Printer.PageWidth - 10 - Printer.Canvas.TextWidth(kTexto)) - (kCol * MPPrinter.MPTamanho)
    else if (MPPrinter.MPAlignment = taCenter) then
      MPPrinter.MPColuna := MPPrinter.MPCentra(kTexto);
  end;

  // envia resultado para composi��o de p�gina para impress�o
  Printer.Canvas.TextOut(MPPrinter.MPColuna, MPPrinter.MPLinha, kTexto);
end;

function MPGetHeaderAll: boolean;
begin
  Result := MPPrinter.MPIfHeaderAll;
end;

procedure MPSetHeaderAll(kValue: boolean);
begin
  MPPrinter.MPIfHeaderAll := kValue;
end;

procedure MPHeaderAdd(kString: string; kAlign: TAlignment = taLeftJustify; kFontSize: integer = 0; kFontStyle: TFontStyles = []);
begin
  MPPrinter.MPHeaderQtLine := MPPrinter.MPHeaderQtLine + 1;

  // altera tamanho de vetores de cabe�alho
  SetLength(MPPrinter.MPHeaderFont, MPPrinter.MPHeaderQtLine);
  SetLength(MPPrinter.MPHeaderString, MPPrinter.MPHeaderQTLine);
  SetLength(MPPrinter.MPHeaderAlign, MPPrinter.MPHeaderQtLine);

  MPPrinter.MPHeaderString[MPPrinter.MPHeaderQtLine - 1] := kString;
  MPPrinter.MPHeaderAlign[MPPrinter.MPHeaderQtLine - 1] := kAlign;
  MPPrinter.MPHeaderFont[MPPrinter.MPHeaderQtLine - 1] := TFont.Create;
  (MPPrinter.MPHeaderFont[MPPrinter.MPHeaderQtLine - 1] as TFont).Name := MPPrinter.MPFonteName;
  if kFontSize <> 0 then
    (MPPrinter.MPHeaderFont[MPPrinter.MPHeaderQtLine - 1] as TFont).Size := kFontSize
  else
    (MPPrinter.MPHeaderFont[MPPrinter.MPHeaderQtLine - 1] as TFont).Size := MPPrinter.MPFonteSize;
  if kFontStyle <> [] then
    (MPPrinter.MPHeaderFont[MPPrinter.MPHeaderQtLine - 1] as TFont).Style := kFontStyle
  else
    (MPPrinter.MPHeaderFont[MPPrinter.MPHeaderQtLine - 1] as TFont).Style := MPPrinter.MPEstilo;
end;

{ TMyPrinter }

function TMyPrinter.MPCentra(vTexto: string): integer;
var vEsq: integer;
  vPos: Real;
  sPos: string;
begin
  vPos := (Printer.Canvas.TextWidth(vTexto) - MPPrinter.MPMarginLeft) / 2;
  vPos := (Printer.PageWidth / 2) - vPos;
  sPos := FormatFloat('#####0', vPos);
  vEsq := StrToInt(sPos);
  result := vEsq;
end;

procedure TMyPrinter.MPImprimeHeader;
var kX: integer;
  kTexto: string;
  kAlign: TAlignment;
  kOldEstilo: TFontStyles;
  kOldSize: Integer;
  kOldAlin: TAlignment;
begin
  if MPPrinter.MPHeaderQtLine > 0 then
  begin
    kOldEstilo := Printer.Canvas.Font.Style;
    kOldSize := Printer.Canvas.Font.Size;
    kOldAlin := MPPrinter.MPAlignment;
    MPPrinter.MPLinha := 10 + (MPPrinter.MPMarginTop * MPPrinter.MPAltura);
    for kX := 0 to MPPrinter.MPHeaderQtLine - 1 do
    begin
      kTexto := MPPrinter.MPHeaderString[kX];
      kAlign := MPPrinter.MPHeaderAlign[kX];
      Printer.Canvas.Font.Size := (MPPrinter.MPHeaderFont[kX] as TFont).Size;
      Printer.Canvas.Font.Style := (MPPrinter.MPHeaderFont[kX] as TFont).Style;

      // justifica cabe�alho
      if (kAlign = taLeftJustify) then
        MPPrinter.MPColuna := MPPrinter.MPMarginLeft
      else if (kAlign = taRightJustify) then
        MPPrinter.MPColuna := (Printer.PageWidth - 10 - Printer.Canvas.TextWidth(kTexto))
      else if (kAlign = taCenter) then
        MPPrinter.MPColuna := MPPrinter.MPcentra(kTexto);

      // envia dados para p�gina de impress�o e avan�a para pr�xima linha
      Printer.Canvas.TextOut(MPPrinter.MPColuna, MPPrinter.MPLinha, kTexto);
      MPPrinter.MPLinha := MPPrinter.MPLinha - Printer.Canvas.Font.Height + 5;
    end;
    // retorna configura��o de Printer para impress�o do corpo
    Printer.Canvas.Font.Style := kOldEstilo;
    Printer.Canvas.Font.Size := kOldSize;
    MPPrinter.MPAlignment := kOldAlin;
  end;
end;

end.
// final da Unit MyImprime

