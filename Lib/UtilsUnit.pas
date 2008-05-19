unit UtilsUnit;



interface

uses
  IBServices, INIFiles, SysUtils, Forms, AbZipper, Windows, StrUtils, Controls,
  osComboSearch, graphics, Classes, DBCtrls, wwdbdatetimepicker, Wwdbcomb,
  Math;

type
  varArrayOfcomps = array of TComponent;

function isDigitOrControl(Key: char): boolean;
function RemoveAcento(Str:String): String;
procedure criarArquivoBackupIB(nomeArq: string);
function getSombraValue(Str:String): String;
function TiraSimbolos(Str: String): String;
function LastDayOfMonth(dia: TDate = 0): TDate;
procedure setHabilitaComboSearch(cbo: TosComboSearch; enabled: boolean);
procedure setHabilitaComponente(comp: TComponent; enabled: boolean);
procedure habilitaComponentes(comps: varArrayOfcomps);
procedure desHabilitaComponentes(comps: array of TComponent);
procedure setHabilitaDBEdit(edt: TDBEdit; enabled: boolean);
procedure setHabilitawwComboBox(comboBox: TwwDBComboBox; enabled: boolean);
procedure setHabilitawwDateTimePicker(dateTimePicker: TwwDBDateTimePicker; enabled: boolean);
function roundToCurr(val: double): double;

implementation

uses DateUtils, Variants;


function isDigitOrControl(Key: char): boolean;
var
  um, dois, tres, quatro, cinco: boolean;
begin
  //este código está muito muito feio
  um := ord(key)<32;
  dois := ord(key)=127;
  tres := ord(key)>47;
  quatro := ord(key)<58;
  cinco := um or dois or (tres and quatro);
  result := cinco;
end;

function RemoveAcento(Str:String): String;
Const
  ComAcento = 'àâêôûãõáéíóúçüäÀÂÊÔÛÃÕÁÉÍÓÚÇÜÄ';
  SemAcento = 'aaeouaoaeioucuaAAEOUAOAEIOUCUA';
Var
  x : Integer;
Begin
  For x := 1 to Length(Str) do
    if Pos(Str[x],ComAcento)<>0 Then
      Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

procedure criarArquivoBackupIB(nomeArq: string);
var
  IBBackup: TIBBackupService;
  zipper: TABZipper;
begin
  IBBackup := TIBBackupService.Create(nil);
  zipper := TAbZipper.Create(nil);
  try
    DeleteFile('tmp.gbk');
    IBBackup.Active := false;
    IBBackup.DatabaseName := ExtractFilePath(Application.ExeName) + '..\DB\' +
      copy(ExtractFileName(Application.ExeName),1,pos('.',ExtractFileName(Application.ExeName))-1) + '.gdb';
    IBBackup.LoginPrompt := false;
    IBBackup.Params.Clear;
    IBBackup.Params.Add('user_name=sysdba');
    IBBackup.Params.Add('password=masterkey');
    IBBackup.BackupFile.Add(ExtractFilePath(Application.ExeName) + 'tmp.gbk');
    IBBackup.Active := true;
    IBBackup.ServiceStart;
    while IBBackup.IsServiceRunning do Sleep(1);
    IBBackup.Active := false;
    DeleteFile(PCHAR(ExtractFilePath(Application.ExeName) + 'tmp.zip'));
    Zipper.FileName := ExtractFilePath(Application.ExeName) + 'tmp.zip';
    Zipper.AddFiles(ExtractFilePath(Application.ExeName) + 'tmp.gbk',0);
    Zipper.CloseArchive;
    deleteFile(PCHAR(ExtractFilePath(Application.ExeName) + '..\backups\ultimoBackup.bkp'));
    CopyFile(PAnsiChar(ExtractFilePath(Application.ExeName) + 'tmp.zip'), PAnsiChar(ExtractFilePath(Application.ExeName) + '..\backups\ultimoBackup.bkp'),false);
    RenameFile(ExtractFilePath(Application.ExeName) + 'tmp.zip', nomeArq);
    DeleteFile(PCHAR(ExtractFilePath(Application.ExeName) + 'tmp.gbk'));
    DeleteFile(PCHAR(ExtractFilePath(Application.ExeName) + 'tmp.zip'))
  finally
    FreeAndNil(zipper);
    FreeAndNil(IBBackup);
  end;
