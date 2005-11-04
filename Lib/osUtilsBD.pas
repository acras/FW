//*********************************************************************************//
//Unit: osUtilsBD                                                                  //
//Classes:                                                                         //
//  -TAlteradorBD                                                                  //
//*********************************************************************************//

unit osUtilsBD;

interface

uses
  Classes, osSQLDataSet, IdGlobal, SysUtils, variants, DB;

const
  //definição das constantes de erro
  E_CAMPO_EXISTENTE = 'O campo já existe';
  E_CAMPO_INEXISTENTE = 'Campo inexistente';
  E_IMPOSSIVEL_INSERIR_CAMPO = 'Impossível inserir campo';
  E_SEM_CAMPOS = 'Não existem campos';
  E_TABELA_NAO_DEFINIDA = 'A tabela não está definida';
  E_CHAVE_SEM_VALOR = 'Existe uma chave sem um valor definido';

type
  //tipo utilizado para definir as propriedades de um campo
  TPropsCampo = class
    public
      Tipo: TFieldType;
      SubTipo: TFieldType;
      Chave: Boolean;
      Valor: Variant;
  end;
  //definição da classe TAlteradorBD
  TAlteradorBD = class
  private
    FnomesCampos: TStringList;       //os nomes de todos os campos envolvidos
    FNomeTabela: string;             //o nome da tabela que está sendo atualizada

    property nomesCampos: TStringList read FnomesCampos write FnomesCampos;

    function getSelect: string;
    function getFrom: string;
    function getWhere: string;
    function getInsert: string;
    function getUpdate: string;
    procedure preencheParams(query: TosSQLDataSet);
    procedure inserirRegistro;
    procedure atualizarRegistro;
  public
    property nomeTabela: string read FNomeTabela write FNomeTabela;  //o nome da tabela publicado
    constructor create;
    destructor destroy; override;
    function existeRegistro: boolean;
    procedure inserir(sobreescrever: boolean = false);
    procedure adicionarCampo(PNome: string; PTipo: TFieldType; chave: boolean = false);
    procedure adicionarCampoValor(PNome: string; PTipo: TFieldType; PValor: variant;
      PChave: boolean = false);
    procedure setarSubTipo(PNome: string; PSubTipo: TBlobType);
    procedure setarValor(PNome: string; PValor: variant);
  end;

implementation

uses SQLMainData, SqlExpr;

{ TAlteradorBD }
//**********************************************************************************//
//Classe: TAlteradorBD                                                              //
//Descrição: A idéia geral desta classe é evitar que se escreva muitas sentenças    //
//  SQL simples. Assim, baseando-se em três listas a classe deve controlar inserções//
//  e atualizações no banco de dados. Esta classe depende do SQLMainData para       //
//  funcionar. Existem três listas:                                                 //
//      1) nomesCampos: lista de nomes de todos os campos de uma tabela que         //
//                      interessam para a atualização que está sendo feita          //
//      2) nomesChaves: lista de nomes de todos os campos da lista de campos que    //
//                      deverão ser tratados como chave                             //
//      3) valoresCampos: lista paralela à lista de nomes de campos que diz respeito//
//                        aos valores correspondentes aos campos                    //
//  Além das listas, existe uma propriedade (nomeTabela) que representa o nome da   //
//    tabela que está sendo atualizada pelo objeto.                                 //
//  Existem 3 métodos públicos além do construtor e do destrutor:                   //
//      1) existeRegistro: baseado nas informações contidas nas listas, verifica se //
//                         já existe um registro correspondente (no que diz respeito//
//                         às chaves) no BD.                                        //
//      2) inserir: insere o registro no BD. Caso o registro já exista no BD e a    //
//                  propriedade sobreescrever esteja setada para true, gera um      //
//                  update para a tabela.                                           //
//      3) adicionarCampo: é o meio com que os campos são adicionados ao objeto     //
//**********************************************************************************//


//*********************************************************************************//
//Método: adicionarCampo                                                           //
//Descrição: Serve para adicionar um campo à lista de campos. O usuário da classe  //
//  não terá acesso à lista de nomes dos campos, ficando a cargo deste             //
//  procedimento controlar a liata                                                 //
//*********************************************************************************//
procedure TAlteradorBD.adicionarCampo(PNome: string; PTipo: TFieldType; chave: boolean);
begin
  adicionarCampoValor(PNome, PTipo, NULL, chave);
end;

