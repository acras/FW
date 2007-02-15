DROP TABLE LOG;
CREATE TABLE Log(
  IdLog INTEGER,
  IdUsuario INTEGER,
  DataHora TimeStamp,
  IdRegistro INTEGER,
  Classe integer,
  tipo integer,
  Descricao BLOB SUB_TYPE 0);
create generator idlog;