end;

function tiraEspacosDesnecessarios(val: String): string;
var
  adicionouEspaco: boolean;
  i: integer;
  valStr2: string;
begin
  adicionouEspaco := false;
  valStr2 := '';
  for i := 1 to length(val) do
  begin
    if val[i] = ' ' then
    begin
      if not adicionouEspaco then
        adicionouEspaco := true
      else
        continue;
    end
    else
      adicionouEspaco := false;
    valStr2 := valStr2 + val[i];
  end;
  result := valStr2;
end;

function getSombraValue(Str:String): String;
begin
  result := UpperCase(RemoveAcento(tiraEspacosDesnecessarios(trim(str))));
end;

function TiraSimbolos(Str: String): String;
var
  i: integer;
  str2: String;
begin
  str2 := '';
  str  := Trim(Str);
  for i := 1 to length(Str) do Begin
    if Ord(Str[i]) in [Ord('a')..Ord('z'),Ord('A')..Ord('Z'),Ord('0')..Ord('9')] then
      str2 := str2 + Str[i];
  end;
  result := Str2;
end;

function LastDayOfMonth(dia: TDate = 0): TDate;
var
   y, m, d: word;
begin
  if dia = 0 then
    dia := now;
  decodedate(dia, y, m, d) ;
  m := m + 1;
  if m > 12 then
  begin
    y := y + 1;
    m := 1;
  end;
  result := encodedate(y, m, 1) - 1;
end;

procedure setHabilitaComboSearch(cbo: TosComboSearch; enabled: boolean);
begin
  if enabled then
  begin
    cbo.ReadOnly := false;
    cbo.color := clWhite;
    cbo.showButton := true;
  end
  else
  begin
    cbo.ReadOnly := true;
    cbo.color := clBtnFace;
    cbo.showButton := false;
  end;
  cbo.invalidate;
end;

procedure setHabilitaDBEdit(edt: TDBEdit; enabled: boolean);
begin
  if enabled then
  begin
    edt.ReadOnly := false;
    edt.color := clWhite;
  end
  else
  begin
    edt.ReadOnly := true;
    edt.color := clBtnFace;
  end;
end;

procedure setHabilitawwComboBox(comboBox: TwwDBComboBox; enabled: boolean);
begin
  if enabled then
  begin
    comboBox.ReadOnly := false;
    comboBox.Color := clWhite;
  end
  else
  begin
    comboBox.ReadOnly := true;
    comboBox.Color := clBtnFace;
  end;
end;

procedure setHabilitawwDateTimePicker(dateTimePicker: TwwDBDateTimePicker; enabled: boolean);
begin
  if enabled then
  begin
    dateTimePicker.ReadOnly := false;
    dateTimePicker.Color := clWhite;
  end
  else
  begin
    dateTimePicker.ReadOnly := true;
    dateTimePicker.Color := clBtnFace;
  end;
end;

procedure setHabilitaComponente(comp: TComponent; enabled: boolean);
begin
  if comp is TosComboSearch then
    setHabilitaComboSearch((comp as TosComboSearch), enabled);
  if comp is TDBEdit then
    setHabilitaDBEdit((comp as TDBEdit), enabled);
  if comp is TwwDBComboBox then
    setHabilitawwComboBox((comp as TwwDBComboBox), enabled);
  if comp is TwwDBDateTimePicker then
    setHabilitawwDateTimePicker((comp as TwwDBDateTimePicker), enabled);
end;

procedure habilitaComponentes(comps: varArrayOfcomps);
var
  i: integer;
begin
  for i := low(comps) to high(comps) do
    setHabilitaComponente(comps[i], true);
end;

procedure desHabilitaComponentes(comps: array of TComponent);
var
  i: integer;
begin
  for i := low(comps) to high(comps) do
    setHabilitaComponente(comps[i], false);
end;

function roundToCurr(val: double): double;
begin
  result := roundTo(val, -2);
end;




end.
