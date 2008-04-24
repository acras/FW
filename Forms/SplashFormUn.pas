unit SplashFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, jpeg, ExtCtrls, StdCtrls;

type
  TSplashForm = class(TForm)
    AppImage: TImage;
    ProgressBar: TProgressBar;
    ProductorImage: TImage;
    Label1: TLabel;
    Label2: TLabel;
  private

  public
    class procedure Execute;
  end;

implementation

uses osLookupDataUn, AdministracaoLookupDataUn, RelatorioLookupDataUn;

{$R *.dfm}

class procedure TSplashForm.Execute;
const
   MAX_LOOKUP_DATA = 3;
var
  dm : array[1..MAX_LOOKUP_DATA] of TosLookupData;
  i : integer;
begin
  dm[1] := AdministracaoLookupData;
//  dm[2] := EmpresaLookupData;
//  dm[3] := ProdutoLookupData;

  with TSplashForm.Create(Application) do
  begin
    try
      Show;
      for i := 1 to MAX_LOOKUP_DATA do
      begin
        Application.ProcessMessages;
        if dm[i] <> nil then
          dm[i].GetData;
          
        ProgressBar.StepIt;
      end;
    finally
      Close;
      Free;
    end;
  end;
end;

end.
