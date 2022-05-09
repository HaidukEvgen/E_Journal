unit UnitEditClass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, System.Generics.Collections, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus,
  Vcl.CheckLst, UnitStudent, System.Generics.Defaults;

type
  TFormEditClass = class(TForm)
    CaptionLabel: TLabel;
    MainMenu: TMainMenu;
    InformationMenuItem: TMenuItem;
    InfoLabel: TLabel;
    ClassLabel: TLabel;
    SubjectsLabel: TLabel;
    SubjectsCheckListBox: TCheckListBox;
    SaveButton: TButton;
    StudentsLabel: TLabel;
    StudentsSG: TStringGrid;
    AddButton: TButton;
    DeleteButton: TButton;
    DeleteMenuItem: TMenuItem;
    procedure FillLessonsList;
    procedure FillStudentsArr;
    procedure UpdateJournal;
    procedure SaveClass;
    procedure DeleteClassInfo;
    procedure FormCreate(Sender: TObject);
    procedure DeleteMenuItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckLessons;
    procedure WriteStudents;
    procedure SubjectsCheckListBoxClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function TakeStudent(I: Integer): TStudent;
    procedure AddButtonClick(Sender: TObject);
    procedure StudentsSGKeyPress(Sender: TObject; var Key: Char);
  private
    LessonsList: TList<String>;
    NeedSave: Boolean;
    StudentsArr: Array of TStudent;
  public
    ClassName: String;
  end;

var
  FormEditClass: TFormEditClass;

implementation
var
    Comparer: TDelegatedComparer<TStudent>;
Const
    SUBJECTS = 22;

{$R *.dfm}

procedure TFormEditClass.DeleteMenuItemClick(Sender: TObject);
var
    CanDelete: Integer;
