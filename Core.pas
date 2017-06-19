library Core;

uses SubCore ,crt, System.Threading;

var
  host: string;
  serverip: array of string;
  serverport: array [,] of integer;
  servernumber, SrvTaskN, myspeed: integer;
  menucase: string;
  cmd: string;
  cmdargs: array of string;

const
  defaulthost = 'localhost';

procedure mycomp();
var
  info, ug, exitt: integer;
begin
  while true do
  begin
    if host = defaulthost then
    begin
      case cmd of
        'info': info := 1;
        'upgrade': ug := 1;
        'su': myspeed += 20;
      end;
      if info = 1 then
      begin
        Writeln('Speed: ', myspeed, ' Kb\s');
        info := 0;
      end;
    end;
    cmd:='';
  end;
end;

procedure connect(ip: string; port: integer);
var
  np: integer;
begin
  try
    repeat
      np += 1;
    until serverip[np] = ip; 
    serverport[np, port] := 2;
    Writeln('Соеденено с ', ip, ':', port);
  except
    Writeln('Такого IP нет');
  end;
end;

procedure disconnect(ip: string; port: integer);
var
  np: integer;
begin
  try
    repeat
      np += 1;
    until serverip[np] = ip;
    serverport[np, port] := 1;
    Writeln('Отсоеденено от ', ip, ':', port);
    host := defaulthost;
  except
    Writeln('Такого IP нет');
  end;
end;

procedure portscan(ipp: string);
var
  np, p: integer;
begin
  try
    repeat
      np += 1;
    until serverip[np] = ipp;
    repeat
      p += 1;
      if serverport[np, p] = 3 then Writeln(p, ' :open to hack');
      if serverport[np, p] >= 1 then Writeln(p, ' :open');
    until p = 25565;
  except
    Writeln('Не введён и\или неправильно введён IP...');
  end;
end;

procedure serverscan();
var
  ns: integer;
  err: boolean;
begin
  repeat
    ns += 1;
    try
      if serverip[ns] <> ' ' then Writeln('Сервер #', ns, ' IP: ', serverip[ns]);
    except
      err := true;
    end;
  until err = true;
  err := false;
end;

function GetArgs(strg: string): array of string;
var
  com, comn, cn: integer;
  ss, ssn, sss: string;
  lls: array of string;
begin
  SetLength(lls, 10);
  try
    repeat
      com += 1;
      ss := Copy(strg, com, 1);
      if (Copy(strg, com, 1) = '') or (Copy(strg, com, 1) = ' ') or (Copy(strg, com, 1) = nil) then cmd := sss;
      sss += ss;
    until (Copy(strg, com, 1) = '') or (Copy(strg, com, 1) = ' ') or (Copy(strg, com, 1) = nil);
  except

end;
  sss := nil;
  comn := com;
  if com - 1 <> Length(strg) then
  begin
    repeat
      comn += 1;
      ss := Copy(strg, comn, 1);
      if (ss = ' ') or (comn - 1 = Length(strg)) then
      begin
        cn += 1;
        lls[cn] := sss;
        sss := nil;
      end;
      if ss <> ' ' then sss := sss + ss;
    until comn - 1 = Length(strg);
    Result := lls;
  end;
end;

procedure send(typeS: string; speed: integer; dos: boolean);
var
  r,ssl: integer;
begin
  if typeS = 'HTTP' then
  begin
    if speed < myspeed then
    begin
      r := Random(1, 10);
      if r = Random(1, 5) then
      begin
        DoS := true;
        Writeln('Атака удалась');
      end
      else
      begin
        Writeln('Атака не удалась');
      end;
    end
    else
    begin
    if ssl=0 then
    begin
    ssl:=1;
    Writeln('Ваша скорость меньше чем скорость цели, нельзя использовать данный тип атаки!');
    end;
    end;
  end;
  if typeS = 'UDP' then
  begin
    
  end;
  ssl:=0;
end;

procedure hack(ipp: string);
var
  np: integer;
begin
  try
    repeat
      np += 1;
    until serverip[np] = ipp;
    serverport[np, 3389] := 3;
    Writeln('Сервер ', ipp, ' хакнут вами! Для использования его в ботнете или прокси цепочке вводите порт 3389');
  except
  
  end;
end;

procedure server();
var
  pp, rp, snp, info, speed: integer;
  DoS: boolean;
begin
  speed := random(20, 1000);
  servernumber += 1;
  SetLength(serverip, servernumber + 1);
  SetLength(serverport, servernumber + 1, 25566);
  serverip[servernumber] := IntToStr(Random(0, 255)) + '.' + IntToStr(Random(0, 255)) + '.' + IntToStr(Random(0, 255)) + '.' + IntToStr(Random(0, 255));
  rp := Random(1, 25565);
  serverport[servernumber, rp] := 1;
  snp := servernumber;
  repeat
    if serverport[snp, rp] = 2 then
    begin
      host := serverip[snp];
      case cmd of
        'send': send(cmdargs[1], speed, dos);
        'hack': hack(serverip[snp]);
        'info': info := 1;
        'disconnect': disconnect(serverip[snp], rp);
      end;
    end;
    if info = 1 then
    begin
      Writeln('IP: ', serverip[snp], '  Port: ', rp);
      Writeln('Speed: ', speed, 'Kb\s');
      info := 0;
    end;
  until DoS = true;
end;

procedure ServerTask();
var
  servers: array of Thread;
begin
  while true do 
  begin
    if SrvTaskN < 15 then
    begin
      SrvTaskN += 1;
      SetLength(servers, SrvTaskN + 1);
      servers[SrvTaskN] := Thread.Create(server);
      servers[SrvTaskN].Start();
    end;
  end;
end;

procedure help();//WOSln('',10);
begin
  WOSln('help - справка', 10);
  WOSln('exit - выход из игры', 10);
end;

procedure ExitGame();
begin
  WOS('Save data...', 30); OKln();
  WOS('Closing thread...', 30); OKln();
  WOS('Exiting OS...', 30); OKln();
  WOS('Off electricpower....', 30); OKln();
  Sleep(1200);
  Halt;
end;

procedure Menu();
var
  stat1: integer;
begin
  host := defaulthost;
  while true do 
  begin
    TextColor(10);
    if stat1 = 0 then begin
      stat1 := 1;
      WOSln('Наберите help - для вызова справки', 10);
    end;
    WOS(host + '@****> ', 10);
    Readln(menucase);
    SetLength(cmdargs, 10);
    cmdargs := GetArgs(menucase);
    try
      case cmd of
        'connect': connect(cmdargs[1], StrToInt(cmdargs[2]));
        'clear': clrscr;
        'scanport': portscan(cmdargs[1]);
        'scanip': serverscan();
        'help': help();
        'exit': exitgame;
      end;
    except
      Writeln('Ошибка...');
    end;
  end;
end;

procedure loading();
var
  Task, mc: Thread;
begin
  TextColor(10);
  Task := Thread.Create(ServerTask);
  Task.Start();
  mc := Thread.Create(mycomp);
  mc.Start();
  WOS('BIOS Loading...', 30); OKln();
  WOS('POST Diagnostic...', 30); OKln();
  WOS('Loading System...', 30); OKln();
  WOS('Starting console interface...', 30); OKln();
  WOS('Initializating...', 30); OKln();
  ClrScr;
  Menu();
end;

end.