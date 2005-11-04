unit osXMLDOMUtils;

interface

uses
  MSXML_TLB, DB;

type
  TTipoObjeto = (toBD);

function getValueFromAttributes(attributes: IXMLDOMNamedNodeMap; name: string):OLEVariant;
function criarObjeto(doc: IXMLDOMDocument; tipoObjeto: TTipoObjeto; nome: string):IXMLDomElement;
function criarObjetoBD(doc: IXMLDOMDocument; nome: string):IXMLDomElement;
function criarObjetoMeta(doc: IXMLDOMDocument):IXMLDomElement;
procedure adicionarCampoMeta(nome: string; tipo: TFieldType; doc: IXMLDOMDocument; no: IXMLDomElement);
procedure adicionarCampoMetaBLOB(nome: string; subTipo: TBlobType;
  doc: IXMLDOMDocument; no: IXMLDomElement);
function Encode64(S: string): string;
function Decode64(S: string): string;

const
  Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

implementation

function getValueFromAttributes(attributes: IXMLDOMNamedNodeMap; name: string): OLEVariant;
var
  i: integer;
begin
  for i := 0 to attributes.length-1 do
  begin
    if attributes[i].nodeName=name then
      result := attributes[i].nodeValue;
  end;
end;

function criarObjeto(doc: IXMLDOMDocument; tipoObjeto: TTipoObjeto; nome: string):IXMLDomElement;
var
  elemento: IXMLDomElement;
begin
  elemento := doc.createElement('Objeto');
  elemento.setAttribute('Tipo', 'BD');
  elemento.setAttribute('Nome', nome);
  result := elemento;
end;

function criarObjetoBD(doc: IXMLDOMDocument; nome: string):IXMLDomElement;
begin
  result := criarObjeto(doc, toBD, nome);
end;

function criarObjetoMeta(doc: IXMLDOMDocument):IXMLDomElement;
begin
  result := doc.createElement('Meta');
end;

procedure adicionarCampoMeta(nome: string; tipo: TFieldType; doc: IXMLDOMDocument; no: IXMLDomElement);
var
  elemento: IXMLDomElement;
begin
  elemento := doc.createElement('Campo');
  elemento.setAttribute('Nome', nome);
  elemento.setAttribute('Tipo', tipo);
  no.appendChild(elemento);
end;

procedure adicionarCampoMetaBLOB(nome: string; subTipo: TBlobType;
  doc: IXMLDOMDocument; no: IXMLDomElement);
var
  elemento: IXMLDomElement;
begin
  elemento := doc.createElement('Campo');
  elemento.setAttribute('Nome', nome);
  elemento.setAttribute('Tipo', ftBlob);
  elemento.setAttribute('SubTipo', subTipo);
  no.appendChild(elemento);
end;

function Encode64(S: string): string;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Ord(s[i]);
    b := b * 256 + x;
    a := a + 8;
    while a >= 6 do
    begin
      a := a - 6;
      x := b div (1 shl a);
      b := b mod (1 shl a);
      Result := Result + Codes64[x + 1];
    end;
  end;
  if a > 0 then
  begin
    x := b shl (6 - a);
    Result := Result + Codes64[x + 1];
  end;
end;

function Decode64(S: string): string;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Pos(s[i], codes64) - 1;
    if x >= 0 then
    begin
      b := b * 64 + x;
      a := a + 6;
      if a >= 8 then
      begin
        a := a - 8;
        x := b shr a;
        b := b mod (1 shl a);
        x := x mod 256;
        Result := Result + chr(x);
      end;
    end
    else
      Exit;
  end;
end;

end.