procedure TAlteradorBD.adicionarCampoValor(PNome: string; PTipo: TFieldType; PValor:variant;
  PChave: boolean);
var
  indiceCampo: integer;
begin
  //se o campo já existe, retorna um erro
  if (nomesCampos.IndexOf(PNome)<>-1) then
    raise exception.create(E_CAMPO_EXISTENTE);

  //insere o nome do campo na lista de nomes
  indiceCampo := nomesCampos.Add(PNome);

  //criar um objeto setar as propriedades do campo
  nomesCampos.Objects[indiceCampo] := TPropsCampo.Create;
  with TPropsCampo(nomesCampos.Objects[indiceCampo]) do
  begin
    Chave   := PChave;
    Valor   := PValor;
    Tipo    := PTipo;
    SubTipo := ftUnknown;
  end;
end;

//*********************************************************************************//
//Método: atualizarRegistro                                                        //
//Descrição: Envia a sentença de update para o BDi                                 //
//*********************************************************************************//
procedure TAlteradorBD.atualizarRegistro;
var
  query: TosSQLDataSet;
begin
  query := TosSQLDataSet.Create(nil);
  try
    query.SQLConnection := MainData.SQLConnection;
    query.CommandText := getUpdate + getWhere;
    preencheParams(query);
    query.ExecSQL;
  finally
    freeAndNil(query);
  end;
end;

//*********************************************************************************//
//Método: constructor                                                              //
//Descrição: Construtora da classe. Cria as listas que devem ser criadas.          //
//*********************************************************************************//
constructor TAlteradorBD.create;
begin
  nomesCampos := TStringList.Create;
end;

//*********************************************************************************//
//Método: destroy                                                                  //
//Descrição: Destrutora da classe. Libera as listas que foram criadas na           //
//           construtora.                                                          //
//*********************************************************************************//
destructor TAlteradorBD.destroy;
begin
  nomesCampos.Free;
end;

//*********************************************************************************//
//Método: existeRegistro                                                           //
//Descrição: Verifica a existência do registro no BD.                              //
//*********************************************************************************//
function TAlteradorBD.existeRegistro: boolean;
var
  query: TosSQLDataSet;
begin
  query := TosSQLDataSet.Create(nil);
  try
    query.SQLConnection := MainData.SQLConnection;
    query.CommandText := 'Select count(1) ' + getFrom + getWhere;
    preencheParams(query);
    query.Open;
    result := query.fields[0].Value>0;
  finally
    freeAndNil(query);
  end;
end;

//*********************************************************************************//
//Método: getFrom                                                                  //
//Descrição: Gera uma parte de código SQL referente ao FROM.                       //
//*********************************************************************************//
function TAlteradorBD.getFrom: string;
begin
  if nomeTabela='' then
    raise Exception.Create(E_TABELA_NAO_DEFINIDA);
  result := ' FROM ' + FNomeTabela + ' ';
end;

//*********************************************************************************//
//Método: getInsert                                                                //
//Descrição: Gera a parte do insert do código SQL já com o INTO e values. Os       //
//           valores são parametrizados.                                           //
//*********************************************************************************//
function TAlteradorBD.getInsert: string;
var
  sent: string;
  i: integer;
begin

  if nomeTabela='' then
    raise Exception.Create(E_TABELA_NAO_DEFINIDA);

  sent := 'INSERT INTO ' + FNomeTabela + ' ';

  sent := sent + '(';
  for i := 0 to nomesCampos.Count-1 do
  begin
    sent := sent + nomesCampos[i];
    if i<nomesCampos.Count-1 then
      sent := sent + ', ';
  end;
  sent := sent + ') values (';

  for i := 0 to nomesCampos.Count-1 do
  begin
    sent := sent + ':'+nomesCampos[i];
    if i<nomesCampos.Count-1 then
      sent := sent + ', ';
  end;
  Result := sent + ') ';
end;

//*********************************************************************************//
//Método: getSelect                                                                //
//Descrição: Gera a parte de código SQL referente a um SELECT                      //
//*********************************************************************************//
function TAlteradorBD.getSelect: string;
var
  sent: string;
  i: integer;
begin
  sent := 'SELECT ';
  for i := 0 to nomesCampos.Count-1 do
  begin
    sent := sent + nomesCampos[i];
    if i<nomesCampos.Count-1 then
      sent := sent + ', ';
  end;
  result := sent + ' ';
end;

