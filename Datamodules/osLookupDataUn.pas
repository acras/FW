unit osLookupDataUn;

interface

uses
  SysUtils, Classes;

type
  TosLookupData = class(TDataModule)
  private

  public
    procedure GetData; virtual; abstract;
  end;

var
  osLookupData: TosLookupData;

implementation

{$R *.dfm}

end.
