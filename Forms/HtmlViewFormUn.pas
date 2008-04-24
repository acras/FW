unit HtmlViewFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, osFrm, Menus, StdActns, ImgList, ActnList, osActionList,
  ComCtrls, ToolWin, ExtCtrls, StdCtrls, Buttons, OleCtrls, SHDocVw;

type
  THtmlViewForm = class(TosForm)
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
    WebBrowser: TWebBrowser;
    procedure FileSaveAndExitExecute(Sender: TObject);

  protected
    FResult: TModalResult;

  private

  public

    function Execute (URL: string) : boolean;

  end;

var
  HtmlViewForm: THtmlViewForm;

implementation

{$R *.dfm}

function THtmlViewForm.Execute (URL: string) : boolean;
begin
  FResult := mrCancel;
  WebBrowser.Navigate(URL);
  ShowModal;
  Result := (FResult = mrOK);
end;

procedure THtmlViewForm.FileSaveAndExitExecute(Sender: TObject);
begin
  inherited;
  FResult := mrOK;
  Close;
end;

end.
