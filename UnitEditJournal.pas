unit UnitEditJournal;

interface

uses

    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus, UnitJournal,
    UnitStudent, UnitLesson, System.Generics.Collections, System.Generics.Defaults, UnitNote, DateUtils,
    UnitAddLesson;

type
    TFormEditJournal = class(TForm)
        JournalSG: TStringGrid;
        CaptionLabel: TLabel;
        MainMenu: TMainMenu;
        InformationMenuItem: TMenuItem;
        ClassLabel: TLabel;
        QuaterLabel: TLabel;
        LessonLabel: TLabel;
        AddLessonMenuItem: TMenuItem;
        SaveMenuItem: TMenuItem;
        procedure GetStudents;
        function FindLesson(ID: Int64): Integer;
        function FindStudent(ID: Int64): Integer;
        procedure UpdateSTRGLesson;
        procedure UpdateNotesList;
        procedure UpdateSTRGNotes;
        procedure UpdateSTRGQuaterNotes;
        procedure UpdateSTRG;
        procedure SaveMenuItemClick(Sender: TObject);
        procedure JournalSGDrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure JournalSGFixedCellClick(Sender: TObject; ACol, ARow: Integer);
        procedure JournalSGKeyPress(Sender: TObject; var Key: Char);
        procedure JournalSGSetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure GetLessons;
        procedure GetNotes;
        procedure FillJournalSG;
        procedure AddLessonMenuItemClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure ImportJournal;
        procedure FormShow(Sender: TObject);
        procedure InformationMenuItemClick(Sender: TObject);
        procedure AddLesson;
        procedure PrepareForm;

  private
    StudentList: TList<TStudent>;
    LessonsList: TList<TLesson>;
    NotesList: TList<TNote>;
    NeedSave: Boolean;
  public
    Journal: TJournal;
    ForEditing: Boolean;
  end;

var
  FormEditJournal: TFormEditJournal;

implementation

var
    Comparer: TDelegatedComparer<TLesson>;
    IsShown: Boolean;
{$R *.dfm}

procedure TFormEditJournal.GetStudents;
var
    StudentFile: file of TStudent;
    Student: Tstudent;
begin
    StudentList := TList<TStudent>.Create;
    AssignFile(StudentFile, 'E_Journal/' + Journal.GetClassName + '/students.students');
    Reset(StudentFile);
    while not Eof(StudentFile) do
    begin
        Read(StudentFile, Student);
        StudentList.Add(Student);
    end;
    CloseFile(StudentFile);
end;

procedure TFormEditJournal.JournalSGDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
    with JournalSG, JournalSG.Canvas do
    if (ARow = 0) then
    begin
        Brush.Color := clWindow;
        Font.Style := [fsBold];
        Canvas.Font.Size := 10;
        FillRect(Rect);
        TextOut(Rect.Left + 2, Rect.Top + 5, Cells[ACol, ARow]);
    end;
end;

procedure TFormEditJournal.JournalSGFixedCellClick(Sender: TObject; ACol,
  ARow: Integer);
var
    Info: string;
    Lesson: TLesson;
    WideChars: array[0..1000] of WideChar;
begin
    if not(IsShown) and (ACol > 4) then
    begin
        Lesson := LessonsList[ACol - 5];
        Info := 'Дата: ' + FormatDateTime('dd.mm.yyyy', Lesson.GetDate) + #13#10#13#10 +
                'Информация: ' + Lesson.GetInfo + #13#10#13#10 + 'Домашнее задание: ' +
                Lesson.GetHomeWork;
        IsShown := True;
        MessageBox(Application.Handle, StringToWideChar(Info, WideChars, 1000), 'Информация об уроке', MB_ICONINFORMATION);
        IsShown := False;
    end;
end;

procedure TFormEditJournal.JournalSGKeyPress(Sender: TObject; var Key: Char);
var
    Col, Row: Integer;
