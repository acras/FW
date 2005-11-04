unit osGrafo;

interface

uses SysUtils, Classes;

{ Funcoes e estruturas auxiliares }
type
  { Tipos de erros possiveis de serem retornados pelo processamento }
  TErrGrafo = (efSemErros = 0, efCiclo, efProcessamento);


  TListaElementos = class;

  { Tipo de objeto que o grafo pode ter como conteudo de seus vertices }
  TConteudoGrafoDep = class
  public
    function Processa(Dependencias: TListaElementos): Boolean; virtual; abstract;
  end;

  { Definicao de lista de elementos armazenaods }
  TListaElementos = class (TStringList)
  private
    function ObtemElemento(Posicao: Integer): TConteudoGrafoDep;
  public
    property Elementos[Index: Integer]: TConteudoGrafoDep read ObtemElemento;
  end;

  { Definicao de vertice para o grafo de dependencia}
  TVertice = class
    FChave: String;             // Chave que identifica o vertice  
  public
    Conteudo: TConteudoGrafoDep;// Conteudo do registro
    Visitado: Boolean;          // Indica se nodo foi visitado na passagem
    Computado: Boolean;         // Indica se valor jah foi computado
    Arestas: TListaElementos;    // Conjunto de arestas que saem desse nodo

    constructor Create(NovoConteudo: TConteudoGrafoDep; pChave: String = '');

    property Chave: String read FChave write FChave;
  end;

  { Definicao do Grafo }
  TGrafo = class (TStringList)
    Ciclo : TListaElementos;  // Representa o caminho do ciclo, se houver
    ElementoErro : TConteudoGrafoDep; // obj. onde ocorreou erro de proc.

  private
    FErro  : TErrGrafo;       // efCiclo : Ciclo efProcessamento: Processamento

    function Calcula(Vertice: TVertice): Boolean; overload;
    function ObtemElemento(Posicao: Integer): TConteudoGrafoDep;

  public
    // Adiciona vertices/arestas ao grafo, respectivamente
    procedure AdicionaVertice(Conteudo: TConteudoGrafoDep;
                              pChave: String = '');
    procedure AdicionaAresta(DePosicao, ParaPosicao: Integer);

    // Processa os nodos
    function Calcula: Boolean; overload; virtual;

    // destrutor
    destructor Destroy(); override;

    // Propriedades
    property CaminhoCiclo: TListaElementos read Ciclo;
    property Erro: TErrGrafo read FErro;
    property Elementos[Index: Integer]: TConteudoGrafoDep read ObtemElemento;

  end;

implementation

{ TGrafo }

{ Calcula parte de um vertice e percorre todos os
  nodos que podem ser atingidos a partir do mesmo,
  processando-os}
function TGrafo.Calcula(Vertice: TVertice): Boolean;
var
  Index: Integer;
  SemErros: Boolean;
begin
  // verifica se este nodo esta no caminho (foi visitado)
  if (Vertice.Visitado) then
  begin
    // Um ciclo foi detectado;
    FErro := efCiclo;

    // Remove elementos que nao fazem parte do ciclo
    Index := Ciclo.IndexOf(Vertice.FChave);
    while (Index > 0 ) do
    begin
      Ciclo.Delete(0);
      Dec(Index);
    end;
    Ciclo.AddObject(Vertice.FChave, Vertice);

    Calcula := False;
    Exit;
  end;

  // verifica se este nodo ja foi computado
  if (Vertice.Computado) then
  begin
    Calcula := True;
    Exit;
  end;

  // Adiciona este vertice ao caminho percorrido e diz q foi visitado
  Ciclo.AddObject(Vertice.FChave, Vertice);
  Vertice.Visitado := True;  

  // Percorre todos os vertices ao qual estah ligado
  Index := 0;
  while Index < Vertice.Arestas.Count do
  begin
    SemErros := Calcula(TVertice(Vertice.Arestas.Objects[Index]));

    // Verifica se vertices foram corretamente computados
    if not(SemErros) then
    begin
      Calcula := False;
      Exit;
    end;

    Index := Index + 1;
  end;

  // a principio, tudo certo

  // Se as dependencias estao satisfeitas, processa o nodo
  if not(Vertice.Conteudo.Processa(TListaElementos(Vertice.Arestas))) then
  begin
   FErro := efProcessamento;
   ElementoErro := Vertice.Conteudo;  
   Calcula := False;
   Exit;
  end;

  // Tudo OK por esse caminho

  // retira-se do caminho e indica que foi computado
  Vertice.Visitado := False;
  Ciclo.Delete(Ciclo.Count-1);

  Vertice.Computado := True;   // foi computado
  
  Calcula := True;
end;

function TGrafo.Calcula: boolean;
var
  Index: Integer;
begin
  { Inicializa vertices, lista de ciclo, erros }
  if not(Assigned(Ciclo)) then
    Ciclo := TListaElementos.Create;
  Self.Ciclo.Clear;
  Self.Ciclo.Capacity := Self.Capacity;

  FErro := efSemErros;
  ElementoErro := nil;

  { Nesse ponto, nenhum vertice foi computado}
  Index := 0;
  while Index < Self.Count do
  begin
    TVertice(Self.Objects[Index]).Computado := False;
    Index := Index + 1;
  end;

  { Percorre o grafo, processando vertices }
  Index := 0;
  while Index < Self.Count do
  begin
    if not(TVertice(Self.Objects[Index]).Computado) then
      if not(Calcula(TVertice(Self.Objects[Index]))) then
      begin
        // Detectou um ciclo
        Calcula := False;
        Exit;
      end;
    Index := Index + 1;
  end;

  Calcula := True;
end;

destructor TGrafo.Destroy;
begin
  // Se assegura que a lista de ciclo sera removida
  if Assigned(Ciclo) then
  begin
    Ciclo.Clear;
    Ciclo.Destroy;
  end;

  inherited;
end;

// retorna elemento da posicao Posicao
function TGrafo.ObtemElemento(Posicao: Integer): TConteudoGrafoDep;
begin
  ObtemElemento := TVertice(Self.Objects[Posicao]).Conteudo;
end;

procedure TGrafo.AdicionaVertice(Conteudo: TConteudoGrafoDep; pChave: String = '');
var
  Vertice: TVertice;
begin
  Vertice := TVertice.Create(Conteudo, pChave);

  Self.AddObject(pChave, Vertice);
end;

procedure TGrafo.AdicionaAresta(DePosicao, ParaPosicao: Integer);
begin
  if not(Assigned(TVertice(Self.Objects[DePosicao]).Arestas)) then
    TVertice(Objects[DePosicao]).Arestas := TListaElementos.Create;

  TVertice(Objects[DePosicao]).Arestas.AddObject(
      TVertice(Objects[ParaPosicao]).Chave, Objects[ParaPosicao]);
end;

{ TListaElementos }

function TListaElementos.ObtemElemento(Posicao: Integer): TConteudoGrafoDep;
begin
  ObtemElemento := TVertice(Self.Objects[Posicao]).Conteudo;
end;

{ TVertice }

constructor TVertice.Create(NovoConteudo: TConteudoGrafoDep; pChave: String = '');
begin
  Arestas := TListaElementos.Create;
  Visitado := false;
  Computado := false;
  Conteudo := NovoConteudo;
end;

end.
