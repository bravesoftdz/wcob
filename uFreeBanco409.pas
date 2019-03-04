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

unit uFreeBanco409; //  UNIBANCO

interface

uses classes,
  SysUtils,
  uFreeBoleto,
  uFuncAux;

type
  TFreeBanco409 = class(TFreeClasseBanco)
  private
    function Modulo11Unibanco(Valor: string): string;
    function SuperDigitoNossoNumero(NossoNumeroComDigito: string): string;
    function NossoNumeroComDigito(NossoNumero: string): string;
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

{ TFreeBanco409 }

{*******************************************************************}
{* M�todo ChecarDadosIniciais(Boleto: TFreeBoleto)                  *}
{*******************************************************************}
{* Rotina executada no in�cio da fase de prepara��o do boleto      *}
{* Serve para validar se os dados inseridos no TFreeBoleto est�o no *}
{* formato correto, ver se os campos obrigat�rios foram            *}
{* preenchidos, etc.                                               *}
{*******************************************************************}

procedure TFreeBanco409.ChecarDadosIniciais(Boleto: TFreeBoleto);
begin
  inherited;
  with Boleto do
  begin
    if Length(NossoNumero) > 10 then
      raise EFreeBoleto.Create('O tamanho do NossoN�mero n�o pode ser maior que 10 caracteres!')
    else
      if Length(NossoNumero) < 10 then
        NossoNumero := Padl(NossoNumero, 10, '0');

    if Length(Cedente.ContaCorrente) > 6 then
      raise EFreeBoleto.Create('A conta corrente n�o pode ter mais que 6 d�gitos!')
    else
      if Length(Cedente.ContaCorrente) < 6 then
        NossoNumero := Padl(Cedente.ContaCorrente, 6, '0');

    if Length(Cedente.Agencia) > 4 then
      raise EFreeBoleto.Create('A ag�ncia deve ter 4 d�gitos!')
    else
      if Length(Cedente.Agencia) < 4 then
        Cedente.Agencia := Padl(Cedente.Agencia, 4, '0');

    if Length(Carteira) <> 1 then
      raise EFreeBoleto.Create('A carteira deve possuir 1 d�gito!')
  end;
end;

{*******************************************************************}
{* M�todo FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;   *}
{*******************************************************************}
{* Formata o string que � usado no preenchimento do campo          *}
{* Agencia/Codigo do Cedente nos boletos                           *}
{*******************************************************************}

function TFreeBanco409.NossoNumeroComDigito(NossoNumero: string): string;
begin
  NossoNumero := Padl(NossoNumero, 10, '0');
  Result := NossoNumero + Modulo11Unibanco(NossoNumero);
end;

function TFreeBanco409.FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;
begin
  inherited;
  Result := Boleto.Cedente.Agencia + '/' + Boleto.Cedente.ContaCorrente + '-' +
    Boleto.Cedente.DigitoContaCorrente;
end;

{*******************************************************************}
{* M�todo GetCampoLivre(Boleto: TFreeBoleto): string;               *}
{*******************************************************************}
{* Monta o Campo Livre, que varia de banco para banco.             *}
{*******************************************************************}

function TFreeBanco409.GetCampoLivre(Boleto: TFreeBoleto): string;
var
  NossoNumero: string;
begin
  inherited;
  if Boleto.Carteira = '1' then
  begin
    Result := '5' + // CVT
    boleto.Cedente.CodigoCedente + // Codigo do cedente + digito
    '00' + Padl(boleto.NossoNumero, 15, '0');
  end
  else
    if (Boleto.Carteira = '4') then
    begin
      NossoNumero := NossoNumeroComDigito(Boleto.NossoNumero);
      Result := '04' +
        FormatDateTime('yymmdd', Boleto.Vencimento) +
        Boleto.Cedente.Agencia + Modulo11Unibanco(Boleto.Cedente.Agencia) +
        NossoNumero + SuperDigitoNossoNumero(NossoNumero);
    end;
end;

{*******************************************************************}
{* M�todo GetCodigoBanco: string;                                  *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco                              *}
{*******************************************************************}

