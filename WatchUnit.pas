unit WatchUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, HelpUnit, Vcl.StdCtrls, System.Win.ComObj, ShellAPI, System.UITypes;

type
  TWatchForm = class(TForm)
    StaticText1: TStaticText;
    DocInfo: TMemo;
    ChooseAgent: TComboBox;
    StaticText2: TStaticText;
    GoAgree: TButton;
    GoWord: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure GoAgreeClick(Sender: TObject);
    procedure setcombo();
    procedure GoWordClick(Sender: TObject);
  private
    { Private declarations }
  public
    doc:docum;
    { Public declarations }
  end;

var
  WatchForm: TWatchForm;

implementation

{$R *.dfm}

uses MainUnit;

procedure TWatchForm.setcombo();
begin
  if (length(doc.agents) = 1) or (doc.isarchived) then
  begin
    GoAgree.Enabled := false;
    ChooseAgent.Enabled := false;
    StaticText2.Enabled := false;
  end
  else
  begin
    GoAgree.Enabled := true;
    ChooseAgent.Enabled := true;
    StaticText2.Enabled := true;
  end;
end;

procedure TWatchForm.GoAgreeClick(Sender: TObject);
var
  idx,cnt:integer;
  dob:string;
begin
  if ChooseAgent.ItemIndex <> -1 then
  begin
    idx := ChooseAgent.ItemIndex;
    if MessageDLG('Ознакомиться с документом как '+doc.agents[idx].surname+'?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      dob := '';
      setlength(doc.alred,length(doc.alred)+1);
      if compstr(DateToStr(Date),doc.agents[idx].date) = 1 then
        dob := '(срок нарушен)';
      doc.agents[idx].date := DateToStr(Date);
      doc.alred[length(doc.alred)-1] := doc.agents[idx];
      doc.alred[length(doc.alred)-1].date := doc.alred[length(doc.alred)-1].date+dob;
      delagnt(doc.agents,idx);
      cnt := binsearch(MainForm.matr[doc.typ],doc.code);
      MainForm.matr[doc.typ][cnt] := doc;
      DocInfo.Text := createmsg(doc,false);
      if MainForm.ArcOrCur.ItemIndex = 0 then
        MainForm.SearchClick(sender);
      ChooseAgent.DeleteSelected;
      ChooseAgent.Enabled := false;
      ChooseAgent.Enabled := true;
      setcombo();
    end;
  end
  else
    ShowMessage('Выберите лицо')
end;

procedure TWatchForm.GoWordClick(Sender: TObject);
var
  W : Variant;
  s : string;
begin
  s := doc.path;
  if not fileexists(s) then
    ShowMessage('Прикреплённый файл не найден')
  else
  begin
    W := CreateOleObject('Word.Application');
    W.Documents.Open(s);
    W.Visible := True;
    W := Unassigned;
  end;
end;

procedure TWatchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MainForm.ArcOrCur.ItemIndex = 0 then
    MainForm.ToArchive.Enabled := true;
  MainForm.GoWork.Enabled := true;
  MainForm.GoDelete.Enabled := true;
end;

procedure TWatchForm.FormShow(Sender: TObject);
var
  i,len:integer;
begin
  setcombo();
  MainForm.ToArchive.Enabled := false;
  MainForm.GoWork.Enabled := false;
  MainForm.GoDelete.Enabled := false;
  if doc.path = 'без файла' then
    GoWord.Enabled := false
  else
    GoWord.Enabled := true;
  DocInfo.Text := createmsg(doc,false);
  len := length(doc.agents);
  ChooseAgent.Clear;
  for i := 0 to len - 2 do
    ChooseAgent.Items.Add(doc.agents[i].date+' '+doc.agents[i].surname);
end;

end.
