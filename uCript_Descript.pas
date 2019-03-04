unit uCript_Descript;

interface

uses
//  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
//  StdCtrls, ExtCtrls,
//  Dialogs;

type
    function Cripto(Letra : Char; Codigo : Integer) : Char;
    function Criptografar(Texto : String; Codigo : Integer) : String;
    function Decripto(Letra : Char; Codigo : Integer) : Char;
    function Decriptografar(Texto : String; Codigo: Integer) : String;


implementation

Const
  Cripto = 290290;


function Cripto(Letra: Char): Char;
var
  B : Byte;
begin
  B := Byte(Letra);
  Result := Char(B + Cripto);
end;

function Criptografar(Texto: String): String;
Var Count, Poz : integer;
  L : Char;
  S : String;
begin
  Poz := 1;// Recebe a posi��o inicial.....................
  Count := Length(Texto);// Recebe o tamanho do Texto......
  While Count >= Poz Do// Faz um loop enquanto.............
   Begin // for maior ou igual a Posi��o.....
     L := Char(Texto[Poz]);//Transforma a letra x em char...
     S := S + Cripto(L);// Adiciona a 'S' a letra...
     // J� criptografada.........
     Poz := Poz + 1;// Adciona 1 a posi��o atual............
     Result := S;// O resultado � o texto completo j� criptografado...
   end;
end;

function Decripto(Letra: Char;): Char;
Var B : Byte;
begin
  B := Byte(Letra);// 'B' recebe o valor em byte da leta..........
  Result := Char(B - Cripto);// que � subtra�do ao c�digo passado.
  // e transformado em letra novamente..
end;

function Decriptografar(Texto : String;): String;
  Var Count, Poz : integer;
  L : Char;
  S : String;
begin
  Poz := 1; // Recebe a posi��o inicial.....................
  Count := Length(Texto); // Recebe o tamanho do Texto......
  While Count >= Poz Do//Faz um loop enquanto for maior ou igual a Posi��o
  begin
     L := Char(Texto[Poz]); //Transforma a letra x em char...
     S := S + Decripto(L); // Adiciona a 'S' a letra.
     // J� decriptografada.......
     Poz := Poz + 1; // Adciona 1 a posi��o atual............
  end;

  Result := S;// O resulltado � o texto completo j� criptografado...
end;

end.
