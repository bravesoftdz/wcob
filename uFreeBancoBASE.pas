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

unit uFreeBancoBASE; // Substitua "BASE" pelo codigo do banco (3 digitos)

interface

uses classes, SysUtils, uFreeBoleto, uFuncAux;

type
  TFreeBancoBASE = class(TFreeClasseBanco) // Substitua "BASE" pelo codigo do banco (3 digitos)
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

{ TFreeBancoBASE }

{*******************************************************************}
{* M�todo ChecarDadosIniciais(Boleto: TFreeBoleto)                  *}
{*******************************************************************}
{* Rotina executada no in�cio da fase de prepara��o do boleto      *}
{* Serve para validar se os dados inseridos no TFreeBoleto est�o no *}
{* formato correto, ver se os campos obrigat�rios foram            *}
{* preenchidos, etc.                                               *}
{*******************************************************************}

procedure TFreeBancoBASE.ChecarDadosIniciais(Boleto: TFreeBoleto);
begin
  inherited;
  { Exemplo...
    with Boleto do
    begin
      if Length(NossoNumero) > 8 then
        raise Exception.Create('O tamanho do NossoN�mero n�o pode ser maior que 7 caracteres!');

      etc, etc...
    end;
  }
end;

{*******************************************************************}
{* M�todo FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;   *}
{*******************************************************************}
{* Formata o string que � usado no preenchimento do campo          *}
{* Agencia/Codigo do Cedente nos boletos                           *}
{*******************************************************************}

function TFreeBancoBASE.FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;
begin
  inherited;
  {
    Exemplo:
    Result := Copy(Boleto.Cedente.CodigoCedente, 1, 3) + '.' +
    Copy(Boleto.Cedente.CodigoCedente, 4, 2) + '.' +
    Copy(Boleto.Cedente.CodigoCedente, 6, 5) + '.' +
    Copy(Boleto.Cedente.CodigoCedente, 11, 1);
  }
end;

{*******************************************************************}
{* M�todo GetCampoLivre(Boleto: TFreeBoleto): string;               *}
{*******************************************************************}
{* Monta o Campo Livre, que varia de banco para banco.             *}
{*******************************************************************}

function TFreeBancoBASE.GetCampoLivre(Boleto: TFreeBoleto): string;
begin
  inherited;
  {
  Como exemplo, veja a implementa��o nas units dos outros bancos
  }
end;

{*******************************************************************}
{* M�todo GetCodigoBanco: string;                                  *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco                              *}
{*******************************************************************}

function TFreeBancoBASE.GetCodigoBanco: string;
begin
  inherited;
  {
  Exemplo:
  Result := '033'; // 033 � o c�digo do BANESPA S/A
  }
end;

{*******************************************************************}
{* M�todo GetCodigoBancoComDigito: string;                         *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco + digito                     *}
{*******************************************************************}

function TFreeBancoBASE.GetCodigoBancoComDigito: string;
begin
  inherited;
  {
  Exemplo:
  Result := '033-7'; // Banespa
  }
end;

{*******************************************************************}
{* Metodo GetDigitoNossoNum(Boleto: TFreeBoleto): char;             *}
{*******************************************************************}
{* Calcula o digito do nosso numero. A formula de calculo muda de  *}
{* banco para banco.                                               *}
{*******************************************************************}

function TFreeBancoBASE.GetDigitoNossoNum(Boleto: TFreeBoleto): char;
begin
  inherited;
  {
  Exemplo:
  Verifique o m�todo nas units dos outros bancos j� prontos
  }
end;

{*******************************************************************}
{* M�todo GetNomeBanco: string;                                    *}
{*******************************************************************}
{* Retorna o nome do banco, impresso no topo do formul�rio do      *}
{* boleto                                                          *}
{*******************************************************************}

function TFreeBancoBASE.GetNomeBanco: string;
begin
  inherited;
  {
  Exemplo:
  Result := 'Banespa';
  }
end;

{*******************************************************************}
{* M�todo GetNumeroBancario(Boleto: TFreeBoleto): string;           *}
{*******************************************************************}
{* Formata o string que � mostrado no boleto impresso no campo     *}
{* Nosso Numero. Cada banco formata isso de uma maneira diferente  *}
{*******************************************************************}

function TFreeBancoBASE.GetNumeroBancario(Boleto: TFreeBoleto): string;
begin
  inherited;
  {
  Exemplo:
  Result := Padl(IntToStr(StrToInt(Boleto.Cedente.Agencia)), 3, '0') + ' ' + Padl(Boleto.NossoNumero,7,'0') + '-' + GetDigitoNossoNum(Boleto);
  }
end;

{*******************************************************************}
{* M�todo InicializaDadosPadroes(Boleto: TFreeBoleto);              *}
{*******************************************************************}
{* Inicializa alguns campos com os valores padr�es, caso n�o tenham*}
{* sido especificados no objeto FreeBoleto                          *}
{*******************************************************************}

procedure TFreeBancoBASE.InicializaDadosPadroes(Boleto: TFreeBoleto);
begin
  inherited;
  {
  Exemplo:
  with Boleto do
  begin
    if Especie = '' then Especie := 'R$';
    if EspecieDoc = '' then EspecieDoc := 'DM - CI';
    if Aceite = '' then Aceite := 'N';
    if Carteira = '' then Carteira := 'COB';
  end;
  }
end;

initialization
  RegisterClass(TFreeBancoBASE); // Substitua "BASE" pelo codigo do banco (3 digitos)

end.

