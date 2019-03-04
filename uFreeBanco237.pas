(*******************************************************************)
(* FreeBOLETO                                                      *)
(*******************************************************************)
(* Autor original: Carlos H. Cantu                                 *)
(*                                                                 *)
(* LICEN�A                                                         *)
(*                                                                 *)
(*    1. O FreeBoleto pode ser distribu�do e utilizado livremente  *)
(*       com qualquer tipo de projeto, comercial ou n�o.           *)
(*    2. Componentes derivados do c�digo do FreeBoleto n�o podem   *)
(*       ser vendidos e devem manter os cr�ditos originais, e devem*)
(*       estar compat�veis com essa licen�a.                       *)
(*    3. Qualquer altera��o ou melhoria no c�digo do FreeBoleto    *)
(*       deve ser enviada ao autor para ser avaliada e, se         *)
(*       poss�vel, incorporada ao c�digo oficial do componente.    *)
(*    4. A inclus�o do suporte de novos bancos ao FreeBoleto deve  *)
(*       ser notificada ao autor, enviando juntamente o c�digo da  *)
(*       unit do banco em quest�o. A cria��o de uma nova unit de   *)
(*       suporte a um novo banco dever� ser feita em conjunto com  *)
(*       a cria��o dos testes unit�rios (DUNITs) necess�rios para  *)
(*       garantir o correto funcionamento das rotinas.             *)
(*    5. O autor n�o se responsabiliza por qualquer dano ou        *)
(*       qualquer outro tipo de problema originado pela utiliza��o *)
(*       desse componente, se isentando de qualquer                *)
(*       responsabilidade sobre a utiliza��o do mesmo.             *)
(*                                                                 *)
(* Mais informa��es sobre a licen�a e utiliza��o est�o no arquivo  *)
(* Leiame.html, que deve ser distribu�do com todas as vers�es      *)
(* componente.                                                     *)
(*                                                                 *)
(*******************************************************************)

unit uFreeBanco237; // BRADESCO

interface

uses classes, SysUtils, uFreeBoleto, uFuncAux;

type                          
  TFreeBanco237 = class(TFreeClasseBanco)
  published
    procedure ChecarDadosIniciais(Boleto: TFreeBoleto); override;
    procedure InicializaDadosPadroes(Boleto: TFreeBoleto); override;
    function GetCodigoBanco: string; override;
    function GetCodigoBancoComDigito: string; override;
    function GetCampoLivre(Boleto: TFreeBoleto): string; override;
    function FormataAgencCodigoCedente(Boleto: TFreeBoleto): string; override;
    function GetDigitoNossoNum(Boleto: TFreeBoleto): char; override;
    function GetNumeroBancario(Boleto: TFreeBoleto): string; override;
    function GetNomeBanco: string; override;
  end;

implementation

{ TFreeBanco237 }

{*******************************************************************}
{* M�todo ChecarDadosIniciais(Boleto: TFreeBoleto)                  *}
{*******************************************************************}
{* Rotina executada no in�cio da fase de prepara��o do boleto      *}
{* Serve para validar se os dados inseridos no TFreeBoleto est�o no *}
{* formato correto, ver se os campos obrigat�rios foram            *}
{* preenchidos, etc.                                               *}
{*******************************************************************}

procedure TFreeBanco237.ChecarDadosIniciais(Boleto: TFreeBoleto);
begin
  inherited;
  with Boleto do
  begin
    if Length(NossoNumero) > 11 then
      raise Exception.Create('O tamanho do NossoN�mero n�o pode ser maior que 11 caracteres!')
    else
      if Length(NossoNumero) < 11 then
        NossoNumero := Padl(NossoNumero, 11, '0');

    if Length(Cedente.ContaCorrente) > 7 then
      raise Exception.Create('A conta corrente n�o pode ter mais que 7 d�gitos!')
    else
      if Length(Cedente.ContaCorrente) < 7 then
        Cedente.ContaCorrente := Padl(Cedente.ContaCorrente, 7, '0');

    if Length(Cedente.Agencia) > 4 then
      raise Exception.Create('A ag�ncia deve ter 4 d�gitos!')
    else
      if Length(Cedente.Agencia) < 4 then
        Cedente.Agencia := Padl(Cedente.Agencia, 4, '0');

    if Length(Carteira) <> 2 then
      raise Exception.Create('A carteira deve possuir 2 d�gitos!')
  end;
