unit osSisFormulas;

interface
                    
uses
  SysUtils, Classes, osParser, osMaquina, osGrafo, Controls, RegExpr,
  osParserErrorHand, LMFuncoesParser;

type
  {Classe Principal : TosSisFormulas }
  TClassFormula = class of TosFormula;

  TosSisFormulas = class(TGrafo)
    FParser: TosParser;
    FListaErros : TListErro;

  private
    FTextoErro: TCaption;
    FArestasInicializadas: boolean;

    // Erros
    function RecuperaErro(Index: Integer): TNodoErro;
    function RecuperaNumeroErros: Integer;

    // calcula nodos e arestas para o grafo usado para calcular resultados
    function Inicializa : boolean;
  public
    constructor Create;

    function Calcula: Boolean; override;    

    procedure AdicionaFormula(Conteudo: TConteudoGrafoDep; pChave: String);

    // Funcoes auxiliares
    function Imprime : TCaption;

    // Propriedades
    property TextoErro: TCaption read FTextoErro;
    property ListaErros: TListErro read FListaErros;
    property Erros[Index: integer]: TNodoErro read RecuperaErro;
    property nErros: Integer read RecuperaNumeroErros;

  end;

  { Representa uma variavel }
  TosFormulaVariavel = class
    FNome: String;
    FValor: Double;
  public
    property Nome: String read FNome write FNome;
    property Valor: Double read FValor write FValor;
  end;

  { Representa uma formula de um sistema de formulas que nao e calculada }
  TosFormula = class(TConteudoGrafoDep)
    // Parser
    FParser: TosParser;

    // Informacoes sobre formula
    FRotulo: WideString;
    FVariavel: TosFormulaVariavel;  // Variavel armazenada no nodo
    FFormula: WideString;   // Formula para calcular resultado

    // Erros de parsing da expressao
    FListaErros: TListErro;
  private
    // Recupera n-esimo erro de parsing e a quantidade de erros
    function GetErro(Index: Integer): TNodoErro;
    function GetNumErros: Integer;

  public
    constructor Create(MathParser: TosParser); virtual;

    function Processa(Dependencias: TListaElementos): Boolean; override;

    // erros de parsing (expressao mal formada)
    property ListaErros: TListErro read FListaErros;
    property NumErros: Integer read GetNumErros;
    property Erro[Index: Integer]: TNodoErro read GetErro;
    // formula e nome da variavel
    property Formula: WideString read FFormula write FFormula;
    property Variavel: TosFormulaVariavel read FVariavel write FVariavel;
    property Rotulo: WideString read FRotulo write FRotulo;
  end;

  { Representa uma formula que tem seu valor determinado }
  TosFormulaCalc = class(TosFormula)
    FMaquina: TosMaquina;
    FResultadoCalc: Double;

  public
    constructor Create(MathParser: TosParser); override;

    function Processa(Dependencias: TListaElementos): Boolean; override;

    // resultado do calculo da formula
    property Resultado: Double read FResultadoCalc;
  end;

  TerrFormula =
      (efErroParsing = 1,
       efDivisaoPorZero);

  { Funcao para recuperar conteudo de uma lista de formulas }
  function GetLista(Lista: TListaElementos): TCaption;

implementation


{ Funcao para recuperar conteudo de uma lista de elementos }

function GetLista(Lista: TListaElementos): TCaption;
var i: Integer;
    TextoR: TCaption;
begin
  TextoR := '';
  i := 0;
  while i < Lista.Count do
  begin
    TextoR :=
      TextoR + TosFormula(Lista.Elementos[i]).Variavel.Nome;
    if (i+1)<Lista.Count then
      TextoR := TextoR + ', ';
    i := i + 1;
  end;
  TextoR := TextoR + #13#10;
  Result := TextoR;
end;


{ TosSisFormulas }

constructor TosSisFormulas.Create;
begin
  inherited;
  FParser := TosParser.Create;
  FListaErros := TListErro.Create;
  FArestasInicializadas := False;  
end;

// Obtencao de erros
function TosSisFormulas.RecuperaErro(Index: Integer): TNodoErro;
begin
  Result := FListaErros.Items[Index];
end;

function TosSisFormulas.RecuperaNumeroErros: Integer;
begin
  Result := FListaErros.Count;
end;

// baseado nos vertices atuais, cria as arestas necessarias
// gera lista de erros de valiaveis não existentes
// Retorna False se ocorreu algum erro
function TosSisFormulas.Inicializa : boolean;
var
  Index, i: Integer;
  DestVert: Integer;
begin
  Index := 0;
  while Index < Count do
  begin
    // atribui expressao para que o parser processe-a
    FParser.Expressao := TosFormula(Elementos[Index]).Formula;
    if FParser.Expressao <> '' then
    begin
      // compila a expressao
      FParser.Compile;

      for i := 0 to FParser.nVariaveis-1 do
      begin
        DestVert := IndexOf(FParser.Variavel[i]);
        // se DestVert for -1, significa que a variavel nao existe
        if (DestVert = -1) then
          FListaErros.Add(epWarning, i, 'Atributo ''%s'', Variável ''%s'' não definida.',
            [TosFormula(Elementos[Index]).Rotulo,  FParser.Variavel[i]])
        else
          if (DestVert <> Index) then
            AdicionaAresta(Index, DestVert);
      end;
    end;

    Inc(Index);
  end;

  FArestasInicializadas := True;
  Result := (FListaErros.Count = 0);
