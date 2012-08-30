unit osFuncoesParser;

interface

uses sysUtils, Classes, Math;

function seno(Parametros: TList): Double; forward;
function cosen(Parametros: TList): Double; forward;
function potencia(Parametros: TList): Double; forward;
function raiz(Parametros: TList): Double; forward;
function teste(Parametros: TList): Double; forward;
function iif(Parametros: TList): Double; forward;
function sub(Parametros: TList): string; forward;
function sif(Parametros: TList): string; forward;

implementation

function seno(Parametros: TList): Double;
begin
  Result := Sin(Double(Parametros.Items[0]^));
end;

function cosen(Parametros: TList): Double;
begin
  Result := cos(Double(Parametros.Items[0]^));
end;

function potencia(Parametros: TList): Double;
begin
  Result := Power(Double(Parametros.Items[0]^), Double(Parametros.Items[1]^));
end;

function raiz(Parametros: TList): Double;
begin
  Result := Sqrt(Double(Parametros.Items[0]^));
end;

function teste(Parametros: TList): Double;
begin
  Result := Double(Parametros.Items[0]^);
  if Result <> 1 then
    raise Exception.Create('Teste inválido');
end;

function iif(Parametros: TList): Double;
var
  ExpLogica: double;
begin
  ExpLogica := Double(Parametros.Items[2]^);
  if ExpLogica <> 1 then
    Result := Double(Parametros.Items[0]^)
  else
    Result := Double(Parametros.Items[1]^);
end;

function sub(Parametros: TList): string;
var
  valor, antigo, novo: String;
begin
  valor := PChar(Parametros.Items[2]);
  antigo := PChar(Parametros.Items[1]);
  novo := PChar(Parametros.Items[0]);
  Result := StringReplace(valor,antigo,novo,[rfReplaceAll]);
end;

function sif(Parametros: TList): string;
var
  ExpLogica: double;
begin
  ExpLogica := Double(Parametros.Items[2]^);
  if ExpLogica <> 1 then
    Result := PChar(Parametros.Items[0])
  else
    Result := PChar(Parametros.Items[1]);
end;

end.


