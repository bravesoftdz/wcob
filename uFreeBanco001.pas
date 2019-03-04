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

unit uFreeBanco001; // BANCO DO BRASIL

// Aten��o, essa unit est� preparada para trabalhar com a carteira 18 e convenios de 6 digitos.
// Adapta��es podem ser feitas para suportar as outras carteiras/convenios, basta entender a
// documenta��o "podre" que o BB oferece.

interface

uses classes, SysUtils, uFreeBoleto, uFuncAux;

type
  TFreeBanco001 = class(TFreeClasseBanco)
  private
    function GetModulo11BB(str: string; base: integer): char; // Substitua "BASE" pelo codigo do banco (3 digitos)
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

{ TFreeBanco001 }

{*******************************************************************}
{* M�todo ChecarDadosIniciais(Boleto: TFreeBoleto)                  *}
{*******************************************************************}
{* Rotina executada no in�cio da fase de prepara��o do boleto      *}
{* Serve para validar se os dados inseridos no TFreeBoleto est�o no *}
{* formato correto, ver se os campos obrigat�rios foram            *}
{* preenchidos, etc.                                               *}
{*******************************************************************}

procedure TFreeBanco001.ChecarDadosIniciais(Boleto: TFreeBoleto);
var
  TamanhoConvenio: Integer;
begin
  inherited;
  with Boleto do
  begin
    TamanhoConvenio := Length(Cedente.Banco001.Convenio);
    if (TamanhoConvenio = 4) and (Length(NossoNumero) > 7) then
      raise EFreeBoleto.Create('O tamanho do NossoN�mero n�o pode ser maior que 7 caracteres!')
    else
      if ((TamanhoConvenio = 6) or (TamanhoConvenio = 7)) and (Length(NossoNumero) > 10) then
        raise EFreeBoleto.Create('O tamanho do NossoN�mero n�o pode ser maior que 10 caracteres!');

    if Cedente.Banco001.Convenio = '' then
      raise EFreeBoleto.Create('� necess�rio informar o conv�nio!')
    else
      if TamanhoConvenio > 7 then
        raise EFreeBoleto.Create('UNIT preparada apenas para convenios de at� 7 d�gitos!');
  end;
end;

{*******************************************************************}
{* M�todo FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;   *}
{*******************************************************************}
{* Formata o string que � usado no preenchimento do campo          *}
{* Agencia/Codigo do Cedente nos boletos                           *}
{*******************************************************************}

function TFreeBanco001.FormataAgencCodigoCedente(Boleto: TFreeBoleto): string;
begin
  inherited;
  Result := Copy(Boleto.Cedente.Agencia, 1, 4) + '/' + Boleto.Cedente.CodigoCedente + '-' + GetModulo11BB(Boleto.Cedente.CodigoCedente,9);
end;

{*******************************************************************}
{* M�todo GetCampoLivre(Boleto: TFreeBoleto): string;               *}
{*******************************************************************}
{* Monta o Campo Livre, que varia de banco para banco.             *}
{*******************************************************************}

function TFreeBanco001.GetCampoLivre(Boleto: TFreeBoleto): string;
var x: string;
begin
  inherited;
  x := '';
  with Boleto, cedente, banco001 do
  begin
    if Length(Convenio) = 4 then
      Result := Padl(Convenio, 4, '0') + Padl(NossoNumero, 7, '0') + Agencia + CodigoCedente + Carteira
    else
      if (Length(Convenio) = 6) then
        Result := Padl(Convenio, 6, '0') + Padl(NossoNumero, 17, '0') + '21' // 21 indica que o N.N. tem 17 d�gitos
      else
        if Length(Convenio) = 7 then
          Result := '000000' + Padl(Convenio, 7, '0') + Padl(NossoNumero, 10, '0') + Carteira;
  end;
end;

{*******************************************************************}
{* M�todo GetCodigoBanco: string;                                  *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco                              *}
{*******************************************************************}

function TFreeBanco001.GetCodigoBanco: string;
begin
  inherited;
  Result := '001'; // BANCO DO BRASIL
end;

{*******************************************************************}
{* M�todo GetCodigoBancoComDigito: string;                         *}
{*******************************************************************}
{* Retorna o c�digo nacional do banco + digito                     *}
{*******************************************************************}

function TFreeBanco001.GetCodigoBancoComDigito: string;
begin
  inherited;
  Result := '001-9'; // BANCO DO BRASIL
end;

{*******************************************************************}
{* Metodo GetDigitoNossoNum(Boleto: TFreeBoleto): char;             *}
{*******************************************************************}
{* Calcula o digito do nosso numero. A formula de calculo muda de  *}
{* banco para banco.                                               *}
{*******************************************************************}

function TFreeBanco001.GetModulo11BB(str:string; base:integer): char;
var digito:string; resto:integer;
begin
  digito := Modulo11(str, base, resto);
  if resto = 10 then
    Result := 'X'
  else
    Result := digito[1];
end;

function TFreeBanco001.GetDigitoNossoNum(Boleto: TFreeBoleto): char;
var x: string;
begin
  inherited;
  x := Padl(Boleto.cedente.banco001.convenio, 6, '0') + Padl(Boleto.NossoNumero, 5, '0');
  Result:=GetModulo11BB(x,9);
end;

{*******************************************************************}
{* M�todo GetNomeBanco: string;                                    *}
{*******************************************************************}
{* Retorna o nome do banco, impresso no topo do formul�rio do      *}
{* boleto                                                          *}
{*******************************************************************}

function TFreeBanco001.GetNomeBanco: string;
begin
  inherited;
  Result := 'Banco Brasil';
end;

{*******************************************************************}
{* M�todo GetNumeroBancario(Boleto: TFreeBoleto): string;           *}
{*******************************************************************}
{* Formata o string que � mostrado no boleto impresso no campo     *}
{* Nosso Numero. Cada banco formata isso de uma maneira diferente  *}
{*******************************************************************}

function TFreeBanco001.GetNumeroBancario(Boleto: TFreeBoleto): string;
begin
  inherited;
  if (Length(Boleto.Cedente.Banco001.Convenio) = 6) then // Quando o conv�nio tem 6 d�gitos o N.N. n�o possui d�gito verificador
    Result := Padl(Boleto.cedente.banco001.convenio, 6, '0') + Padl(Boleto.NossoNumero, 11, '0')
  else
    Result := Padl(Boleto.cedente.banco001.convenio, 6, '0') + Padl(Boleto.NossoNumero, 5, '0') + '-' + GetDigitoNossoNum(Boleto);
end;

{*******************************************************************}
{* M�todo InicializaDadosPadroes(Boleto: TFreeBoleto);              *}
{*******************************************************************}
{* Inicializa alguns campos com os valores padr�es, caso n�o tenham*}
{* sido especificados no objeto FreeBoleto                          *}
{*******************************************************************}

procedure TFreeBanco001.InicializaDadosPadroes(Boleto: TFreeBoleto);
begin
  inherited;
  with Boleto do
  begin
    if Especie = '' then Especie := 'R$';
    if Aceite = '' then Aceite := 'N';
    if Carteira = '' then Carteira := '18'; // Sem registro
  end;
end;

initialization
  RegisterClass(TFreeBanco001); // Banco do Brasil

end.

