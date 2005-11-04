unit osCustomFilterUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TosCustomFilter = class(TForm)
  private
    { Private declarations }
  protected
    SQLBase: string;
  public
    { Public declarations }
    function execute(SQLBase: String): boolean;
    function getQuery: string; virtual; abstract;
  end;

  TosCustomFilterClass = class of TosCustomFilter;
var
  osCustomFilter: TosCustomFilter;

implementation

{$R *.dfm}

{ TosCustomFilter }

function TosCustomFilter.execute(SQLBase: String): boolean;
begin
  Result := false;
  self.SQLBase := SQLBase;
  showModal;
end;

end.