function TFreeBanco409.GetCodigoBanco: string;
begin
  inherited;
  Result := '409'; // UNIBANCO
end;

{*******************************************************************}
{* M�todo GetCodigoBancoComDigito: string;                         *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco + digito                     *}
{*******************************************************************}

function TFreeBanco409.GetCodigoBancoComDigito: string;
begin
  inherited;
  Result := '409-0'; // UNIBANCO
end;

{*******************************************************************}
{* Metodo GetDigitoNossoNum(Boleto: TFreeBoleto): char;             *}
{*******************************************************************}
{* Calcula o digito do nosso numero. A formula de calculo muda de  *}
{* banco para banco.                                               *}
{*******************************************************************}

function TFreeBanco409.GetDigitoNossoNum(Boleto: TFreeBoleto): char;
var
  resto: integer;
  digito: string;
begin
  inherited;
  digito := Modulo11(Boleto.NossoNumero, 9, resto);
  if (resto = 10) or (resto = 0) then
    Result := '0'
  else
    result := digito[1];
end;

{*******************************************************************}
{* M�todo GetNomeBanco: string;                                    *}
{*******************************************************************}
{* Retorna o nome do banco, impresso no topo do formul�rio do      *}
{* boleto                                                          *}
{*******************************************************************}

function TFreeBanco409.GetNomeBanco: string;
begin
  inherited;
  Result := 'Unibanco';
end;

{*******************************************************************}
{* M�todo GetNumeroBancario(Boleto: TFreeBoleto): string;           *}
{*******************************************************************}
{* Formata o string que � mostrado no boleto impresso no campo     *}
{* Nosso Numero. Cada banco formata isso de uma maneira diferente  *}
{*******************************************************************}

function TFreeBanco409.GetNumeroBancario(Boleto: TFreeBoleto): string;
var
  NossoNumero, SuperDigito: string;
begin
  inherited;
  if Boleto.Carteira = '1' then
    Result := Boleto.NossoNumero + '-' + GetDigitoNossoNum(Boleto)
  else
    if (Boleto.Carteira = '4') then
    begin
      NossoNumero := NossoNumeroComDigito(Boleto.NossoNumero);
      SuperDigito := SuperDigitoNossoNumero(NossoNumero);
      Insert('-', NossoNumero, Length(NossoNumero));
      Result := '1/' + NossoNumero + '/' + SuperDigito;
    end;
end;

{*******************************************************************}
{* M�todo InicializaDadosPadroes(Boleto: TFreeBoleto);              *}
{*******************************************************************}
{* Inicializa alguns campos com os valores padr�es, caso n�o tenham*}
{* sido especificados no objeto FreeBoleto                          *}
{*******************************************************************}

procedure TFreeBanco409.InicializaDadosPadroes(Boleto: TFreeBoleto);
begin
  inherited;
  with Boleto do
  begin
    if Especie = '' then Especie := 'R$';
    if EspecieDoc = '' then EspecieDoc := 'RC';
    if Aceite = '' then Aceite := 'N';
    if Carteira = '' then Carteira := '1'; // Cobran�a SIMPLES
  end;
end;

function TFreeBanco409.Modulo11Unibanco(Valor: string): string;
var
  Somatoria, P, Peso, i, Resto, Base: integer;
begin
  Base := 9;
  Peso := 2;
  Somatoria := 0;
  for i := Length(Valor) downto 1 do
  begin
    P := StrToInt(Valor[i]) * Peso;
    Inc(Somatoria, P);

    if Peso < Base then
      Inc(Peso, 1)
    else
      Peso := 2;
  end;

  Somatoria := Somatoria * 10;
  Resto := Somatoria mod 11;

  if (Resto = 0) or (Resto = 10) then
    Result := '0'
  else
    Result := IntToStr(Resto);
end;

function TFreeBanco409.SuperDigitoNossoNumero(NossoNumeroComDigito: string): string;
begin
  Result := Modulo11Unibanco('1' + NossoNumeroComDigito);
end;

initialization
  RegisterClass(TFreeBanco409); // UNIBANCO

end.