//*********************************************************************************//
//Método: getUpdate                                                                //
//Descrição: Gera a parte de código SQL referente a um UPDATE já com SET. Os       //
//           valores vão parametrizados.                                           //
//*********************************************************************************//
function TAlteradorBD.getUpdate: string;
var
  sent: string;
  i: integer;
begin

  if nomeTabela='' then
    raise Exception.Create(E_TABELA_NAO_DEFINIDA);

  sent := 'UPDATE ' + FNomeTabela + ' SET ';

  for i := 0 to nomesCampos.Count-1 do
  begin
    sent := sent + nomesCampos[i] + '= :' + nomesCampos[i];
    if i<nomesCampos.Count-1 then
      sent := sent + ', ';
  end;
  Result := sent + ' ';
end;

//*********************************************************************************//
//Método: getUpdate                                                                //
//Descrição: Gera a parte de código SQL referente a um WHERE já com ANDs. Os       //
//           valores vão parametrizados. Somente campos chave são inseridos        //
//*********************************************************************************//
function TAlteradorBD.getWhere: string;
var
  sent: string;
  i: integer;
begin
  sent := ' WHERE ';
  for i := 0 to nomesCampos.Count-1 do
  begin
    if TPropsCampo(nomesCampos.Objects[i]).Chave then
      sent := sent + nomesCampos[i] + '= :' + nomesCampos[i];
  end;
  result := Copy(sent, 0, length(sent)-4);
end;

//*********************************************************************************//
//Método: inserir                                                                  //
//Descrição: Já descrito.                                                          //
//*********************************************************************************//
procedure TAlteradorBD.inserir(sobreescrever: boolean);
begin
  if (existeRegistro AND (not(sobreescrever))) then
    exit;

  if existeRegistro then
    atualizarRegistro
  else
    inserirRegistro;
end;

//*********************************************************************************//
//Método: inserirRegistro                                                          //
//Descrição: Manda ao BD a sentença de inserção com os parâmetros preenchidos.     //
//*********************************************************************************//
procedure TAlteradorBD.inserirRegistro;
var
  query: TosSQLDataSet;
begin
  query := TosSQLDataSet.Create(nil);
  try
    query.SQLConnection := MainData.SQLConnection;
    query.CommandText := getInsert;
    preencheParams(query);
    query.ExecSQL;
  finally
    freeAndNil(query);
  end;
end;

//*********************************************************************************//
//Método: preencheParams                                                           //
//Descrição: Baseando-se nos parâmetros da query, preenche seus valores conforme   //
//           a lista de valores                                                    //
//*********************************************************************************//
procedure TAlteradorBD.preencheParams(query: TosSQLDataSet);
var
  i, indiceCampo: integer;
  nomeParam: string;
begin
  for i := 0 to query.Params.Count-1 do
  begin
    nomeParam := query.Params[i].Name;
    indiceCampo := nomesCampos.IndexOf(nomeParam);
    if indiceCampo=-1 then
      raise exception.Create(E_CHAVE_SEM_VALOR);
    query.Params[i].Value    := TPropsCampo(nomesCampos.Objects[indiceCampo]).Valor;
    query.Params[i].DataType := TPropsCampo(nomesCampos.Objects[indiceCampo]).Tipo;
    if (query.Params[i].DataType=ftBlob) then
      TBlobField(query.Params[i]).BlobType := TPropsCampo(nomesCampos.Objects[indiceCampo]).SubTipo;
  end;
end;

//*********************************************************************************//
//Método: setarValor                                                               //
//Descrição: Altera o valor de um campo                                            //
//*********************************************************************************//
procedure TAlteradorBD.setarSubTipo(PNome: string; PSubTipo: TBlobType);
var
  indiceCampo: integer;
begin
  indiceCampo := nomesCampos.IndexOf(PNome);
  if indiceCampo=-1 then
    raise exception.Create(E_CAMPO_INEXISTENTE);
  TPropsCampo(nomesCampos.Objects[indiceCampo]).SubTipo := PSubTipo;
end;

procedure TAlteradorBD.setarValor(PNome: string; PValor: variant);
var
  indiceCampo: integer;
begin
  indiceCampo := nomesCampos.IndexOf(PNome);
  if indiceCampo=-1 then
    raise exception.Create(E_CAMPO_INEXISTENTE);
  TPropsCampo(nomesCampos.Objects[indiceCampo]).Valor := PValor;
end;

end.