begin
    CanDelete := MessageBox(Application.Handle, 'Вы точно хотите удалить класс?'#13#10'Вся информация о классе будет утеряна.', 'Удаление класса', MB_YESNO);
    if CanDelete = IDYES then
    begin
        DeleteClassInfo;
        MessageBox(Application.Handle, 'Класс усешно удален.', 'Удаление класса', MB_ICONINFORMATION);
        Self.Close;
    end;
end;

procedure TFormEditClass.FillLessonsList;
var
    LessonsFile: TextFile;
    TempStr: String;
begin
    AssignFile(LessonsFile, 'E_Journal/' + ClassName + '/lessons.lessons');
    Reset(LessonsFile);
    While Not Eof(LessonsFile) do
    Begin
        Readln(LessonsFile, TempStr);
        If LessonsList.IndexOf(TempStr) = -1 then
            LessonsList.Add(TempStr);
    End;
    CloseFile(LessonsFile);
end;

procedure TFormEditClass.FillStudentsArr;
var
    StudentsFile: File of TStudent;
    Student: TStudent;
    I: Integer;
begin
    AssignFile(StudentsFile, 'E_Journal/' + ClassName + '/students.students');
    Reset(StudentsFile);
    SetLength(StudentsArr, FileSize(StudentsFile));
    I := 1;
    While Not Eof(StudentsFile) do
    begin
        Read(StudentsFile, Student);
        StudentsArr[I] := Student;
        Inc(I);
    end;
    CloseFile(StudentsFile);
end;

procedure TFormEditClass.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    CanSave: Integer;
begin
    if NeedSave then
    begin
        CanSave := MessageBox(Application.Handle, 'Сохранить внесенные изменения?'#13#10'Несохраненные данные будут утеряны.',
                              'Редактирование класса', MB_YESNOCANCEL);
        if CanSave = IDYES then
        begin
            SaveClass;
            CanClose := true;
        end
        else if CanSave = IDCANCEL then
            CanClose := false;
    end
    else
        CanClose := true;
end;

procedure TFormEditClass.FormCreate(Sender: TObject);
begin
    StudentsSG.ColWidths[0] := 25;
    StudentsSG.Cells[0, 0] := '№';
    StudentsSG.Cells[0, 1] := '1';
    StudentsSG.Cells[1, 0] := 'Фамилия';
    StudentsSG.Cells[2, 0]  := 'Имя';
    StudentsSG.Cells[1, 1] := '';
    StudentsSG.Cells[2, 1]  := '';
    StudentsSG.RowCount := 2;
    StudentsSG.Row := 1;
end;

procedure TFormEditClass.AddButtonClick(Sender: TObject);
begin
    StudentsSG.RowCount := StudentsSG.RowCount + 1;
    StudentsSG.Cells[0, StudentsSG.RowCount - 1] := IntToStr(StudentsSG.RowCount - 1);
    if StudentsSG.RowCount >= 2 then
        DeleteButton.Enabled := True;
    if StudentsSG.RowCount = 31 then
        AddButton.Enabled := False;
    StudentsSG.Row := StudentsSG.RowCount - 1;
    NeedSave := True;
    SaveButton.Enabled := NeedSave;
end;

procedure TFormEditClass.CheckLessons;
var
    I: Integer;
begin
    While (I <= SUBJECTS) do
    begin
        if LessonsList.Contains(SubjectsCheckListBox.Items[I]) then
            SubjectsCheckListBox.Checked[I] := True;
        Inc(I);
        NeedSave := False;
        SaveButton.Enabled := NeedSave;
    end;
end;

procedure TFormEditClass.WriteStudents;
var
    I: Integer;
begin
    StudentsSG.RowCount := Length(StudentsArr) + 1;
    For I := 1 to Length(StudentsArr) do
    Begin
        StudentsSG.Cells[0, I] := IntToStr(I);
        StudentsSG.Cells[1, I] := StudentsArr[I].GetLastName;
        StudentsSG.Cells[2, I] := StudentsArr[I].GetName;
    end;
end;

procedure TFormEditClass.FormShow(Sender: TObject);
begin
    NeedSave := false;
    SaveButton.Enabled := NeedSave;
    ClassLabel.Caption := 'Класс: ' + ClassName;
    LessonsList := TList<String>.Create;
    FillLessonsList;
    CheckLessons;
    FillStudentsArr;
    WriteStudents;
end;

procedure TFormEditClass.UpdateJournal;
var
    LetterNumber, JournalDir, LessonDir: String;
    I, J: Integer;
    NotesFile, LessonsFile: TextFile;
begin
    LetterNumber := ClassName;
    LetterNumber := LetterNumber.ToUpper;
    JournalDir := 'E_Journal/' + ClassName + '/journal';
    if not DirectoryExists(JournalDir) then
    begin
        CreateDir(JournalDir);
        CreateDir(JournalDir + '/1');
        CreateDir(JournalDir + '/2');
        CreateDir(JournalDir + '/3');
        CreateDir(JournalDir + '/4');
    end;
    for J := 1 to 4 do
        for I := 0 to SUBJECTS do
            if SubjectsCheckListBox.Checked[I] then
                if SubjectsCheckListBox.Checked[I] then
                begin
                    LessonDir := JournalDir + '/' + IntToStr(J) + '/' + SubjectsCheckListBox.Items[I];
                    if not DirectoryExists(LessonDir) then
                    begin
                        CreateDir(LessonDir);
                        AssignFile(NotesFile, JournalDir + '/' + IntToStr(J) + '/' +
                                   SubjectsCheckListBox.Items[I] + '/notes.notes');
                        Rewrite(NotesFile);
                        Write(NotesFile, '');
                        CloseFile(NotesFile);

                        AssignFile(NotesFile, JournalDir + '/' + IntToStr(J) + '/' +
                                   SubjectsCheckListBox.Items[I] + '/quater.notes');
                        Rewrite(NotesFile);
                        Write(NotesFile, '');
                        CloseFile(NotesFile);

                        AssignFile(LessonsFile, JournalDir + '/' + IntToStr(J) + '/' +
                                   SubjectsCheckListBox.Items[I] + '/lessons.lessons');
                        Rewrite(LessonsFile);
                        Write(LessonsFile, '');
                        CloseFile(LessonsFile);
                    end;
                end;
end;

procedure TFormEditClass.SaveButtonClick(Sender: TObject);
var
    CanSave: Integer;
begin
    CanSave := MessageBox(Application.Handle, 'Вы точно хотите сохранить изменения?',
                          'Редактирование класса', MB_YESNO);
    if CanSave = IDYES then
    begin
        SaveClass;
        MessageBox(Application.Handle, 'Информация сохранена.', 'Редактирование класса',
                   MB_ICONINFORMATION);
    end;
end;

function TFormEditClass.TakeStudent(I: Integer): TStudent;
Var
    Student: TStudent;
Begin
    Student.NewStudent(StudentsSG.Cells[2, I], StudentsSG.Cells[1, I]);
    Result := Student;
End;

procedure TFormEditClass.SaveClass;
var
    LessonsFile: TextFile;
    StudentsFile: File of TStudent;
    I: Integer;
    Student: TStudent;
begin
    NeedSave := False;
    SaveButton.Enabled := NeedSave;
    AssignFile(LessonsFile, 'E_Journal/' + ClassName + '/lessons.lessons');
    Rewrite(LessonsFile);
    For I := 0 to SUBJECTS do
        If SubjectsCheckListBox.Checked[I] then
            If SubjectsCheckListBox.Checked[I] then
                Writeln(LessonsFile, SubjectsCheckListBox.Items[I]);
    CloseFile(LessonsFile);
    UpdateJournal;
    AssignFile(StudentsFile, 'E_Journal/' + ClassName + '/students.students');
    Rewrite(StudentsFile);
    for I := 1 to StudentsSG.RowCount - 1 do
    Begin
        Student := TakeStudent(I);
        Write(StudentsFile, Student);
    End;
    CloseFile(StudentsFile);
end;

procedure TFormEditClass.StudentsSGKeyPress(Sender: TObject; var Key: Char);
begin
    NeedSave := true;
    SaveButton.Enabled := NeedSave;
    if ((Key < #128) or (Key > #159)) and (Key <> #8) then
        Key := #0;
    if (Length(StudentsSG.Cells[StudentsSG.Col, StudentsSG.Row]) > 18) and Not(Key in [#8, #13]) then
        Key := #0;
end;

procedure TFormEditClass.SubjectsCheckListBoxClick(Sender: TObject);
begin
    NeedSave := true;
    SaveButton.Enabled := NeedSave;
end;

procedure TFormEditClass.DeleteClassInfo;
var
    sr: TSearchRec;
    I: Integer;
begin
    DeleteFile('E_Journal/' + ClassName + '/lessons.lessons');
    DeleteFile('E_Journal/' + ClassName + '/students.students');

    for I := 1 to 4 do
        If FindFirst('E_Journal/' + ClassName + '/journal/' + IntToStr(I) + '/*', faDirectory, sr) = 0 then
            repeat
                If (sr.Name <> '') and (sr.Name <> '.') and (sr.Name <> '..') then
                    if sr.Attr = faDirectory then
                    begin
                        DeleteFile('E_Journal/' + ClassName + '/journal/' + IntToStr(I) +
                                   '/' + sr.Name + '/notes.notes');
                        DeleteFile('E_Journal/' + ClassName + '/journal/' + IntToStr(I) +
                                   '/' + sr.Name + '/quater.notes');
                        DeleteFile('E_Journal/' + ClassName + '/journal/' + IntToStr(I) +
                                   '/' + sr.Name + '/lessons.lessons');
                        RemoveDir('E_Journal/' + ClassName + '/journal/' + IntToStr(I) +
                                  '/' + sr.Name);
                    end;
            until (FindNext(sr) <> 0);
    FindClose(sr);
    RemoveDir('E_Journal/' + ClassName + '/journal/1');
    RemoveDir('E_Journal/' + ClassName + '/journal/2');
    RemoveDir('E_Journal/' + ClassName + '/journal/3');
    RemoveDir('E_Journal/' + ClassName + '/journal/4');
    RemoveDir('E_Journal/' + ClassName + '/journal');
    RemoveDir('E_Journal/' + ClassName);
end;





end.
