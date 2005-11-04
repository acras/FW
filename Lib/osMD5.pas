{** Message Digest 5 : Rotina de criação de chave fixa a partir de uma semente. }
unit osMD5;
{
  Algoritmo de Message Digest MD5
  (c) 1991-1992, RSA Data Security, Inc. All rights reserved.
  A partir do código original em C

  $Header: \FW/Lib/osMD5.pas,v 1.1.1.1 2004/12/10 19:19:28 Ricardo Acras Exp $

  $Log: osMD5.pas,v $
  Revision 1.1.1.1  2004/12/10 19:19:28  Ricardo Acras
  no message

  Revision 1.2  2004/12/02 16:14:19  Administrador
  no message

  Revision 1.1.1.1  2004/11/26 18:33:18  Walter
  no message

  Revision 1.1.1.1  2004/11/26 18:09:10  Walter
  no message

  Revision 1.1.1.1  2004/11/17 18:48:24  Walter
  no message

  Revision 1.1.1.1  2004/10/27 15:11:48  rica
  no message

  Revision 1.1.1.1  2004/10/15 18:11:32  Walter
  no message

  Revision 1.1.1.1  2004/03/10 14:54:12  rica
  no message



2     1/10/98 17:26 Josue

1     30/09/98 14:25 Josue

Message Digest Algorithm

}

interface

{** Message Digest 5 : Rotina de criação de chave fixa a partir de uma semente. }
function MD5Digest(s : String) : string;

implementation

uses
  SysUtils;

const
  S11 = 7;
  S12 = 12;
  S13 = 17;
  S14 = 22;
  S21 = 5;
  S22 = 9;
  S23 = 14;
  S24 = 20;
  S31 = 4;
  S32 = 11;
  S33 = 16;
  S34 = 23;
  S41 = 6;
  S42 = 10;
  S43 = 15;
  S44 = 21;

type

TMD5Context = record
  State : Array [0..3] of LongWord;
  Count : Array [0..1] of LongWord;
  Buffer : Array [0..63] of Byte;
end;

TInputBlock = record
  InputBlock : Array [0..1023] of Byte;
  nSize : Word;
end;

var
  Padding : Array [0..63] of Byte;

function RotateLeft(x , n : LongWord) : LongWord;
begin
  RotateLeft := (((x) shl (n)) or ((x) shr (32-(n))));
end;

function F(x, y, z : LongWord) : LongWord;
begin
  F := ((x and y) or ((not x) and z));
end;

function G(x, y, z : LongWord) : LongWord;
begin
  G := ((x and z) or (y and (not z)));
end;

function H(x, y, z : LongWord) : LongWord;
begin
  H := (x xor y xor z);
end;

function I(x, y, z : LongWord) : LongWord;
begin
  I := (y xor (x or (not z)));
end;

// ------------------------------------------

procedure FF(var a : LongWord; b, c, d, x, s, ac : LongWord);
begin
  a := a + F(b, c, d) + x + ac;
  a := RotateLeft (a, s);
  a := a + b;
end;

procedure GG(var a : LongWord; b, c, d, x, s, ac : LongWord);
begin
  a := a + G(b, c, d) + x + ac;
  a := RotateLeft (a, s);
  a := a + b;
end;

procedure HH(var a : LongWord; b, c, d, x, s, ac : LongWord);
begin
  a := a + H(b, c, d) + x + ac;
  a := RotateLeft (a, s);
  a := a + b;
end;

procedure II(var a : LongWord; b, c, d, x, s, ac : LongWord);
begin
  a := a + I(b, c, d) + x + ac;
  a := RotateLeft (a, s);
  a := a + b;
end;

procedure MD5_memcpy (var output : Array of Byte; initout : Word; input : Array of Byte; initin, len : Word);
var
  i : Word;
begin
  for i := 1 to len do
	  output[initout + i - 1] := input[initin + i - 1];
end;

procedure MD5_memset (var output : Array of Byte; value : Byte; len : Word);
var
  i : Word;
begin
  for i := 0 to len do
	  output[i] := value;
end;

procedure Encode (var output : Array of Byte; input : Array of LongWord;init, len : Word);
var
  i, j : Word;
begin;
  i := init;
  j := 0;

  while j < len do
  begin
    output[j] := input[i] and $FF;
    output[j + 1] := (input[i] shr 8) and $FF;
    output[j + 2] := (input[i] shr 16) and $FF;
    output[j + 3] := (input[i] shr 24) and $FF;

    i := i + 1;
    j := j + 4;
  end;
end;

procedure Decode (var output : Array of LongWord; input : Array of Byte;init, len : Word);
var
  i, j : Word;
