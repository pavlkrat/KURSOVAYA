unit CreateUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXPickers, HelpUnit, System.Win.ComObj, System.UITypes;

type
  TCreateForm = class(TForm)
    EnterName: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    EnterType: TComboBox;
    StaticText3: TStaticText;
    GoAddAg: TButton;
    AgentList: TListBox;
    StaticText4: TStaticText;
    EnterFIO: TEdit;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    GoPickDate: TDatePicker;
    GoCreateDoc: TButton;
    GoDelDoc: TButton;
    StaticText7: TStaticText;
    EnterAuthor: TEdit;
    PathDialog: TOpenDialog;
    EnterPath: TButton;
    procedure FormShow(Sender: TObject);
    procedure GoAddAgClick(Sender: TObject);
    procedure GoCreateDocClick(Sender: TObject);
    procedure GoDelDocClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EnterPathClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateForm: TCreateForm;

implementation

{$R *.dfm}

uses MainUnit;

function getcode():integer;
begin
  inc(MainForm.totals);
  result := MainForm.totals;
end;

procedure TCreateForm.GoAddAgClick(Sender: TObject);
var
  surn,date:string;
begin
  surn := EnterFIO.Text;
  date := DateToStr(GoPickDate.Date);
  if surn <> '' then
    AgentList.Items.Add(date+' '+surn)
  else
    ShowMessage('Заполните поле ФИО');
  EnterFIO.Text := '';
end;

procedure TCreateForm.GoCreateDocClick(Sender: TObject);
var
  curdoc:docum;
  mas:arrctr;
  len,i:integer;
  msg:string;
  mode,alnorm:boolean;
begin
  curdoc.typ := EnterType.ItemIndex;
  if EnterType.Items[curdoc.typ] = '' then
    ShowMessage('Укажите тип документа')
  else
  begin
    curdoc.code := getcode();
    curdoc.name := EnterName.Text;
    if curdoc.name = '' then
      curdoc.name := 'Документ'+IntToStr(curdoc.code);
    curdoc.path := PathDialog.FileName;
    if curdoc.path = '' then
      curdoc.path := 'без файла';
    curdoc.author := EnterAuthor.Text;
    if curdoc.author = '' then
      curdoc.author := 'не указан';
    curdoc.isarchived := false;
    len := AgentList.Items.Count;
    setlength(mas,len + 1);
    mas[0].date := '99.99.9999';
    mas[0].surname := '';
    for i := 0 to len - 1 do
    begin
      mas[i + 1].date := Copy(AgentList.Items[i],1,10);
      mas[i + 1].surname := Copy(AgentList.Items[i],12,length(AgentList.Items[i])-11);
    end;
    sortagt(mas);
    curdoc.agents := Copy(mas);
    if len > 0 then
      mode := true
    else
      mode := false;
    msg := createmsg(curdoc,mode);
    if MessageDLG(msg,mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      PathDialog.FileName := '';
      alnorm := isword(curdoc.path);
      if alnorm then
      begin
        pushdoc(MainForm.matr[EnterType.ItemIndex],curdoc);
        if curdoc.author <> 'не указан' then
        begin
          if autadd(MainForm.authead,MainForm.autback,curdoc.author) then
            MainForm.ChooseAuthor.Items.Add(curdoc.author);
        end;
        EnterName.Text := '';
        EnterFIO.Text := '';
        EnterAuthor.Text := '';
        EnterType.ClearSelection;
        AgentList.Clear;
        MainForm.SearchClick(sender);
        ShowMessage('Документ успешно добавлен');
      end
      else
        ShowMessage('Указан неверный файл')
    end;
  end;
end;

procedure TCreateForm.GoDelDocClick(Sender: TObject);
begin
  if AgentList.ItemIndex <> -1 then
    AgentList.DeleteSelected
  else
    ShowMessage('Выберите лицо для удаления');
end;

procedure TCreateForm.EnterPathClick(Sender: TObject);
begin
  PathDialog.Execute;
end;

procedure TCreateForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
  GoPickDate.Date := Now;
  for i := 1 to MainForm.koltyps do
    EnterType.Items.Add(doctypes[i]);
end;

procedure TCreateForm.FormShow(Sender: TObject);
const
  ECM_FIRST = $1500;
  EM_SETCUEBANNER = ECM_FIRST + 1;
begin
  GoCreateDoc.SetFocus;
  SendMessage(EnterName.Handle,EM_SETCUEBANNER,0,LParam(PWideChar(WideString('Имя'))));
  SendMessage(EnterFIO.Handle,EM_SETCUEBANNER,0,LParam(PWideChar(WideString('ФИО'))));
  SendMessage(EnterAuthor.Handle,EM_SETCUEBANNER,0,LParam(PWideChar(WideString('Автор'))));
end;

end.
