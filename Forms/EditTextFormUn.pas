unit EditTextFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, osFrm, Menus, StdActns, ImgList, ActnList, osActionList;

type
  TosForm1 = class(TosForm)
    EditCut: TEditCut;
    EditCopy: TEditCopy;
    EditPaste: TEditPaste;
    EditSelectAll: TEditSelectAll;
    EditUndo: TEditUndo;
    EditDelete: TEditDelete;
    SearchFind: TSearchFind;
    SearchFindNext: TSearchFindNext;
    SearchReplace: TSearchReplace;
    SearchFindFirst: TSearchFindFirst;
    FileOpen: TFileOpen;
    FileSaveAs: TFileSaveAs;
    FileExit: TFileExit;
    MainMenu: TMainMenu;
    File2: TMenuItem;
    Exit2: TMenuItem;
    N4: TMenuItem;
    SaveAs2: TMenuItem;
    N5: TMenuItem;
    Open2: TMenuItem;
    New2: TMenuItem;
    Edit1: TMenuItem;
    N1: TMenuItem;
    Find1: TMenuItem;
    N2: TMenuItem;
    Paste1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    N6: TMenuItem;
    Undo1: TMenuItem;
    FileNew: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  osForm1: TosForm1;

implementation

{$R *.dfm}

end.
