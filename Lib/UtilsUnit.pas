unit UtilsUnit;

interface

uses
  IBServices, INIFiles, Forms, AbZipper, Windows, SysUtils, StrUtils, Controls,
  osComboSearch, graphics, Classes, DBCtrls, wwdbdatetimepicker, Wwdbcomb,
  Math, Wwdbgrid, RegExpr,StdCtrls, DB, DBClient, wwdbedit, Buttons, ShellAPI, acSysUtils;

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
procedure setHabilitaButton(btn: TButton; enabled: boolean);
procedure setHabilitaSpeedButton(btn: TSpeedButton; enabled: boolean);
procedure setHabilitawwComboBox(comboBox: TwwDBComboBox; enabled: boolean);
procedure setHabilitawwDateTimePicker(dateTimePicker: TwwDBDateTimePicker; enabled: boolean);
function roundToCurr(val: double): double;
procedure setHabilitaDBCheckBox(edtd: TDBCheckBox; enabled: boolean);
procedure setHabilitaDBMemo(comp: TDBMemo; enabled: boolean);
procedure setHabilitawwDBGrid(grd: TwwDBGrid; enabled: boolean);
procedure ListFileDir(Path: string; FileList: TStrings);
function isNumeric(valor: string; acceptThousandSeparator: Boolean = False): boolean;
function isIP(valor: string): boolean;
function isConvert(Str: string): boolean;
function extractPhoneNumber(Str: String; defaultDDD: string = '041'): string;
procedure setHabilitaEdit(edit: TEdit; enabled: boolean);
function InvertIntOn(const ANumberL, ANumberH: Integer): Int64;
function InvertIntOff(const ANumberL, ANumberH: Integer): Int64;
function ConvertIntToBase(ANumber: Int64): string;
function RegistroDuplicado(PDataSet: TDataSet; IDField: string): Boolean;
function ConverteFK(id: Integer): string;
function ValidaTempo(tempo: string): string;
function ValidaMinutos(tempo: string): Boolean;
function ValidaHoras(tempo: string): Boolean;
function ValidaIntervalo(inicio: string; fim: string; permiteIgual: Boolean = false): Boolean;
function FormataHora(tempo: string): string;
function GetHora(tempo: string): Integer;
function GetMinuto(tempo: string): Integer;
procedure ImprimirImpressoraTermica(const comando, impressora: String);

implementation

uses DateUtils, Variants;

const
  CSIDL_COMMON_APPDATA = $0023;

procedure ListFileDir(Path: string; FileList: TStrings);
var
  SR: TSearchRec;