begin
  j := 0;
  i := init;

  while j < len do
  begin
     output[i] := input[j] or
        ( (input[j + 1]) shl 8) or
        ( (input[j + 2]) shl 16) or
        ( (input[j + 3]) shl 24);

     i := i + 1;
     j := j + 4;
  end;

end;

procedure MD5Transform (var state : Array of LongWord; Block : array of Byte; init : Word);
var
  a, b, c, d : LongWord;
  x : Array [0..15] of LongWord;
begin

  a := state[0];
  b := state[1];
  c := state[2];
  d := state[3];

  Decode (x, block, init, 64);

  // Round 1
  FF (a, b, c, d, x[ 0], S11, $d76aa478); // 1
  FF (d, a, b, c, x[ 1], S12, $e8c7b756); // 2
  FF (c, d, a, b, x[ 2], S13, $242070db); // 3
  FF (b, c, d, a, x[ 3], S14, $c1bdceee); // 4 
  FF (a, b, c, d, x[ 4], S11, $f57c0faf); // 5
  FF (d, a, b, c, x[ 5], S12, $4787c62a); // 6
  FF (c, d, a, b, x[ 6], S13, $a8304613); // 7 
  FF (b, c, d, a, x[ 7], S14, $fd469501); // 8
  FF (a, b, c, d, x[ 8], S11, $698098d8); // 9
  FF (d, a, b, c, x[ 9], S12, $8b44f7af); // 10 
  FF (c, d, a, b, x[10], S13, $ffff5bb1); // 11 
  FF (b, c, d, a, x[11], S14, $895cd7be); // 12
  FF (a, b, c, d, x[12], S11, $6b901122); // 13
  FF (d, a, b, c, x[13], S12, $fd987193); // 14
  FF (c, d, a, b, x[14], S13, $a679438e); // 15
  FF (b, c, d, a, x[15], S14, $49b40821); // 16 

 // Round 2
  GG (a, b, c, d, x[ 1], S21, $f61e2562); // 17
  GG (d, a, b, c, x[ 6], S22, $c040b340); // 18
  GG (c, d, a, b, x[11], S23, $265e5a51); // 19
  GG (b, c, d, a, x[ 0], S24, $e9b6c7aa); // 20
  GG (a, b, c, d, x[ 5], S21, $d62f105d); // 21
  GG (d, a, b, c, x[10], S22,  $2441453); // 22 
  GG (c, d, a, b, x[15], S23, $d8a1e681); // 23 
  GG (b, c, d, a, x[ 4], S24, $e7d3fbc8); // 24 
  GG (a, b, c, d, x[ 9], S21, $21e1cde6); // 25 
  GG (d, a, b, c, x[14], S22, $c33707d6); // 26
  GG (c, d, a, b, x[ 3], S23, $f4d50d87); // 27
  GG (b, c, d, a, x[ 8], S24, $455a14ed); // 28
  GG (a, b, c, d, x[13], S21, $a9e3e905); // 29
  GG (d, a, b, c, x[ 2], S22, $fcefa3f8); // 30
  GG (c, d, a, b, x[ 7], S23, $676f02d9); // 31
  GG (b, c, d, a, x[12], S24, $8d2a4c8a); // 32

  // Round 3
  HH (a, b, c, d, x[ 5], S31, $fffa3942); // 33
  HH (d, a, b, c, x[ 8], S32, $8771f681); // 34 
  HH (c, d, a, b, x[11], S33, $6d9d6122); // 35
  HH (b, c, d, a, x[14], S34, $fde5380c); // 36 
  HH (a, b, c, d, x[ 1], S31, $a4beea44); // 37 
  HH (d, a, b, c, x[ 4], S32, $4bdecfa9); // 38 
  HH (c, d, a, b, x[ 7], S33, $f6bb4b60); // 39
  HH (b, c, d, a, x[10], S34, $bebfbc70); // 40
  HH (a, b, c, d, x[13], S31, $289b7ec6); // 41
  HH (d, a, b, c, x[ 0], S32, $eaa127fa); // 42 
  HH (c, d, a, b, x[ 3], S33, $d4ef3085); // 43
  HH (b, c, d, a, x[ 6], S34,  $4881d05); // 44
  HH (a, b, c, d, x[ 9], S31, $d9d4d039); // 45 
  HH (d, a, b, c, x[12], S32, $e6db99e5); // 46
  HH (c, d, a, b, x[15], S33, $1fa27cf8); // 47
  HH (b, c, d, a, x[ 2], S34, $c4ac5665); // 48 

  // Round 4
  II (a, b, c, d, x[ 0], S41, $f4292244); // 49
  II (d, a, b, c, x[ 7], S42, $432aff97); // 50 
  II (c, d, a, b, x[14], S43, $ab9423a7); // 51
  II (b, c, d, a, x[ 5], S44, $fc93a039); // 52
  II (a, b, c, d, x[12], S41, $655b59c3); // 53
  II (d, a, b, c, x[ 3], S42, $8f0ccc92); // 54 
  II (c, d, a, b, x[10], S43, $ffeff47d); // 55
  II (b, c, d, a, x[ 1], S44, $85845dd1); // 56
  II (a, b, c, d, x[ 8], S41, $6fa87e4f); // 57
  II (d, a, b, c, x[15], S42, $fe2ce6e0); // 58
  II (c, d, a, b, x[ 6], S43, $a3014314); // 59
  II (b, c, d, a, x[13], S44, $4e0811a1); // 60
  II (a, b, c, d, x[ 4], S41, $f7537e82); // 61 
  II (d, a, b, c, x[11], S42, $bd3af235); // 62 
  II (c, d, a, b, x[ 2], S43, $2ad7d2bb); // 63 
  II (b, c, d, a, x[ 9], S44, $eb86d391); // 64

  state[0] := state[0] + a;
  state[1] := state[1] + b;
  state[2] := state[2] + c;
  state[3] := state[3] + d;

  // Zeroize sensitive information.
  // MD5_memset (x, 0, 16);
