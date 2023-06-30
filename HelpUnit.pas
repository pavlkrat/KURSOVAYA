unit HelpUnit;

interface

uses System.SysUtils, Classes;

const wrdtypes:array of string = ['docx','docm','.doc','dotx','dotm','.dot','.pdf','.htm','html','.xml','.txt'];
      doctypes:array of string = ['все',
                                  'письмо от органов гос. управления',
                                  'обращение граждан',
                                  'акт-предписание (внешний)',
                                  'приказ',
                                  'стандарт предприятия',
                                  'служебная записка',
                                  'акт-предписание (внутренний)'];
type
  tdata = record
    authorname:string;
    povt:integer;
  end;
  TPelem = ^Telem;
  Telem = record
    next:TPelem;
    data:tdata;
  end;
  ctrag = record
    surname:string;
    date:string;
  end;
  arrctr = array of ctrag;
  docum = record
    name:string;
    typ:integer;
    author:string;
    path:string;
    code:integer;
    agents,alred:arrctr;
    isarchived:boolean;
  end;
  arrdocs = array of docum;
  matrdocs = array of arrdocs;

procedure pushdoc(var arr:arrdocs;doc:docum);
procedure delagnt(var arr:arrctr;index:integer);
procedure deldoc(var arr:arrdocs;index:integer);
procedure sortdoc(var arr:arrdocs);
procedure sortagt(var arr:arrctr);
function createmsg(var doc:docum;mode:boolean):string;
function binsearch(var arr:arrdocs;val:integer):integer;
function needsogl(var doc:docum):boolean;
function isword(var path:string):boolean;
function compstr(s1,s2:string):ShortInt;
function getstatus(var dat:string):string;
function doctofil(var doc:docum):string;
function autadd(var head,back:Tpelem;data:string):boolean;
function autdel(var head,back:Tpelem;data:string):integer;
function checknames(s1,s2:string):boolean;
procedure checkdocs(var res:arrdocs;inp:arrdocs;name,author:string);
function doctostr(doc:docum):string;

implementation

procedure pushdoc(var arr:arrdocs;doc:docum);
begin
  setlength(arr,length(arr)+1);
  arr[length(arr)-1] := doc;
end;

procedure delagnt(var arr:arrctr;index:integer);
var
  i:integer;
begin
  for i := index to length(arr) - 2 do
    arr[i] := arr[i + 1];
  setlength(arr,length(arr)-1);
end;

procedure deldoc(var arr:arrdocs;index:integer);
var
  i:integer;
begin
  for i := index to length(arr) - 2 do
    arr[i] := arr[i + 1];
  setlength(arr,length(arr)-1);
end;

procedure swpdocs(var doc1,doc2:docum);
var
  t:docum;
begin
  t := doc1;
  doc1 := doc2;
  doc2 := t;
end;

procedure swpags(var doc1,doc2:ctrag);
var
  t:ctrag;
begin
  t := doc1;
  doc1 := doc2;
  doc2 := t;
end;

function comprig(s1,s2:string):ShortInt;
begin
  if s1 = s2 then
    result := 0
  else
  begin
    if s1 > s2 then
      result := 1
    else
      result := -1;
  end;
end;

function compstr(s1,s2:string):ShortInt;
var
  r1,r2:ShortInt;
begin
  r1 := comprig(Copy(s1,7,4),Copy(s2,7,4));
  if r1 = 0 then
  begin
    r2 := comprig(Copy(s1,4,2),Copy(s2,4,2));
    if r2 = 0 then
      result := comprig(Copy(s1,1,2),Copy(s2,1,2))
    else
      result := r2
  end
  else
    result := r1
end;

procedure sortagt(var arr:arrctr);
procedure qesort(st,en:integer);
var
  l,r:integer;
  tm:string;
begin
  l := st;
  r := en;
  tm := arr[(st+en) div 2].date;
  repeat
    while compstr(arr[l].date,tm) = -1 do
      inc(l);
    while compstr(arr[r].date,tm) = 1 do
      dec(r);
    if l <= r then
    begin
      swpags(arr[l],arr[r]);
      inc(l);
      dec(r);
    end;
  until l > r;
  if r > st then
    qesort(st,r);
  if en > l then
    qesort(l,en);
end;
begin
  qesort(0,length(arr)-1);
end;

procedure sortdoc(var arr:arrdocs);
procedure qsort(st,en:integer);
var
  l,r:integer;
  tm:string;
begin
  l := st;
  r := en;
  tm := arr[(st+en) div 2].agents[0].date;
  repeat
    while compstr(arr[l].agents[0].date,tm) = -1 do
      inc(l);
    while compstr(arr[r].agents[0].date,tm) = 1 do
      dec(r);
    if l <= r then
    begin
      swpdocs(arr[l],arr[r]);
      inc(l);
      dec(r);
    end;
  until l > r;
  if r > st then
    qsort(st,r);
  if en > l then
    qsort(l,en);
end;
begin
  qsort(0,length(arr)-1);
end;

function createmsg(var doc:docum;mode:boolean):string;
var
  i,len,len2:integer;
