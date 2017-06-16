unit SubCore;

uses crt;
procedure WOS(text: string; delay: integer);
var
  i: integer;
begin
  repeat
    i += 1;
    Write(Copy(text, i, 1));
    Sleep(delay);
  until i = Length(text);
end;

procedure WOSln(text: string; delay: integer);
var
  i: integer;
begin
  repeat
    i += 1;
    Write(Copy(text, i, 1));
    Sleep(delay);
  until i = Length(text);
  Writeln();
end;

procedure OKln();
begin
  TextColor(15);
  Write('[');
  TextColor(2);
  Write('OK');
  TextColor(15);
  Write(']');
  TextColor(10);
  Writeln();
end;

procedure OK();
begin
  TextColor(15);
  Write('[');
  TextColor(2);
  Write('OK');
  TextColor(15);
  Write(']');
  TextColor(10);
end;

end.