begin
    Col := (Sender as TStringGrid).Col;
    Row := (Sender as TStringGrid).Row;
    if Col = 4 then
        if not (Key in ['0'..'9', #8]) then Key := #0
        else
        begin
            if ((Sender as TStringGrid).Cells[Col, Row].Length = 0) and (Key = '0') then
                Key := #0;
            if ((Sender as TStringGrid).Cells[Col, Row].Length = 1) then
                if ((Sender as TStringGrid).Cells[Col, Row] <> '1') and (Key <> #8) then
                    Key := #0;
            if ((Sender as TStringGrid).Cells[Col, Row].Length = 2) and (Key <> #8) then
                Key := #0;
            if ((Sender as TStringGrid).Cells[Col, Row] = '1') and (Key <> '0') and
               (Key <> #8) then
                Key := #0;
        end;
     if Col > 4 then
        if not (Key in ['0'..'9', #8]) then
        begin
            if (Key <> 'н') then Key := #0;
            if ((Sender as TStringGrid).Cells[Col, Row].Length = 1) then Key := #0;
        end
        else
        begin
            if ((Sender as TStringGrid).Cells[Col, Row].Length = 0) and (Key = '0') then
                Key := #0;
            if ((Sender as TStringGrid).Cells[Col, Row].Length = 1) then
            begin
                if ((Sender as TStringGrid).Cells[Col, Row] <> '1') and (Key <> #8) then
                    Key := #0;
                if ((Sender as TStringGrid).Cells[Col, Row] = 'н') and (Key <> #8) then
                    Key := #0;
            end;
            if ((Sender as TStringGrid).Cells[Col, Row].Length = 2) and (Key <> #8) then
                Key := #0;
            if ((Sender as TStringGrid).Cells[Col, Row] = '1') and (Key <> '0') and
               (Key <> #8) then
                Key := #0;
        end;
end;

procedure TFormEditJournal.JournalSGSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
    if ACol = 4 then
    try
        NeedSave := True;
        if (StrToInt(Value) < 1) or (StrToInt(Value) > 10)  then
            (Sender as TstringGrid).Cells[ACol, ARow] := '';
    except
        (Sender as TstringGrid).Cells[ACol, ARow] := '';
    end;
     if ACol > 4 then
    try
        NeedSave := True;
        if (StrToInt(Value) < 1) or (StrToInt(Value) > 10)  then
            (Sender as TstringGrid).Cells[ACol, ARow] := '';
    except
        if Value <> 'н' then
            (Sender as TstringGrid).Cells[ACol, ARow] := '';
    end;
    UpdateSTRG;
    UpdateNotesList;
end;

procedure TFormEditJournal.SaveMenuItemClick(Sender: TObject);
var
    LessonsFile: file of TLesson;
    Lesson: TLesson;
    NoteFile: file of TNote;
    Note: TNote;
    I, J: Integer;
begin
    AssignFile(LessonsFile, 'E_Journal/' + Journal.GetClassName + '/journal/' +
               Journal.GetQuater + '/' + Journal.GetLesson + '/lessons.lessons');
    rewrite(LessonsFile);
    for Lesson in LessonsList do
        Write(LessonsFile, Lesson);
    CloseFile(LessonsFile);

    AssignFile(NoteFile, 'E_Journal/' + Journal.GetClassName + '/journal/' +
               Journal.GetQuater + '/' + Journal.GetLesson + '/notes.notes');
    rewrite(NoteFile);
    for I := 1 to JournalSG.RowCount - 1 do
        for J := 5 to JournalSG.ColCount - 1 do
            if JournalSG.Cells[J, I] <> '' then
            begin
                Note.SetNote(JournalSG.Cells[J, I]);
                Note.SetStudenID(StudentList[I - 1].GetID);
                Note.SetLessonID(LessonsList[J - 5].GetID);
                Write(NoteFile, Note);
            end;
    CloseFile(NoteFile);
    AssignFile(NoteFile, 'E_Journal/' + Journal.GetClassName + '/journal/' +
               Journal.GetQuater + '/' + Journal.GetLesson + '/quater.notes');
    Rewrite(NoteFile);
    for I := 1 to JournalSG.RowCount - 1 do
        if JournalSG.Cells[4, I] <> '' then
        begin
            Note.SetNote(JournalSG.Cells[4, I]);
            Note.SetStudenID(StudentList[I - 1].GetID);
            Note.SetLessonID(DateTimeToUnix(Now));
            write(NoteFile, Note);
        end;
    CloseFile(NoteFile);
    NeedSave := false;
    MessageBox(Application.Handle, 'Информация сохранена.', 'Редактирование журнала',
               MB_ICONINFORMATION);
end;

function TFormEditJournal.FindLesson(ID: Int64): Integer;
var
    Lesson: TLesson;
begin
    for Lesson in LessonsList do
        if Lesson.GetID = ID then
            Result := LessonsList.IndexOf(Lesson);
end;

Function TFormEditJournal.FindStudent(ID: Int64): Integer;
Var
    Student: TStudent;
Begin
    for Student in StudentList do
        if Student.GetID = ID then
            Result := StudentList.IndexOf(Student);
End;

procedure TFormEditJournal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
    var
    CanSave: Integer;
begin
    if ForEditing and NeedSave then
    begin
        CanSave := MessageBox(Application.Handle, 'Сохранить внесенные изменения?'#13#10'Несохраненные данные будут утеряны.',
                              'Редактирование журнала', MB_YESNOCANCEL);
        if CanSave = IDYES then
        begin
            SaveMenuItemClick(SaveMenuItem);
            CanClose := True;
        end
        else if CanSave = IDCANCEL then
            CanClose := False;
        end
    else
        CanClose := True;
end;

procedure TFormEditJournal.PrepareForm;
begin
    Comparer := TDelegatedComparer<TLesson>.Create(
    function (const Left, Right: TLesson): Integer
    begin
        if Left.GetDate < Right.GetDate then
            Result := -1 else
        if Left.GetDate > Right.GetDate then
            Result := 1 else
        Result := 0;
    end);
    Self.Caption := Self.Caption + ' ' + Journal.GetLesson + ', ' + Journal.GetClassName;
    ClassLabel.Caption := ClassLabel.Caption + Journal.GetClassName;
    LessonLabel.Caption := LessonLabel.Caption + Journal.GetLesson;
    QuaterLabel.Caption := QuaterLabel.Caption + Journal.GetQuater;
    JournalSG.Cells[0, 0] := 'Фамилия';
    JournalSG.Cells[1, 0] := 'Имя';
    JournalSG.Cells[2, 0] := 'Пропуски';
    JournalSG.Cells[3, 0] := 'Средний ' + 'балл';
    JournalSG.Cells[4, 0] := 'Четвертная ' +'оценка';
    JournalSG.FixedCols := 4;
    JournalSG.ColWidths[0] := 200;
    JournalSG.ColWidths[1] := 200;
    JournalSG.ColWidths[2] := 95;
    JournalSG.ColWidths[3] := 135;
    JournalSG.ColWidths[4] := 180;
    if Not(ForEditing) then
    Begin
        CaptionLabel.Left := 490;
        JournalSG.Options := JournalSG.Options - [goEditing];
        AddLessonMenuItem.Visible := False;
        SaveMenuItem.Visible := False;
    end
    else
    begin
        CaptionLabel.Left := 475;
        JournalSG.Options := JournalSG.Options + [goEditing];
        AddLessonMenuItem.Visible := True;
        SaveMenuItem.Visible := True;
    end;
end;
procedure TFormEditJournal.FormShow(Sender: TObject);
begin
    PrepareForm;
    ImportJournal;
end;

procedure TFormEditJournal.UpdateSTRGLesson;
var
    Lesson: TLesson;
    I: Integer;
begin
    I := 5;
    for Lesson in LessonsList do
    begin
        JournalSG.Cells[I, 0] := FormatDateTime('dd.mm.yy', Lesson.GetDate);
        Inc(I);
    end;
end;

procedure TFormEditJournal.UpdateNotesList;
var
    Note: TNote;
    I, J: Integer;
begin
    NotesList.Clear;
    for I := 1 to JournalSG.RowCount - 1 do
        for J := 5 to JournalSG.ColCount - 1 do
            if JournalSG.Cells[J, I] <> '' then
            begin
                Note.SetNote(JournalSG.Cells[J, I]);
                Note.SetStudenID(StudentList[I - 1].GetID);
                Note.SetLessonID(LessonsList[J - 5].GetID);
                NotesList.Add(Note);
            end;
end;

procedure TFormEditJournal.UpdateSTRGNotes;
var
    Note: TNote;
    Row, Col: Integer;
begin
    for Row := 1 to JournalSG.RowCount - 1 do
        for Col := 5 to JournalSG.ColCount - 1 do
            JournalSG.Cells[Col, Row] := '';
    for Note in NotesList do
    begin
        Row := FindStudent(Note.GetStudenID) + 1;
        Col := FindLesson(Note.GetLessonID) + 5;
        JournalSG.Cells[Col, Row] := Note.GetNote;
    end;
end;

procedure TFormEditJournal.UpdateSTRGQuaterNotes;
var
    NoteFile: file of TNote;
    Note: TNote;
begin
    NotesList := TList<TNote>.Create;
    AssignFile(NoteFile, 'E_Journal/' + Journal.GetClassName + '/journal/' +
               Journal.GetQuater + '/' + Journal.GetLesson + '/quater.notes');
    Reset(NoteFile);
    while not eof(NoteFile) do
    begin
        Read(NoteFile, Note);
        JournalSG.Cells[4, FindStudent(Note.GetStudenID) + 1] := Note.GetNote;
    end;
    CloseFile(NoteFile);
end;

procedure TFormEditJournal.UpdateSTRG;
var
    MissedLessons, I, J, NoteSum, NoteCount: Integer;
    Middle: Double;
begin
    for I := 1 to JournalSG.RowCount - 1 do
    begin
        MissedLessons := 0;
        NoteCount := 0;
        NoteSum := 0;
        JournalSG.Cells[3, I] := '';
        for J := 5 to JournalSG.ColCount - 1 do
        begin
            if JournalSG.Cells[J, I] = 'н' then
                Inc(MissedLessons)
            else
                if JournalSG.Cells[J, I] <> '' then
                begin
                    NoteSum := NoteSum + StrToInt(JournalSG.Cells[J, I]);
                    Inc(NoteCount);
                end;
        end;
        JournalSG.Cells[2, I] := IntToStr(MissedLessons);
        if NoteCount <> 0 then
        begin
            Middle := NoteSum / NoteCount;
            JournalSG.Cells[3, I] := FormatFloat('#.#0', Middle);
        end;
    end;
end;

procedure TFormEditJournal.GetLessons;
var
    LessonsFile: file of TLesson;
    Lesson: TLesson;
begin
    LessonsList := TList<TLesson>.Create;
    AssignFile(LessonsFile, 'E_Journal/' + Journal.GetClassName + '/journal/' +
               Journal.GetQuater + '/' + Journal.GetLesson + '/lessons.lessons');
    Reset(LessonsFile);
    while not Eof(LessonsFile) do
    begin
        Read(LessonsFile, Lesson);
        LessonsList.Add(Lesson);
    end;
    CloseFile(LessonsFile);
end;

procedure TFormEditJournal.GetNotes;
var
    NoteFile: file of TNote;
    Note: TNote;
begin
    NotesList := TList<TNote>.Create;
    AssignFile(NoteFile, 'E_Journal/' + Journal.GetClassName + '/journal/' +
               Journal.GetQuater + '/' + Journal.GetLesson + '/notes.notes');
    Reset(NoteFile);
    while not Eof(NoteFile) do
    begin
        Read(NoteFile, Note);
        NotesList.Add(Note);
    end;
    CloseFile(NoteFile);
end;

procedure TFormEditJournal.AddLesson();
var
    NewLesson: TLesson;
begin
    FormAddLesson := TFormAddLesson.Create(Self);
    NewLesson := FormAddLesson.CreateLesson;
    if (NewLesson.GetInfo <> '') and (NewLesson.GetHomeWork <> '') then
    begin
        UpdateNotesList;
        LessonsList.Add(NewLesson);
        LessonsList.Sort(Comparer);
        JournalSG.ColCount := 5 + LessonsList.Count;
        JournalSG.FixedCols := 4;
        UpdateSTRGLesson;
        UpdateSTRGNotes;
        NeedSave := True;
    end;
end;

procedure TFormEditJournal.AddLessonMenuItemClick(Sender: TObject);
begin
    AddLesson();
end;

procedure TFormEditJournal.FillJournalSG;
var
    Student: TStudent;
begin
    if StudentList.Count > 0 then
        JournalSG.RowCount := StudentList.Count + 1
    else
        JournalSG.RowCount := 2;
    if JournalSG.RowCount > 1 then
        JournalSG.FixedRows := 1;
    for Student in StudentList do
    begin
        JournalSG.Cells[0, StudentList.IndexOf(Student) + 1] := Student.GetLastName;
        JournalSG.Cells[1, StudentList.IndexOf(Student) + 1] := Student.GetName;
    end;
end;

procedure TFormEditJournal.ImportJournal;
begin
    GetStudents;
    GetLessons;
    GetNotes;
    FillJournalSG;
    UpdateSTRGLesson;
    JournalSG.ColCount := 5 + LessonsList.Count;
    If LessonsList.Count >= 1 then
        JournalSG.FixedCols := 4;
    if NotesList.Count > 0 then
        UpdateSTRGNotes;
    UpdateSTRG;
    UpdateSTRGQuaterNotes;
    NeedSave := false;
end;


procedure TFormEditJournal.InformationMenuItemClick(Sender: TObject);
var
    Help: string;
begin
    if ForEditing then
        Help := 'Редактирование журнала.'#13#10#13#10'В данном разделе можно редактировать оценки учеников и выставлять пропуски учениками занятий ("н"), добавлять уроки, выставлять четвертные отметки.'#13#10'Горячие клавиши: F1 - Справка, F2 - Добавить урок, Ctrl+S - Сохранить'
    else
        Help := 'Просмотр журнала.'#13#10#13#10'В данном разделе можно просмотреть выставленные в журнал оценки без возможности их изменения';
    MessageBox(Application.Handle, PChar(Help), 'Справка', MB_ICONINFORMATION);
end;

end.
