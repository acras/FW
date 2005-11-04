unit osExtenso;

interface

uses SysUtils;

function ValorPorExtenso(PValor : double) : string;
function MilharPorExtenso(PCentena : integer) : string;

const
  Centena : array[1..9] of string =
    ('cento ',
     'duzentos ',
     'trezentos ',
     'quatrocentos ',
     'quinhentos ',
     'seiscentos ',
     'setecentos ',
     'oitocentos ',
     'novecentos '
     );

  Dezena : array[1..9] of string =
    (
     'dez ',
     'vinte ',
     'trinta ',
     'quarenta ',
     'cinquenta ',
     'sessenta ',
     'setenta ',
     'oitenta ',
     'noventa '
    );

  Vintena : array[1..9] of string =
    ('onze ',
     'doze ',
     'treze ',
     'quatorze ',
     'quinze ',
     'dezesseis ',
     'dezessete ',
     'dezoito ',
     'dezenove '
     );

  Unidade : array[1..9] of string =
    (
     'um ',
     'dois ',
     'tres ',
     'quatro ',
     'cinco ',
     'seis ',
     'sete ',
     'oito ',
     'nove '
     );

  Cifra : array[1..6, 1..2] of string =
    ( ('trilhão ', 'trilhões '),
      ('bilhão ', 'bilhões '),
      ('milhão ', 'milhões '),
      ('mil ', 'mil '),
      ('', ''),
      ('centavo ', 'centavos ')
    );

  Moeda = 'real ';
  Moedas = 'reais ';

implementation

Function MilharPorExtenso(PCentena : integer): string;
var
  sExtenso : string;
  sValor : string;
  iCentena : integer;
  iDezena : integer;
  iUnidade : integer;
begin
  if (PCentena > 0) then
  begin
    if PCentena = 100 then begin
      sExtenso := 'cem ';
    end
    else
    begin
      sValor := Format('%3.3d', [PCentena]);
      iCentena := StrToInt(sValor[1]);
      iDezena := StrToInt(sValor[2]);
      iUnidade := StrToInt(sValor[3]);

      if (iCentena > 0 ) then
      begin
        sExtenso := Centena[iCentena];
        if (iDezena > 0) or (iUnidade > 0) then
          sExtenso := sExtenso + 'e ';
      end;

      if (iDezena = 1) and (iUnidade > 0) then
      begin
        sExtenso := sExtenso + Vintena[iUnidade];
      end
      else
      begin
        if iDezena > 0 then
        begin
          sExtenso := sExtenso + Dezena[iDezena];
          if iUnidade > 0 then
            sExtenso := sExtenso + 'e ';
        end;

        if iUnidade > 0 then
          sExtenso := sExtenso + Unidade[iUnidade];
      end;
    end;
  end;
  Result := sExtenso;
end;


Function ValorPorExtenso(PValor : double) : string;
var
  sValor : string;
  iCentavo : integer;
  iMilhar : array [1..5] of integer;
  sExtenso : string;

  i : integer;
  j : integer;

  dValorInt : double;

begin
  sExtenso := '';
  if PValor > 0 then
  begin
    sValor := Format('%d', [Round(PValor * 100)]);
    sValor := StringOfChar('0', 17 - Length(sValor)) + sValor;

    iCentavo := StrToInt(Copy(sValor, 16, 2));

    for i := 1 to 5 do
    begin
      iMilhar[i] := StrToInt(Copy(sValor, (i - 1) * 3 + 1, 3));
      if iMilhar[i] > 0 then
      begin
        if sExtenso <> '' then
          sExtenso := sExtenso + 'e ';

        if iMilhar[i] = 1 then
          j := 1    // singular
        else
          j := 2;   // plural

        sExtenso := sExtenso + MilharPorExtenso(iMilhar[i]) + Cifra[i, j];

      end;
    end;

    dValorInt := Int(PValor);
    if dValorInt > 0 then
    begin
      if Int(PValor) = 1 then
        begin
          sExtenso := sExtenso + Moeda;
        end
      else
      begin
        if (PValor >= 1000000) and (iMilhar[4] = 0) and(iMilhar[5] = 0) then
          sExtenso := sExtenso + 'de ' + Moedas
        else
          sExtenso := sExtenso + Moedas;
      end;
    end;

    if iCentavo > 0 then
    begin
      if sExtenso <> '' then
        sExtenso := sExtenso + 'e ';

      if iCentavo = 1 then
        j := 1
      else
        j := 2;

      sExtenso := sExtenso + MilharPorExtenso(iCentavo) + Cifra[6, j];
    end;

    if Copy(sExtenso, 1, 2) = 'um' then
      Result := '' + sExtenso
    else
      Result := UpperCase(sExtenso[1]) + Copy(sExtenso, 2, 10000);
  end
  else
    Result := ''; // Valor zero ou negativo

end;

end.
