unit PictureViewFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Math;

type
  TPictureViewForm = class(TForm)
    Scroll: TScrollBox;
    Image: TImage;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private

  public

    class procedure execute(pic: TPicture);
  end;

var
  PictureViewForm: TPictureViewForm;

implementation

{$R *.dfm}

{ TVisualizaFiguraForm }

class procedure TPictureViewForm.execute(pic: TPicture);
var
  w: integer;
  h: integer;
begin
  with TPictureViewForm.Create(nil) do
  begin
    w := pic.Width;
    image.Width := w;
    h := pic.Height;
    image.Height := h;
    image.Picture.Assign(pic);

    Width := Min(w + 14, Screen.Width);
    Height := Min(h + 26, Screen.Height - 50);

    ShowModal;
    Free;
  end;
end;

procedure TPictureViewForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

end.