end;

{*******************************************************************}
{* M�todo FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;   *}
{*******************************************************************}
{* Formata o string que � usado no preenchimento do campo          *}
{* Agencia/Codigo do Cedente nos boletos                           *}
{*******************************************************************}

function TFreeBanco237.FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;
begin
  inherited;
  Result := Copy(Boleto.Cedente.Agencia, 1, 4) + '/' + // n�o coloquei o digito da agencia
    Boleto.Cedente.ContaCorrente + '-' + Boleto.Cedente.DigitoContaCorrente;
end;

{*******************************************************************}
{* M�todo GetCampoLivre(Boleto: TFreeBoleto): string;               *}
{*******************************************************************}
{* Monta o Campo Livre, que varia de banco para banco.             *}
{*******************************************************************}

function TFreeBanco237.GetCampoLivre(Boleto: TFreeBoleto): string;
begin
  inherited;
  Result := Boleto.Cedente.Agencia +
    Boleto.Carteira +
    Boleto.NossoNumero +
    Boleto.cedente.ContaCorrente +
    '0';
end;

{*******************************************************************}
{* M�todo GetCodigoBanco: string;                                  *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco                              *}
{*******************************************************************}

function TFreeBanco237.GetCodigoBanco: string;
begin
  inherited;
  Result := '237'; // 237 � o c�digo do BRADESCO
end;

{*******************************************************************}
{* M�todo GetCodigoBancoComDigito: string;                         *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco + digito                     *}
{*******************************************************************}

function TFreeBanco237.GetCodigoBancoComDigito: string;
begin
  inherited;
  Result := '237-2'; // Bradesco
end;

{*******************************************************************}
{* Metodo GetDigitoNossoNum(Boleto: TFreeBoleto): char;             *}
{*******************************************************************}
{* Calcula o digito do nosso numero. A formula de calculo muda de  *}
{* banco para banco.                                               *}
{*******************************************************************}

function TFreeBanco237.GetDigitoNossoNum(Boleto: TFreeBoleto): char;
var
  Num: string; resto: integer; digito: string;
begin
  inherited;
  Num := Boleto.Carteira + Boleto.NossoNumero;

  Digito := Modulo11(Num, 7, resto);
  if resto = 1 then
    Digito := 'P'
  else
    if resto = 0 then
      Digito := '0';
  Result := Digito[1];

end;

{*******************************************************************}
{* M�todo GetNomeBanco: string;                                    *}
{*******************************************************************}
{* Retorna o nome do banco, impresso no topo do formul�rio do      *}
{* boleto                                                          *}
{*******************************************************************}

function TFreeBanco237.GetNomeBanco: string;
begin
  inherited;
  Result := 'Bradesco';
end;

{*******************************************************************}
{* M�todo GetNumeroBancario(Boleto: TFreeBoleto): string;           *}
{*******************************************************************}
{* Formata o string que � mostrado no boleto impresso no campo     *}
{* Nosso Numero. Cada banco formata isso de uma maneira diferente  *}
{*******************************************************************}

function TFreeBanco237.GetNumeroBancario(Boleto: TFreeBoleto): string;
begin
  inherited;
  Result := Boleto.Carteira + '/' + Boleto.NossoNumero + '-'+GetDigitoNossoNum(Boleto);
end;

{*******************************************************************}
{* M�todo InicializaDadosPadroes(Boleto: TFreeBoleto);              *}
{*******************************************************************}
{* Inicializa alguns campos com os valores padr�es, caso n�o tenham*}
{* sido especificados no objeto FreeBoleto                          *}
{*******************************************************************}

procedure TFreeBanco237.InicializaDadosPadroes(Boleto: TFreeBoleto);
begin
  inherited;
  with Boleto do
  begin
    if Especie = '' then Especie := 'R$';
    if EspecieDoc = '' then EspecieDoc := 'DM'; //Duplicata Mercantil
    if Aceite = '' then Aceite := 'N';
    if Carteira = '' then Carteira := '06'; // Sem registro
  end;
end;

initialization
  RegisterClass(TFreeBanco237);

end.

