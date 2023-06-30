unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ComObj, HelpUnit,
  Vcl.ExtCtrls, Vcl.Menus, System.UITypes;

type
  TMainForm = class(TForm)
    CreateNew: TButton;
    ChooseAuthor: TComboBox;
    ChooseType: TComboBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    SearchName: TEdit;
    Search: TButton;
    ToArchive: TButton;
    ArcOrCur: TRadioGroup;
    GoDelete: TButton;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    GoWork: TButton;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    DocsToWatch: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateNewClick(Sender: TObject);
    procedure SearchClick(Sender: TObject);
    procedure ToArchiveClick(Sender: TObject);
    procedure GoWorkClick(Sender: TObject);
    procedure ArcOrCurClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GoDeleteClick(Sender: TObject);
    procedure SearchNameKeyPress(Sender: TObject; var Key: Char);
    procedure ChooseAuthorChange(Sender: TObject);
    procedure ChooseTypeChange(Sender: TObject);
    procedure scaninf(var fil:TextFile;var arr:matrdocs;scanmode:boolean);
  private
    { Private declarations }
  public
    totals,koltyps:integer;
    matr,archive:matrdocs;
    toshow:arrdocs;
    arc,mas: TextFile;
    authead,autback:Tpelem
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses CreateUnit, WatchUnit;

procedure TMainForm.CreateNewClick(Sender: TObject);
begin
  CreateForm.Show;
end;

procedure TMainForm.SearchClick(Sender: TObject);
var
  i:integer;
  name,typ,author:string;
begin
  DocsToWatch.Clear;
  setlength(toshow,0);
  name := SearchName.Text;
  typ := ChooseType.Text;
  author := ChooseAuthor.Text;
  if typ = 'все' then
    typ := '';
  if author = 'все' then
    author := '';
  if typ = '' then
  begin
    for i := 0 to koltyps - 1 do
    begin
      if ArcOrCur.ItemIndex = 0 then
        checkdocs(toshow,matr[i],name,author)
      else
        checkdocs(toshow,archive[i],name,author)
    end;
  end
  else
  begin
    if ArcOrCur.ItemIndex = 0 then
      checkdocs(toshow,matr[ChooseType.ItemIndex - 1],name,author)
    else
      checkdocs(toshow,archive[ChooseType.ItemIndex - 1],name,author);
  end;
  if length(toshow) > 0 then
    sortdoc(toshow);
  for i := 0 to length(toshow) - 1 do
    DocsToWatch.Items.Add(doctostr(toshow[i]));
end;

procedure TMainForm.ToArchiveClick(Sender: TObject);
var
  idx:integer;
  curdoc:docum;
