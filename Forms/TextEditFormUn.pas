unit TextEditFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, osFrm, Menus, StdActns, ImgList, ActnList, osActionList,
  ComCtrls, ToolWin, ExtCtrls, StdCtrls, Buttons;

type
  TTextEditForm = class(TosForm)
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
    Memo: TMemo;
    ControlBar: TControlBar;
    MainToolbar: TToolBar;
    NewButton: TToolButton;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    ToolButton11: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    DeleteButton: TToolButton;
    ToolButton4: TToolButton;
    FindButton: TToolButton;
    FileSaveAndExit: TAction;
    SalveAndCloseButton: TBitBtn;
    procedure FileNewExecute(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure EditCopyExecute(Sender: TObject);
    procedure EditPasteExecute(Sender: TObject);
    procedure EditSelectAllExecute(Sender: TObject);
    procedure EditUndoExecute(Sender: TObject);
    procedure EditDeleteExecute(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure FileSaveAndExitExecute(Sender: TObject);

  protected
    FResult: TModalResult;

  private
    FChanged: boolean;

    function GetStrings: TStringList;
    procedure SetStrings(const Value: TStringList);

    function GetText: string;
    procedure SetText(const value: string);

  public
    property Strings: TStringList read GetStrings write SetStrings;
    property Text: string read GetText write SetText;

    property IsChanged : boolean read FChanged;

    function Execute: boolean;

  end;

var
  TextEditForm: TTextEditForm;

implementation

{$R *.dfm}

function TTextEditForm.Execute: boolean;
begin
  FResult := mrCancel;
  ShowModal;
  if (FResult = mrCancel) and (IsChanged) then
    if MessageDlg('O texto foi alterado. Deseja salvá-lo?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      FResult := mrOK;

  Result := (FResult = mrOK);
end;


procedure TTextEditForm.FileNewExecute(Sender: TObject);
begin
  inherited;
  Memo.Clear;
end;

procedure TTextEditForm.EditCutExecute(Sender: TObject);
begin
  inherited;
  Memo.CutToClipboard;
end;

procedure TTextEditForm.EditCopyExecute(Sender: TObject);
begin
  inherited;
  Memo.CopyToClipboard;
end;

procedure TTextEditForm.EditPasteExecute(Sender: TObject);
begin
  inherited;
  Memo.PasteFromClipboard;
end;

procedure TTextEditForm.EditSelectAllExecute(Sender: TObject);
begin
  inherited;
  Memo.SelectAll;
end;

procedure TTextEditForm.EditUndoExecute(Sender: TObject);
begin
  inherited;
  Memo.Undo;
end;

procedure TTextEditForm.EditDeleteExecute(Sender: TObject);
begin
  inherited;
  Memo.ClearSelection;
end;

function TTextEditForm.GetStrings: TStringList;
begin
  Result := TStringList(Memo.Lines);
end;

procedure TTextEditForm.SetStrings(const Value: TStringList);
begin
  Memo.Lines.Clear;
  Memo.Lines.AddStrings(Value);
  FChanged := False;
  FileSaveAndExit.Enabled := False;  
end;

procedure TTextEditForm.MemoChange(Sender: TObject);
begin
  inherited;
  FChanged := True;
  FileSaveAndExit.Enabled := True;
end;

function TTextEditForm.GetText: string;
begin
  Result := Memo.Lines.Text;
end;

procedure TTextEditForm.SetText(const value: string);
begin
  Memo.Lines.Clear;
  Memo.Lines.Text := Value;
  FChanged := False;
  FileSaveAndExit.Enabled := False;
end;

procedure TTextEditForm.FileSaveAndExitExecute(Sender: TObject);
begin
  inherited;
  FResult := mrOK;
  Close;
end;

end.