end;

procedure MD5Init(var md5Context : TMD5Context);
var
  i : Word;
begin
  md5Context.count[0] := 0;
  md5Context.count[1] := 0;

  // Load magic initialization constants.
  md5Context.state[0] := $67452301;
  md5Context.state[1] := $efcdab89;
  md5Context.state[2] := $98badcfe;
  md5Context.state[3] := $10325476;

  Padding[0] := $80;

  for i := 1 to 63 do
    Padding[i] := 0;
end;

procedure MD5Update (var md5Context : TMD5Context; inputBlock : TInputBlock);
var
  i, index, partLen : Word;
begin

  // Compute number of bytes mod 64
  index := ((md5Context.count[0] shr 3) and $3F);

  // Update number of bits
  md5Context.count[0] := md5Context.count[0] + (inputBlock.nSize shl 3);
  if md5Context.count[0] < (inputBlock.nSize shl 3) then
    md5Context.count[1] := md5Context.count[1] + 1;

  md5Context.count[1] := md5Context.count[1] + (inputBlock.nSize shr 29);

  partLen := 64 - index;

  // Transform as many times as possible.
  if inputBlock.nSize >= partLen then
  begin
    MD5_memcpy(md5context.buffer, index, inputBlock.inputBlock, 0, partLen);

    MD5Transform (md5Context.state, md5Context.buffer, 0);

    i := partLen;
    while i + 63 < inputBlock.nSize do
    begin
      MD5Transform (md5Context.state, inputBlock.inputBlock, i);
      i := i + 64;
    end;

    index := 0;
  end
  else
    i := 0;

  // Buffer remaining input
  MD5_memcpy(md5Context.buffer, index, inputBlock.inputBlock, i, inputBlock.nSize - i);
end;

procedure MD5Final (var digest : array of Byte; md5Context : TMD5Context);
var
  bits : Array [0..7] of Byte;
  index, padLen : Word;
  ibTemp : TInputBlock;
begin
  // Save number of bits
  Encode (bits, md5context.Count, 0, 8);

  // Pad out to 56 mod 64.
  index := ((md5Context.count[0] shr 3) and $3f);
  if index < 56 then
     padLen := 56 - index
  else
     padLen := 120 - index;

  MD5_memcpy (ibTemp.inputBlock, 0, Padding, 0, 64);
  ibTemp.nSize := padLen;
  MD5Update (md5Context, ibTemp);

  // Append length (before padding)
  MD5_memcpy (ibTemp.inputBlock, 0, bits, 0, 8);
  ibTemp.nSize := 8;
  MD5Update (md5Context, ibTemp);

  // Store state in digest/
  Encode (digest, md5Context.State, 0, 16);

  // Zeroize sensitive information.
  ///MD5_memset ((POINTER)context, 0, sizeof (*context));
end;

function MD5Digest(s : String) : string;
var
  md5Context : TMD5Context;
  ibTemp : TInputBlock;
  digest : Array [0..15] of Byte;
  retorno : string;
  i : Word;
begin

  for i := 1 to Length(s) do
  begin
    ibTemp.InputBlock[i - 1] := Ord(s[i]);
  end;
  ibTemp.nSize := Length(s);

  MD5Init (md5Context);
  MD5Update (md5Context, ibTemp);
  MD5Final (digest, md5Context);

  retorno := '';
  for i := 0 to 15 do
    retorno := retorno + LowerCase(Format('%.2x', [digest[i]]));

  MD5Digest := Retorno
end;
// -- iniciaçao da unit

begin
end.

