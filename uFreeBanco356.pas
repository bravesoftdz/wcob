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

{*******************************************************************}
{* Unit modelo que deve ser utilizada para a cria��o das classes   *}
{* para tratamento dos bancos.                                     *}
{*                                                                 *}
{* Utilize essa unit como base para um novo banco.                 *}
{*                                                                 *}
{*******************************************************************}

unit uFreeBanco356; // REAL

interface

uses classes, SysUtils, uFreeBoleto, uFuncAux;

type
  TFreeBanco356 = class(TFreeClasseBanco)
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

{ TFreeBanco356 }

{*******************************************************************}
{* M�todo ChecarDadosIniciais(Boleto: TFreeBoleto)                  *}
{*******************************************************************}
{* Rotina executada no in�cio da fase de prepara��o do boleto      *}
{* Serve para validar se os dados inseridos no TFreeBoleto est�o no *}
{* formato correto, ver se os campos obrigat�rios foram            *}
{* preenchidos, etc.                                               *}
{*******************************************************************}

procedure TFreeBanco356.ChecarDadosIniciais(Boleto: TFreeBoleto);
begin
  // Testando apenas com cobran�a SEM REGISTRO

  inherited;
  with Boleto do
  begin
    if Length(NossoNumero) > 13 then
      raise Exception.Create('O tamanho do NossoN�mero n�o pode ser maior que 13 caracteres!')
    else if Length(NossoNumero) < 13 then
      NossoNumero := Padl(NossoNumero, 13, '0');

    if Length(Cedente.ContaCorrente) <> 7 then
      raise Exception.Create('A conta corrente deve ter 7 caracteres!');

//    if trim(Cedente.DigitoContaCorrente) = '' then
//      raise Exception.Create('Especifique o d�gito da ContaCorrente!');

    if Cedente.Agencia = '' then
      raise Exception.Create('Defina a ag�ncia banc�ria!')
    else if length(Cedente.Agencia) < 4 then
      Cedente.Agencia := Padl(Cedente.Agencia, 4, '0')
    else if length(Cedente.Agencia) > 4 then
      raise Exception.Create('O n�mero da ag�ncia n�o pode ser maior que 4 d�gitos!');

  end;
end;

{*******************************************************************}
{* M�todo FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;   *}
{*******************************************************************}
{* Formata o string que � usado no preenchimento do campo          *}
{* Agencia/Codigo do Cedente nos boletos                           *}
{*******************************************************************}

function TFreeBanco356.FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;
begin
  inherited;
  Result := Boleto.Cedente.Agencia + '/' +
    Boleto.Cedente.ContaCorrente + '/' +
    Modulo10(Boleto.NossoNumero + Boleto.Cedente.Agencia + Boleto.Cedente.ContaCorrente);
end;

{*******************************************************************}
{* M�todo GetCampoLivre(Boleto: TFreeBoleto): string;               *}
{*******************************************************************}
{* Monta o Campo Livre, que varia de banco para banco.             *}
{*******************************************************************}

function TFreeBanco356.GetCampoLivre(Boleto: TFreeBoleto): string;
begin
  inherited;
  with Boleto do
    Result := Cedente.Agencia + Cedente.ContaCorrente + GetDigitoNossoNum(Boleto)+NossoNumero;
  {
  Como exemplo, veja a implementa��o nas units dos outros bancos
  }
end;

{*******************************************************************}
{* M�todo GetCodigoBanco: string;                                  *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco                              *}
{*******************************************************************}

function TFreeBanco356.GetCodigoBanco: string;
begin
  inherited;
  Result := '356'; // REAL
end;

{*******************************************************************}
{* M�todo GetCodigoBancoComDigito: string;                         *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco + digito                     *}
{*******************************************************************}

function TFreeBanco356.GetCodigoBancoComDigito: string;
begin
  inherited;
  Result := '356-5'; // REAL
end;

{*******************************************************************}
{* Metodo GetDigitoNossoNum(Boleto: TFreeBoleto): char;             *}
{*******************************************************************}
{* Calcula o digito do nosso numero. A formula de calculo muda de  *}
{* banco para banco.                                               *}
{*******************************************************************}

function TFreeBanco356.GetDigitoNossoNum(Boleto: TFreeBoleto): char;
begin
  inherited;
  Result := Modulo10(Boleto.NossoNumero + Boleto.Cedente.Agencia + Boleto.Cedente.ContaCorrente)[1];
end;

{*******************************************************************}
{* M�todo GetNomeBanco: string;                                    *}
{*******************************************************************}
{* Retorna o nome do banco, impresso no topo do formul�rio do      *}
{* boleto                                                          *}
{*******************************************************************}

function TFreeBanco356.GetNomeBanco: string;
begin
  inherited;
  Result := 'Real';
end;

{*******************************************************************}
{* M�todo GetNumeroBancario(Boleto: TFreeBoleto): string;           *}
{*******************************************************************}
{* Formata o string que � mostrado no boleto impresso no campo     *}
{* Nosso Numero. Cada banco formata isso de uma maneira diferente  *}
{*******************************************************************}

function TFreeBanco356.GetNumeroBancario(Boleto: TFreeBoleto): string;
begin
  inherited;
  Result := Boleto.NossoNumero;
end;

{*******************************************************************}
{* M�todo InicializaDadosPadroes(Boleto: TFreeBoleto);              *}
{*******************************************************************}
{* Inicializa alguns campos com os valores padr�es, caso n�o tenham*}
{* sido especificados no objeto FreeBoleto                          *}
{*******************************************************************}

procedure TFreeBanco356.InicializaDadosPadroes(Boleto: TFreeBoleto);
begin
  inherited;
  with Boleto do
  begin
    if Especie = '' then Especie := 'R$';
    if EspecieDoc = '' then EspecieDoc := '57'; //Sem Registro
    if Aceite = '' then Aceite := 'A';
    if Carteira = '' then Carteira := '20'; // Cobran�a SIMPLES
  end;
end;

initialization
  RegisterClass(TFreeBanco356); // REAL

end.

