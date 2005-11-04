unit osUrl;

interface

uses
  SysUtils;

  function UrlDecode(url: string): string;


implementation

function UrlDecode(url: string): string;
var
  i: integer;
  decodedUrl: string;
begin
  decodedUrl := '';
  i := 1;
  while (i<=(length(url))) do
  begin
    if url[i]='%' then
    begin
      decodedUrl := decodedUrl + char(StrToInt('$'+url[i+1]+url[i+2]));
      i := i + 2;
    end
    else
      decodedUrl := decodedUrl + url[i];
    i := i+1;
  end;
  result := decodedUrl;
end;

end.
