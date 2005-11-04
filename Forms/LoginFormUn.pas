unit LoginFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TLoginForm = class(TForm)
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

procedure TLoginForm.FormShow(Sender: TObject);
begin
  FocusedControl.SetFocus;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  FocusedControl := UsernameEdit;
end;

end.