end;

// Adiciona nova formula no sistema
procedure TosSisFormulas.AdicionaFormula(Conteudo: TConteudoGrafoDep; pChave: String);
var
  Vertice: TVertice;
begin
  FArestasInicializadas := False;

  Vertice := TVertice.Create(Conteudo, pChave);
  Self.AddObject(pChave, Vertice);
end;

// "imprime" o grafo de calculo; somente para debug
function TosSisFormulas.Imprime: TCaption;
var i, j: Integer;
    Arestas : TListaElementos;
    TextoR: TCaption;
begin
  TextoR := '';
  i := 0;
  while i < Count do
  begin
    Arestas := TVertice(Objects[i]).Arestas;
    TextoR :=
      TextoR + TosFormula(Elementos[i]).Variavel.Nome + ': ';
    j := 0;
    while j < Arestas.Count do
    begin
      TextoR :=
        TextoR +
        TosFormula(TVertice(Arestas.Objects[j]).Conteudo).Variavel.Nome;
      if (j+1) < Arestas.Count then
        TextoR := TextoR + ', ';

      j := j + 1;
    end;
    TextoR := TextoR + #13#10;
    i := i + 1;
  end;
  Imprime := TextoR;
end;

function TosSisFormulas.Calcula: Boolean;
begin
  if not(FArestasInicializadas) then
    Result := Inicializa      // inicializa arestas verifica Variaveis
  else
    Result := True;

  // se não houve erros na inicialização então Calcula
  if Result then
    Result := inherited Calcula;
end;

{ TosFormula }

constructor TosFormula.Create(MathParser: TosParser);
begin
  FParser := MathParser;

  FVariavel := TosFormulaVariavel.Create;
  FVariavel.Nome := '';
  FVariavel.Valor := 0;
  FListaErros := TListErro.Create;
end;

function TosFormula.GetErro(Index: Integer): TNodoErro;
begin
  Result := FListaErros.Items[Index];
end;

function TosFormula.GetNumErros: Integer;
begin
  Result := FListaErros.Count;
end;

function TosFormula.Processa(Dependencias: TListaElementos): Boolean;
begin
  FParser.Expressao := FFormula;

  if not(FParser.Compile) then
    FListaErros.Assign(FParser.ListaErros);

  Result := FListaErros.Count = 0;
end;

{ TosFormulaCalc }
constructor TosFormulaCalc.Create(MathParser: TosParser);
begin
  inherited;

  FResultadoCalc := 0;
  FMaquina := TosMaquina.Create;
  FMaquina.Parser := MathParser;
  FMaquina.RegisterUserFunction('TESTEHEMOGRAMA', 2, testeHemograma);
  FMaquina.RegisterUserFunction('NEUTROFILOS', 1, calcNeutrofilos);
end;

function TosFormulaCalc.Processa(Dependencias: TListaElementos): Boolean;
var
  Index : Integer;
  VariavelAdj : TosFormulaVariavel;
begin
  // avaliacao da expressao
  FParser.Expressao := FFormula;

  if not(FParser.Compile) then
    FListaErros.Assign(FParser.ListaErros);

  Result := FListaErros.Count = 0;

  if not(Result) then
    Exit;

  FResultadoCalc := Variavel.Valor;

  if Formula <> '' then
  begin
    // Seta variaveis na formula com respectivos valores dos vertices adj.
    Index := 0;
    while Index < Dependencias.Count do
    begin
      VariavelAdj := TosFormulaCalc(Dependencias.Elementos[Index]).Variavel;
      FResultadoCalc := TosFormulaCalc(Dependencias.Elementos[Index]).Resultado;
      FMaquina.SetaVariavel(AnsiUpperCase(VariavelAdj.Nome), FResultadoCalc);

      Index := Index + 1;
    end;

    // Atribui o valor a variavel
    FMaquina.SetaVariavel(AnsiUpperCase(Variavel.Nome), Variavel.Valor);

    // tenta calcular o resultado
    try
      if not(FMaquina.Exec) then
        FListaErros.Assign(FMaquina.ListaErros)
      else
        FResultadoCalc := FMaquina.Resultado;
    except
      // Excecoes em operacoes matematicas
      on EZeroDivide do FListaErros.Add(epError, Ord(efDivisaoPorZero),
                                            'Erro de divisão por zero.', []);

      on EInvalidOp do FListaErros.Add(epError, Ord(efProcessamento),
                                            'Resultado indefinido.', []);
    end;

    Result := (FMaquina.nErros = 0) and (GetNumErros = 0);
  end;

end;

end.
