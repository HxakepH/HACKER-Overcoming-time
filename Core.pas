library Core;

uses SubCore ,crt, System.Threading;

var
  host: string;
  serverip: array of string;
  serverport: array [,] of integer;
  servernumber, SrvTaskN: integer;

const
  defaulthost = 'localhost';

procedure GetArgs(strg, comm:string):array of string;
var com,comn,cn:integer;
    ss,ssn:string;
begin
repeat
ssn:=ss;
com+=1;
ss:=Copy(strg,com,1);
if ss <> ' ' then comm+=ss;
until SSet = ' '
comn:=com;
repeat
comn+=1;
ss:=Copy(strg,comn,1);
if ss = ' ' then cn+=1;
until ssn = ss;

end;

procedure server();
var
  pp: integer;
begin
  servernumber += 1;
  SetLength(serverip, servernumber+1);
  SetLength(serverport, servernumber+1, 25565);
  serverip[servernumber] := IntToStr(Random(0, 255)) + '.' + IntToStr(Random(0, 255)) + '.' + IntToStr(Random(0, 255)) + '.' + IntToStr(Random(0, 255));
  serverport[servernumber, Random(1, 25565)] := 1;
end;

procedure ServerTask();
var
  servers: array of Thread;
begin
  while true do 
  begin
    SrvTaskN += 1;
    SetLength(servers, SrvTaskN+1);
    servers[SrvTaskN] := Thread.Create(server);
    servers[SrvTaskN].Start();
    Sleep(Random(60000, 600000));
  end;
end;

procedure help();//WOSln('',10);
begin
  WOSln('help - справка', 10);
  WOSln('exit - выход из игры', 10);
end;

procedure ExitGame();
begin
  WOS('Save data...', 50); OKln();
  WOS('Closing thread...', 50); OKln();
  WOS('Exiting OS...', 50); OKln();
  WOS('Off electric power....', 50); OKln();
  Sleep(1200);
  Halt;
end;

procedure Menu();
var
  menucase: string;
  stat1: integer;
begin
  while true do 
  begin
    host := defaulthost;
    TextColor(10);
    if stat1 = 0 then begin
      stat1 := 1;
      WOSln('--------------------------------------------', 10);
      WOSln('HACKER. Overcoming time. vALPHA 1.0 by xakep', 10);
      WOSln('--------------------------------------------', 10);
      WOSln('Добро пожаловать в систему HaOS(Hacker Operating System)', 10);
      WOSln('Наберите help - для вызова справки', 10);
    end;
    WOS(host + '> ', 10);
    Readln(menucase);
	menucase:=menucase.toLowerCase;
    case menucase of
      'help': help();
      'exit': exitgame;
    end;
  end;
end;

procedure loading();
var
  Task: Thread;
begin
  TextColor(10);
  WOS('BIOS Loading...', 50); OKln();
  Task := Thread.Create(ServerTask);
  Task.Start();
  WOS('POST Diagnostic...', 50); OKln();
  WOS('Loading System...', 50); OKln();
  WOS('Starting console interface...', 50); OKln();
  WOS('Initializating...', 50); OKln();
  Menu();
end;

end.