begin
  result := 'Код: '+IntToStr(doc.code)+#13#10+'Имя: '+doc.name+#13#10+'Подписан: '+doc.author+#13#10+'Тип: '+doctypes[doc.typ+1]+#13#10+'Путь к файлу: '+doc.path+#13#10;
  len := length(doc.agents);
  if mode then
  begin
    result := result + 'Должны ознакомиться: '+#13#10;
    for i := 0 to len - 2 do
        result := result + doc.agents[i].surname + ' до ' + doc.agents[i].date + #13#10;
  end
  else
  begin
    if doc.isarchived then
      result := result+'Статус: в архиве'#13#10
    else
      result := result+'Статус: действует'#13#10;
    len2 := length(doc.alred);
    if needsogl(doc) then
    begin
      result := result + 'Ознакомлены: '+#13#10;
      for i := 0 to len2 - 1 do
          result := result + doc.alred[i].surname + ' ' + doc.alred[i].date + #13#10;
    end;
  end;
end;

function binsearch(var arr:arrdocs;val:integer):integer;
var
  l,r,m:integer;
begin
  l := 0;
  r := length(arr) - 1;
  while l < r do
  begin
    m := (l + r) div 2;
    if arr[m].code < val then
      l := m + 1
    else
      r := m;
  end;
  result := l;
end;

function needsogl(var doc:docum):boolean;
begin
  result := (length(doc.agents)+length(doc.alred) > 1);
end;

function isword(var path:string):boolean;
var
  len,i:integer;
  hvost:string;
begin
  len := length(path);
  result := false;
  if path = 'без файла' then
  begin
    result := true;
  end
  else
  begin
    hvost := Copy(path,len-3,4);
    for i := 0 to length(wrdtypes) - 1 do
      if hvost = wrdtypes[i] then
      begin
        result := true;
        break;
      end;
  end;
end;

function getstatus(var dat:string):string;
var
  tdy:string;
begin
  if dat = '99.99.9999' then
    result := '                  -                   '
  else
  begin
    tdy := DateToStr(Date);
    case compstr(tdy,dat) of
    1:result:=dat+' (срок нарушен) ';
    -1:result:=dat+' (все в порядке) ';
    0:result:=dat+' (срок истекает) ';
    end;
  end;
end;

function doctofil(var doc:docum):string;
var
  i:integer;
begin
  result := IntToStr(doc.typ)+#13#10+doc.name+#13#10+doc.author+#13#10+doc.path+#13#10+IntToStr(doc.code)+#13#10+IntToStr(length(doc.agents))+#13#10;
  for i := 0 to length(doc.agents) - 1 do
    result := result+doc.agents[i].surname+#13#10+doc.agents[i].date+#13#10;
  result := result + IntToStr(length(doc.alred));
  for i := 0 to length(doc.alred) - 1 do
    result := result+#13#10+doc.alred[i].surname+#13#10+doc.alred[i].date;
end;

function autadd(var head,back:Tpelem;data:string):boolean;
var
  cur:Tpelem;
begin
  cur := head;
  result := true;
  while cur <> nil do
  begin
    if cur^.data.authorname = data then
    begin
      inc(cur^.data.povt);
      result := false;
      Exit;
    end;
    cur := cur^.next;
  end;
  New(cur);
  back^.next := cur;
  cur^.next := nil;
  cur^.data.authorname := data;
  cur^.data.povt := 1;
  back := cur;
end;

function autdel(var head,back:Tpelem;data:string):integer;
var
  cur,pre:Tpelem;
  i:integer;
begin
  pre := head;
  cur := head^.next;
  i := 1;
  while cur^.data.authorname <> data do
  begin
    inc(i);
    pre := cur;
    cur := cur^.next;
  end;
  if cur^.data.povt > 1 then
  begin
    dec(cur^.data.povt);
    result := -1;
  end
  else
  begin
    pre^.next := cur^.next;
    if cur = back then
      back := pre;
    Dispose(cur);
    result := i;
  end;

end;

function checknames(s1,s2:string):boolean;
var
  s:string;
  pref:array of integer;
  len,i,j,n:integer;
begin
  if s1 = '' then
    result := true
  else
  begin
    s := AnsiLowerCase(s1) + '`' + AnsiLowerCase(s2);
    len := length(s);
    setlength(pref,len);
    pref[0] := 0;
    for i := 1 to len - 1 do
    begin
      j := pref[i - 1];
      while (j > 0) and (s[i + 1] <> s[j + 1]) do
        j := pref[j - 1];
      if s[i + 1] = s[j + 1] then
        inc(j);
      pref[i] := j;
    end;
    n := length(s1);
    result := false;
    for i := n + 1 to len - 1 do
      if pref[i] = n then
      begin
        result := true;
        Exit;
      end;
  end;
end;

procedure checkdocs(var res:arrdocs;inp:arrdocs;name,author:string);
var
  i:integer;
begin
  for i := 0 to length(inp) - 1 do
    if checknames(name,inp[i].name) and ((inp[i].author = author) or (author = '')) then
      pushdoc(res,inp[i]);
end;

function doctostr(doc:docum):string;
begin
  if doc.isarchived then
    result := '    '+doc.agents[0].date+'                       '+doc.name
  else
  begin
    if length(doc.agents) > 1 then
      result := getstatus(doc.agents[0].date)+doc.name
    else
      result := '   принят к исполнению         '+doc.name;
  end;
end;

end.
