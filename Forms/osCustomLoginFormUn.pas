unit osCustomLoginFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TLoginFormClass = class of TosCustomLoginForm;
  TosCustomLoginForm = class(TForm)
    UsernameEdit: TEdit;
    Label1: TLabel;
    btnOK: TButton;
    PasswordEdit: TEdit;
    Label2: TLabel;
    btnCancelar: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FFocusedControl: TEdit;
    { Private declarations }
  public
    property FocusedControl: TEdit read FFocusedControl write FFocusedControl;
  end;

implementation

{$R *.dfm}

procedure TosCustomLoginForm.FormShow(Sender: TObject);
begin
  FocusedControl.SetFocus;
end;

procedure TosCustomLoginForm.FormCreate(Sender: TObject);
begin
  FocusedControl := UsernameEdit;
end;

end.