begin
  if DocsToWatch.ItemIndex <> -1 then
  begin
    curdoc := toshow[DocsToWatch.ItemIndex];
    if not curdoc.isarchived then
    begin
      if MessageDLG('Добавить документ в архив?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        idx := binsearch(matr[curdoc.typ],curdoc.code);
        curdoc.isarchived := true;
        curdoc.agents[0].date := DateToStr(Now);
        pushdoc(archive[curdoc.typ],curdoc);
        deldoc(matr[curdoc.typ],idx);
        deldoc(toshow,DocsToWatch.ItemIndex);
        DocsToWatch.DeleteSelected;
      end;
    end
    else
      ShowMessage('Документ уже в архиве');
  end
  else
    ShowMessage('Выберите документ для архивирования');
end;

procedure TMainForm.GoWorkClick(Sender: TObject);
var
  curdoc:docum;
begin
  if DocsToWatch.ItemIndex <> -1 then
  begin
    curdoc := toshow[DocsToWatch.ItemIndex];
    WatchForm.doc := curdoc;
    WatchForm.Show;
  end
  else
    ShowMessage('Выберите документ для работы');
end;

procedure TMainForm.GoDeleteClick(Sender: TObject);
var
  idx,todel:integer;
  curdoc:docum;
begin
  if DocsToWatch.ItemIndex <> -1 then
  begin
    curdoc := toshow[DocsToWatch.ItemIndex];
    if MessageDLG('Удалить документ навсегда?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      if not curdoc.isarchived then
      begin
        idx := binsearch(matr[curdoc.typ],curdoc.code);
        deldoc(matr[curdoc.typ],idx);
      end
      else
      begin
        idx := 0;
        while archive[curdoc.typ][idx].code <> curdoc.code do
          inc(idx);
        deldoc(archive[curdoc.typ],idx);
      end;
      deldoc(toshow,DocsToWatch.ItemIndex);
      DocsToWatch.DeleteSelected;
      if curdoc.author <> 'не указан' then
      begin
        todel := autdel(authead,autback,curdoc.author);
        if todel > -1 then
        begin
          ChooseAuthor.Items.Delete(todel);
          ChooseAuthor.ItemIndex := 0;
          SearchClick(sender);
        end;
      end;
    end;
  end
  else
    ShowMessage('Выберите документ для удаления');
end;

procedure TMainForm.ChooseAuthorChange(Sender: TObject);
begin
  Search.Click;
end;

procedure TMainForm.ChooseTypeChange(Sender: TObject);
begin
  Search.Click;
end;

procedure TMainForm.SearchNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
  begin
    Key := #0;
    SearchClick(sender);
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i,j,lm,la:integer;
  cur,todel:Tpelem;
begin
  rewrite(mas);
  for i := 0 to koltyps - 1 do
  begin
    lm := length(matr[i]) - 1;
    for j := 0 to lm do
      writeln(mas,doctofil(matr[i][j]));
  end;
  closefile(mas);
  rewrite(arc);
  for i := 0 to koltyps - 1 do
  begin
    la := length(archive[i]) - 1;
    for j := 0 to la do
      writeln(arc,doctofil(archive[i][j]));
  end;
  closefile(arc);
  cur := authead;
  while cur <> nil do
  begin
    todel := cur;
    cur := cur^.next;
    Dispose(todel);
  end;
end;

procedure TMainForm.scaninf(var fil:TextFile;var arr:matrdocs;scanmode:boolean);
var
  doc:docum;
  lenag,lenalr,i:integer;
  str:string;
begin
  reset(fil);
  while (not EOF(fil)) do
  begin
    readln(fil,str);
    doc.typ := StrToInt(str);
    readln(fil,doc.name);
    readln(fil,doc.author);
    readln(fil,doc.path);
    readln(fil,str);
    doc.code := StrToInt(str);
    if doc.code > totals then
      totals := doc.code;
    readln(fil,str);
    lenag := StrToInt(str);
    setlength(doc.agents,lenag);
    for i := 0 to lenag - 1 do
    begin
      readln(fil,doc.agents[i].surname);
      readln(fil,doc.agents[i].date);
    end;
    readln(fil,str);
    lenalr := StrToInt(str);
    setlength(doc.alred,lenalr);
    for i := 0 to lenalr - 1 do
    begin
      readln(fil,doc.alred[i].surname);
      readln(fil,doc.alred[i].date);
    end;
    doc.isarchived := scanmode;
    pushdoc(arr[doc.typ],doc);
    if doc.author <> 'не указан' then
    begin
      if autadd(authead,autback,doc.author) then
        ChooseAuthor.Items.Add(doc.author);
    end;
  end;
  closefile(fil);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
  New(authead);
  authead.next := nil;
  autback := authead;
  koltyps := length(doctypes)-1;
  setlength(matr,koltyps);
  setlength(archive,koltyps);
  for i := 0 to koltyps do
    ChooseType.Items.Add(doctypes[i]);
  totals := 0;
  AssignFile(arc, 'archiveres.txt');
  AssignFile(mas, 'baseres.txt');
  if fileexists('archiveres.txt') then
    scaninf(arc,archive,true);
  if fileexists('baseres.txt') then
    scaninf(mas,matr,false);
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  ECM_FIRST = $1500;
  EM_SETCUEBANNER = ECM_FIRST + 1;
begin
  SendMessage(SearchName.Handle,EM_SETCUEBANNER,0,LParam(PWideChar(WideString('Имя документа'))));
  SearchClick(sender);
end;

procedure TMainForm.ArcOrCurClick(Sender: TObject);
begin
  if ArcOrCur.ItemIndex = 1 then
  begin
    ToArchive.Enabled := false;
    StaticText5.Caption := 'Дата архивации';
  end
  else
  begin
    ToArchive.Enabled := true;
    StaticText5.Caption := 'Ближайшая дата ознакомления';
  end;
  SearchClick(sender);
end;

end.