begin
  if FindFirst(Path + '\*.xml', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        FileList.Add(SR.Name);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure setHabilitaButton(btn: TButton; enabled: boolean);
begin
  btn.Enabled := enabled;
end;

procedure setHabilitaSpeedButton(btn: TSpeedButton; enabled: boolean);
begin
  btn.Enabled := enabled;
end;


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

procedure setHabilitaDBCheckBox(edtd: TDBCheckBox; enabled: boolean);
begin
  if enabled then
  begin
    edtd.ReadOnly := false;
  end
  else
  begin
    edtd.ReadOnly := true;
  end;
end;

procedure setHabilitawwDBGrid(grd: TwwDBGrid; enabled: boolean);
begin
  if enabled then
  begin
    grd.ReadOnly := false;
  end
  else
  begin
    grd.ReadOnly := true;
  end;
end;


procedure setHabilitaDBMemo(comp: TDBMemo; enabled: boolean);
begin
  if enabled then
  begin
    comp.enabled := true;
    comp.Color := clWhite;
  end
  else
  begin
    comp.enabled := false;
    comp.Color := clBtnFace;
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
  if comp is TDBCheckBox then
    setHabilitadbCheckBox((comp as TDBCheckBox), enabled);
  if comp is TDBMemo then
    setHabilitaDBMemo((comp as TDBMemo), enabled);
  if comp is TwwDBGrid then
    setHabilitawwDBGrid((comp as twwDBGrid), enabled);
  if comp is TButton then
    setHabilitaButton((comp as TButton), enabled);
  if comp is TSpeedButton then
    setHabilitaSpeedButton((comp as TSpeedButton), enabled);
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

function isNumeric(valor: string;
  acceptThousandSeparator: Boolean = False): boolean;
var
  decimal: char;
begin
  valor := Trim(valor);
  if acceptThousandSeparator then
    Result := ExecRegExpr('^((\d{1,3}(\.\d{3})*)|(\d+))(,\d+)?$', valor)
  else
    Result := ExecRegExpr('^\d+(,\d+)?$', valor);
end;

function isIP(valor: string): boolean;
begin
  valor := Trim(valor);
  Result := ExecRegExpr('^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}?$', valor);
end;

function isConvert(Str: string): boolean;
var
  Qtd, i: Smallint;
  StrAux: String;
  Posicao: Array[1..50] of Integer;
  existe, possui: Boolean;
begin
  for i := 1 to 50 do
    Posicao[i] := 0;

  Qtd := 0;
  StrAux := Str;

  // Qtde de ocorrências do caracter "."
  while Pos('.', StrAux) > 0 do
  begin
    Inc(Qtd);
    Posicao[Qtd] := Pos('.', StrAux);
    StrAux[Pos('.', StrAux)] := '*';
  end;

  existe := false;
  // Verifica se existe uma ocorrência após a outra Ex.: 1.000..000
  if(Qtd > 1) then
    for i := 1 to Qtd-1 do
      if(Posicao[i]+1) = (Posicao[i+1]) then
        existe := True;

  possui := false;
  // Verifica se a ocorrência está correta Ex.: 1.0000.000
  if(Qtd > 1) then
  begin
    if(Posicao[1] > 4) then
      possui := true;

    if(Posicao[Qtd]+3) > Length(Str) then
      possui := true;

    for i := 1 to Qtd-1 do
      if(Posicao[i]+4) <> (Posicao[i+1]) then
        possui := true;
  end
  else if(Qtd = 1) and ((Posicao[1]+3) > Length(Str)) then
    possui := true;

  Result := not(existe) and  not(possui);
end;

function extractPhoneNumber(Str: String; defaultDDD: string = '041'): string;
var
  i: integer;
  res: string;
begin
  res := '';
  for i := 1 to length(Str) do
    if isNumeric(str[i]) then
      res := res + str[i];
  if Length(res) = 11 then
    result := res
  else if Length(res) = 8 then
    result := defaultDDD + res
  else if length(res) = 10 then
    result := '0' + res
  else
    result := '00000000000';
end;

procedure setHabilitaEdit(edit: TEdit; enabled: boolean);
begin
  if enabled then
  begin
    edit.ReadOnly := false;
    edit.Color := clWhite;
  end
  else
  begin
    edit.ReadOnly := true;
    edit.Color := clBtnFace;
  end;
end;

function InvertIntOn(const ANumberL, ANumberH: Integer): Int64;
asm
  XOR EAX,$FFFFFFFF
  XOR EDX,$FFFFFFFF
  OR  EDX,$80000000
end;

function InvertIntOff(const ANumberL, ANumberH: Integer): Int64;
asm
  XOR EAX,$FFFFFFFF
  XOR EDX,$FFFFFFFF
end;

function ConvertIntToBase(ANumber: Int64): string;
const
  CBaseMap: array[0..31] of Char = (
    '2','3','4','5','6','7','8','9', //0-7
    'A','B','C','D','E','F','G','H', //8-15
    'J','K','L','M','N', //16-20
    'P','Q','R','S','T','U','V','X','W','Y','Z'); //21-31
var
  I: Integer;
begin
  SetLength(Result, 15);
  I := 0;

  if ANumber < 0 then
  begin
    Inc(I);
    Result[I] := '1';
    ANumber := InvertIntOff(ANumber and $FFFFFFFF, (ANumber and $FFFFFFFF00000000) shr 32);
  end;

  while ANumber <> 0 do
  begin
    Inc(I);
    Result[I] := CBaseMap[ANumber and $1F];
    ANumber := ANumber shr 5;
  end;

  SetLength(Result, I);
end;

function RegistroDuplicado(PDataSet: TDataSet; IDField: string): Boolean;
var
  ID: TField;
  CDS: TClientDataset;
  RecNoJaExiste : Integer;
begin
  CDS := TClientDataSet.Create(nil);
  try
    CDS.CloneCursor(TCustomClientDataSet(PDataSet), True);
    ID := PDataSet.FieldByName(IDField);
    if CDS.Locate(IDField,ID.Value,[loCaseInsensitive]) then
    begin
      RecNoJaExiste := CDS.RecNo;
      if RecNoJaExiste <> PDataSet.RecNo then
        Result := True
      else
        Result := False;
    end
    else
      Result := False;
  finally
    FreeAndNil(CDS);
  end;
end;

function ConverteFK(id: Integer): string;
begin
  if (id = 0) then
    Result := 'null'
  else
  begin
    Result := IntToSTr(id);
  end;
end;

function ValidaTempo(tempo: string): string;
var
  hora: Integer;
  tamanho: Integer;
begin
  tamanho := Length(tempo);
  Result := 'ok';
  if (Trim(tempo) = ':') or (Trim(tempo) = '') then
    Result := 'vazio'
  else if (Trim(Copy(tempo,0,tamanho-3)) = '') or (Trim(Copy(tempo,tamanho-1,2)) = '') then
    Result := 'incorreto'
  else if not TryStrToInt(Trim(Copy(tempo,0,tamanho-3)), hora) then
    Result := 'incorreto';
end;

function ValidaMinutos(tempo: string): Boolean;
var
  minuto: Integer;
  tamanho: Integer;
begin
  tamanho := Length(tempo);
  minuto := StrToIntDef(Trim(Copy(tempo,tamanho-1,2)),0);
  Result := not (minuto > 59);
end;

function ValidaHoras(tempo: string): Boolean;
var
  hora: Integer;
begin
  hora := StrToIntDef(Trim(Copy(tempo,0,2)),0);
  Result := not (hora > 23);
end;

function ValidaIntervalo(inicio: string; fim: string; permiteIgual: Boolean): Boolean;
var
  horaInicio, minutoInicio: Integer;
  horaFim, minutoFim: Integer;
  tamInicio, tamFim: Integer;
begin
  tamInicio := Length(inicio);
  tamFim := Length(fim);  
  horaInicio := StrToIntDef(Trim(Copy(inicio,0,tamInicio-3)),0);
  minutoInicio := StrToIntDef(Trim(Copy(inicio,tamInicio-1,2)),0);
  horaFim := StrToIntDef(Trim(Copy(fim,0,tamFim-3)),0);
  minutoFim := StrToIntDef(Trim(Copy(fim,tamFim-1,2)),0);

  Result := True;
  if (horaFim <= horaInicio) then
  begin
    if (horaFim = horaInicio) then
    begin
      if (minutoInicio < minutoFim) then
        Exit
      else if (minutoInicio = minutoFim) and (permiteIgual) then
        Exit;
    end;
    Result := False;
  end;
end;

// essa função corrige horas como 1_:00, 1_:_0
function FormataHora(tempo: string): string;
var
  hora: Integer;
  minuto: Integer;
  sHora: string;
  sMinuto: string;
begin
  hora := GetHora(tempo);
  if hora = 0 then
    sHora := '00'
  else
    sHora := IntToStr(hora);

  minuto := GetMinuto(tempo);
  if minuto = 0 then
    sMinuto := '00'
  else
    sMinuto := IntToStr(minuto);

  Result := sHora+':'+sMinuto;
end;

function GetHora(tempo: string): Integer;
var
  tam: Integer;
begin
  tam := Length(tempo);
  Result := StrToIntDef(Trim(Copy(tempo,0,tam-3)),0);
end;

function GetMinuto(tempo: string): Integer;
var
  tam: Integer;
begin
  tam := Length(tempo);
  Result := StrToIntDef(Trim(Copy(tempo,tam-1,2)),0);
end;

procedure ImprimirImpressoraTermica(const comando, impressora: String);
var
  FBat, FComando: TextFile;
  diretorio: string;
begin
  diretorio:= GetSpecialFolderLocation(Application.Handle, CSIDL_COMMON_APPDATA) + '\';
  if not FileExists (diretorio + 'COMANDO.TXT') then
  begin
    AssignFile(FComando, diretorio + 'COMANDO.TXT');
    try
      Rewrite(FComando);
      Writeln(FComando, comando);
    finally
      CloseFile(FComando);
    end;
  end;

  if not FileExists(diretorio + 'PRINTLBL.BAT') then
  begin
    AssignFile(FBat, diretorio + 'PRINTLBL.BAT');
    try
      Rewrite(FBat);
      Writeln(FBat, 'TYPE "' + diretorio + 'COMANDO.TXT" > '+impressora);
    finally
      CloseFile(FBat);
    end;
  end;

  ShellExecute(0, 'Open', PChar(diretorio + 'PRINTLBL.BAT'), nil, nil, Ord(SW_HIDE));
end;

end.
