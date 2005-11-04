unit osLex;

interface

uses RegExpr, SysUtils, Classes;

type
  // Class que representa o token e o padrao que o representa
  TExprCasamento = class
  private
    FExprReg : String;
    FValorToken : Integer;
  public
    property ExprReg : String read FExprReg write FExprReg ;
    property ValorToken : Integer read FValorToken write FValorToken;
  end;

  // Classe para representar um token
  TToken = class
  private
    FID: Integer;
    FValue: String;
  public
    constructor Create;

    property ID: Integer read FID write FID;
    property Value: String read FValue write FValue;
  end;

  // Classe que representa um processador lexico
  TosLexico = class
  private
    FTokenList: TList;
    FExpressao: WideString;
    SemiExpr: WideString;
    FPosicaoAtual: Integer;
    FEstadoInvalido: Boolean;

    FRegExpr: TRegExpr;

    procedure NovaExpressao(Exp: WideString);
  public
    constructor Create;

    procedure Reinicializa;
    procedure AdicionaToken(ExprRegular: String; ValorToken: Integer);
    function ObtemToken: TToken;
    function Recupera: String;

    // Propriedades
    property Expressao: WideString read FExpressao write NovaExpressao;
  end;

implementation

{ TosLexico }

constructor TosLexico.Create;
begin
  FPosicaoAtual := 0;
  FRegExpr := TRegExpr.Create;
  FtokenList := TList.Create;
  FEstadoInvalido := False;  
end;

{ Adiciona uma expressao regular e o numero que identifica um token qualquer }
procedure TosLexico.AdicionaToken(ExprRegular: String; ValorToken: Integer);
var
  ExprCasamento: TExprCasamento;
begin
  ExprCasamento := TExprCasamento.Create;

  ExprCasamento.ExprReg := ExprRegular;
  ExprCasamento.ValorToken := ValorToken;

  FtokenList.Add(ExprCasamento);

end;

{ Busca o proximo token da string }
function TosLexico.ObtemToken: TToken;
var
  Token: TToken;
  i: Integer;
begin
  Token := TToken.Create;

  if FEstadoInvalido then
  begin
    Token.ID := -1;
    Result := Token;
    Exit;  
  end;

  // Ignora espacos em branco e quebras de linha
  FRegExpr.Expression := '^[\ \r\n]*';
  SemiExpr := Trim(FRegExpr.Replace(SemiExpr, ''));

  // Se string esta vazia, nada mais para ler na entrada
  if SemiExpr = '' then
  begin
    // fim de string,
    Token.ID := 0;
    Result := Token;
    Exit;
  end;

  // Identifica o token na lista
  Token.ID := -1;
  i := 0;
  while (i < FtokenList.Count) and (Token.ID = -1) do
  begin
    FRegExpr.Expression := '^' + TExprCasamento(FtokenList.Items[i]).ExprReg;
    if FRegExpr.Exec(SemiExpr) then
    begin
      // Token identificado; Armazena retorno e remove-o da entrada 
      Token.ID := TExprCasamento(FtokenList.Items[i]).ValorToken;
      Token.Value := Trim(FRegExpr.Match[0]);
      SemiExpr := FRegExpr.Replace(SemiExpr, '');
    end;

    inc(i);
  end;

  if Token.ID = -1 then
    FEstadoInvalido := True;

  Result := Token;
end;

// se recupera da leitura de um simbolo invalido e retorna o simbolo
function TosLexico.Recupera: String;
var
  SimboloInvalido: String;
  i: Integer;
begin
  if not(FEstadoInvalido) then
  begin
    Result := '';
    Exit;
  end;

  // Ignora espacos em branco e quebras de linha
  FRegExpr.Expression := '^[\ \r\n]*';
  SemiExpr := Trim(FRegExpr.Replace(SemiExpr, ''));

  // Se string esta vazia, nada mais para ler na entrada
  if SemiExpr = '' then
  begin
    Result := '';
    Exit;
  end;

  // incrementa de 1 em 1 caracter ate encontrar um token correto
  while (Length(SemiExpr) > 0) and FEstadoInvalido do
  begin
    i := 0;
    SimboloInvalido := SimboloInvalido + SemiExpr[1];
    SemiExpr := Copy(SemiExpr, 2, Length(SemiExpr)-1); 
    while (i < FtokenList.Count) and FEstadoInvalido do
    begin
      FRegExpr.Expression := '^' + TExprCasamento(FtokenList.Items[i]).ExprReg;
      if FRegExpr.Exec(SemiExpr) then
      begin
        // Token valido identificado; armazena simbolo invalido
        FEstadoInvalido := False;
      end;
      inc(i);
    end;

  end;
  FEstadoInvalido := False;

  Result := SimboloInvalido;
end;

procedure TosLexico.NovaExpressao(Exp: WideString);
begin
  FExpressao := Exp;
  SemiExpr := Exp;
end;

// reinicializa o lexico
procedure TosLexico.Reinicializa;
begin
  SemiExpr := FExpressao;
end;

{ TToken }

constructor TToken.Create;
begin
  FID := 0;
  FValue := '';
end;

end.
