unit osCustomFilterFunctionUn;

interface

uses classes;

type
  TosCustomFilterFunction = class(TPersistent)
    function evaluateFunctionValues(query: String): string; dynamic;
  end;

  TosCustomFilterFunctionClass = class of TosCustomFilterFunction;

implementation

{ TCustomFilterFunction }

function TosCustomFilterFunction.evaluateFunctionValues(
  query: String): string;
begin
  result := query;
end;

end.
