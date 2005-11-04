unit MudarSenhaFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMudarSenhaForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SenhaAteriorEdit: TEdit;
    NovaSenhaEdit: TEdit;
    ConfirmacaoEdit: TEdit;
    ConfirmarButton: TButton;
    CancelarButton: TButton;
    Bevel: TBevel;
    procedure ConfirmarButtonClick(Sender: TObject);
    procedure CancelarButtonClick(Sender: TObject);
  private
    FOldpassword : string;
    FNewPassword : string;
  public
    class function Execute (Senha : string) : string;
    property Oldpassword : string read FOldpassword write FOldpassword;
    property Newpassword : string read FNewpassword write FNewpassword;
  end;

var
  MudarSenhaForm: TMudarSenhaForm;

implementation

uses osMD5;

{$R *.dfm}

{ TMudarSenhaForm }

class function TMudarSenhaForm.Execute (Senha : string) : string;
begin
  MudarSenhaForm := TMudarSenhaForm.Create(Application);
  MudarSenhaForm.Oldpassword := Senha;
  MudarSenhaForm.ShowModal;

  Result := MudarSenhaForm.NewPassword;
end;

procedure TMudarSenhaForm.ConfirmarButtonClick(Sender: TObject);
begin
  if (FOldPassword <> '') and (MD5Digest(SenhaAteriorEdit.Text) <> FOldPassword) then
    raise Exception.Create('Senha anterior não confere.');

  if NovaSenhaEdit.Text <> ConfirmacaoEdit.Text then
    raise Exception.Create('A nova senha e sua confirmação não comferem.');

  if MD5Digest(NovaSenhaEdit.Text) = FOldPassword then
    raise Exception.Create('A nova senha deve ser diferente da senha atual.');

  FNewPassword := MD5Digest(NovaSenhaEdit.Text);
  Close;
end;

procedure TMudarSenhaForm.CancelarButtonClick(Sender: TObject);
begin
  FNewpassword := FOldpassword;
  Close;
end;

end.
