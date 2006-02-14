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
    exprList: TStrings;
  public
    { Public declarations }
    function execute(SQLBase: String; exprList: TStrings): boolean;
    function getQuery: string; virtual; abstract;
  end;

  TosCustomFilterClass = class of TosCustomFilter;
var
  osCustomFilter: TosCustomFilter;

implementation

{$R *.dfm}

{ TosCustomFilter }

function TosCustomFilter.execute(SQLBase: String; exprList: TStrings): boolean;
begin
  Result := false;
  self.SQLBase := SQLBase;
  self.exprList := exprList;
  showModal;
end;

end.
