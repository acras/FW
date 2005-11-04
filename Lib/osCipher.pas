unit osCipher;

interface

const IVSize = 10;

type
  ByteArray = Array [0..255] of Byte;

  TCipher = class(TObject)
  private
    Key, State : ByteArray;
    KeyString : string;
    KeyLength : integer;

    procedure Zero (var InArray : ByteArray; Size : Integer);

    procedure String2Array (InString : string; StringLength : Integer;
                            var OutArray : ByteArray);

    procedure GetKey (var InString : String; var Stringlength : Integer);

    procedure RC4Setup (InKey : ByteArray; KeySize : Integer);

    procedure RC4Cipher (var InputString, OutputString : string; Size: integer);

  public
    function Encode (InputString: string) : string;

    function Decode (InputString: string) : string;

  end;


implementation

procedure TCipher.Zero(VAR InArray : ByteArray; Size : Integer);
var
  Count : integer;
begin
  for Count := 0 to Size do
    InArray[Count] := 0
end;

procedure TCipher.String2Array (InString : string; StringLength : Integer;
                                var OutArray : ByteArray);
var
  Count : Integer;
begin
  for Count := 1 to StringLength do
    OutArray[Count-1] := Ord(InString[Count])
end;


// Gets InString, a string of length <= 256 - IVSize bytes
procedure TCipher.GetKey (var InString : string; var Stringlength : Integer);
begin
  InString := 'ItApOcUrUmIxSaIgUaÇu';
  StringLength := Length(InString);
end;

procedure TCipher.RC4Setup (InKey : ByteArray; KeySize : Integer);
var
  i, j, HoldInfo : integer;
begin
  j := 0;
  for i := 0 To 255 do
    State[i] := i;

  for i := 0 to 255 do
  begin
    j := (j + State[i] + InKey[i mod KeySize]) mod 256;
    HoldInfo := State[i];
    State[i] := State[j];
    State[j] := HoldInfo;
  end;
end;


procedure TCipher.RC4Cipher (var InputString, OutputString : string; Size: integer);
var
  i, j, k, n, HoldInfo : integer;
  OutPutByte, MessageByte : byte;
begin;
  i := 0;
  j := 0;

  for k := 1 to Size do
  begin
    i := (i + 1) mod 256;
    j := (j + State[i]) mod 256;
    HoldInfo := State[i];
    State[i] := State[j];
    State[j] := HoldInfo;
    n := (State[i] + State[j]) mod 256;
    MessageByte := byte(InputString[k]);
    OutputByte := State[n] xor MessageByte;
    OutputString[k] := char(OutputByte);
  end;
end;

function TCipher.Encode (InputString: string) : string;
var
  InitVector : string;
  OutputString : string;
  Count : integer;
  n : integer;

begin
  Zero (Key, 255);
  Zero (State, 255);
  GetKey(KeyString, KeyLength);
  String2Array(KeyString, KeyLength, Key);

  n := Length(InputString);
  SetLength(OutputString, n);
  SetLength(InitVector, IVSize);

  // generate a random IV, put it at the end of Key
  Randomize;
  for Count := 1 to IVSize do
  begin
    Key[Count + KeyLength -1] := Random(256);
    InitVector[Count] := char(Key[Count + KeyLength - 1]);
  end;
  KeyLength := KeyLength + IVSize;
  RC4Setup(Key, KeyLength);
  RC4Cipher (InputString, OutputString, n);

  Result := InitVector + OutputString;
end;


function TCipher.Decode (InputString: string) : string;
var
  OutputString : string;
  Count : integer;
  n : integer;
begin
  Zero (Key, 255);
  Zero (State, 255);
  GetKey(KeyString, KeyLength);
  String2Array(KeyString, KeyLength, Key);

  n := Length(InputString) - IVSize;
  SetLength(OutputString, n);

  // get the InitVector from the input string
  for Count := 1 to IVSize do
  begin
    Key[Count + KeyLength - 1] := byte(InputString[Count]);
  end;
  KeyLength := KeyLength + IVSize;
  RC4Setup(Key, KeyLength);
  InputString := Copy(InputString, IVSize + 1, n);
  RC4Cipher (InputString, OutputString, n);

  Result := OutputString;
end;


end.



