unit EscolhaConexaoFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, acStrUtils;

type
  TOpcaoConexao = record
    nome: string;
    nomeArquivo: string;
  end;
  TEscolhaConexaoForm = class(TForm)
    ListBox: TListBox;
    Panel1: TPanel;
    btnOK: TButton;
    Button2: TButton;
    procedure ListBoxDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function execute: TOpcaoConexao;
  end;

var
  EscolhaConexaoForm: TEscolhaConexaoForm;

implementation

{$R *.dfm}

{ TEscolhaConexaoForm }

class function TEscolhaConexaoForm.execute: TOpcaoConexao;
var
  strl1, strl2: TStringList;
  i: integer;
begin
  strl1 := TStringList.Create;
  strl2 := TStringList.Create;
  try
    result.nomeArquivo := '';
    with TEscolhaConexaoForm.Create(nil) do
    begin
      strl1.LoadFromFile(ExtractFilePath(Application.ExeName)+'profiles.ini');
      for i := 0 to strl1.Count-1 do
      begin
        ListBox.Items.Add(getStrField(strl1[i], '|', 1));
        strl2.Add(getStrField(strl1[i], '|', 2));
      end;
      ShowModal;
      if ModalResult=mrOK then
      begin
        result.nome := ListBox.Items[ListBox.itemIndex];
        result.nomeArquivo := strl2[ListBox.ItemIndex];
      end;
      free;
    end;
  finally
    FreeAndNil(strl1);
    FreeAndNil(strl2);
  end;
end;

procedure TEscolhaConexaoForm.ListBoxDblClick(Sender: TObject);
begin
  btnOK.Click;
end;

end.
