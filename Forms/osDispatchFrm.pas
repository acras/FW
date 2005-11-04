unit osDispatchFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, osFrm, ImgList, ActnList, osActionList, ComCtrls, ToolWin,
  Buttons, ExtCtrls;

type
  TosDispatchForm = class(TosForm)
    MainControlBar: TControlBar;
    ControlBarPanel: TPanel;
    ConfirmButton: TSpeedButton;
    tbrFilter: TToolBar;
    btnFilter: TToolButton;
    OnExecute: TAction;
    ConfirmAction: TAction;
    OnConfirm: TAction;
    procedure ConfirmActionExecute(Sender: TObject);
  private
    FSelectedList: TStringlist;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(PSelectedList: TStringList): boolean;
    property SelectedList: TStringList read FSelectedList;
  end;

var
  osDispatchForm: TosDispatchForm;

implementation

{$R *.dfm}

{ TosDispatchForm }

constructor TosDispatchForm.Create(AOwner: TComponent);
begin
  inherited;
  FSelectedList := TStringList.Create;
end;

destructor TosDispatchForm.Destroy;
begin
  FSelectedList.Free;
  inherited;
end;

function TosDispatchForm.Execute(PSelectedList: TStringList): boolean;
begin
  try
    ModalResult := mrNone;
    FSelectedList.Assign(PSelectedList);
    OnExecute.Execute;
    ShowModal;
  finally
    Result := (ModalResult = mrOK);
  end;
end;

procedure TosDispatchForm.ConfirmActionExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;
  OnConfirm.Execute;
  ModalResult := mrOK;
  Close;
end;

end.
