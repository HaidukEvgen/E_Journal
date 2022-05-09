unit UnitAddClass;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus,
    Vcl.CheckLst, Vcl.Samples.Spin, UnitStudent, System.Generics.Defaults, System.Generics.Collections;

type
    TFormAddClass = class(TForm)
        CaptionLabel: TLabel;
        MainMenu: TMainMenu;
        InformationMenuItem: TMenuItem;
        NumberLabel: TLabel;
        NumberSpinEdit: TSpinEdit;
        LetterLabel: TLabel;
        LetterEdit: TEdit;
        SubjectsLabel: TLabel;
        SubjectsCheckListBox: TCheckListBox;
        AddClassButton: TButton;
        StudentsLabel: TLabel;
        StudentsSG: TStringGrid;
        AddButton: TButton;
        DeleteButton: TButton;
        PopupMenu: TPopupMenu;
        InfoLabel: TLabel;
        ClassLabel: TLabel;
        DeleteClassMenuItem: TMenuItem;
        procedure LetterEditKeyPress(Sender: TObject; var Key: Char);
        procedure NumberSpinEditKeyPress(Sender: TObject; var Key: Char);
        procedure NumberSpinEditChange(Sender: TObject);
        procedure PutChecks();
        procedure AddClassButtonClick(Sender: TObject);
        function MakeDir(): Boolean;
        function IsDataCorrect: Boolean;
        procedure MakeClassLessonsFile;
        procedure MakeClassStudentsFile;
        procedure MakeClassJournal;
        procedure AddButtonClick(Sender: TObject);
        procedure DeleteButtonClick(Sender: TObject);
        procedure StudentsSGSelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StudentsSGKeyPress(Sender: TObject; var Key: Char);
        procedure AddStudents;
        function CreateNewStudent(I: Integer): TStudent;
        procedure SaveChanges();
        procedure SaveClass();
        procedure UpdateJournal;
        procedure FillLessonsList;
        procedure FillStudentsList;
        procedure CheckLessons;
        procedure WriteStudents;
        procedure DeleteClassMenuItemClick(Sender: TObject);
        procedure DeleteClassInfo(DeleteAll: Boolean);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure SubjectsCheckListBoxClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure InformationMenuItemClick(Sender: TObject);
        procedure AddClass();
        procedure SortSG;
        procedure PrepareForEditing;
        procedure PrepareForAdding;
    private
      LessonsList: TList<string>;
      NeedSave: Boolean;
    public
      ClassName: string;
      ForEditing: Boolean;
    end;

var
    FormAddClass: TFormAddClass;

implementation

type
    TNums = set of 0..22;
    TPt = ^TStud;
    TStud = record
        Student: TStudent;
        Next: TPt;
    end;
var
    StudHead: TPt;

const
    SUBJECTS = 22;
    BEL_Y = 0;
    BEL_L = 1;
    RUS_Y = 2;
    RUS_L = 3;
    IN_Y = 4;
    MAT = 5;
    INF = 6;
    CHEL = 7;
    IST = 8;
    IST_BEL = 9;
    OBSH = 10;
    GEOG = 11;
    BIO = 12;
    FIZ = 13;
    ASTR = 14;
    CHIM = 15;
    IZO = 16;
    MUS = 17;
    TRUD = 18;
    CHER = 19;
    FIZR = 20;
    DPMP = 21;
    OBZ = 22;
    NOT_FOR_OLD: TNums = [MUS, CHEL, CHER, DPMP, ASTR];
    NOT_FOR_YOUNG: TNums = [IN_Y, INF, IST, IST_BEL, OBSH, GEOG, BIO, FIZ, ASTR, CHIM, CHER, DPMP];

{$R *.dfm}

procedure TFormAddClass.InformationMenuItemClick(Sender: TObject);
var
    Help: String;
begin
    if ForEditing then
        Help :=  'Редактирование класса.'#13#10#13#10'В этом разделе можно отредактировать изучаемые классом предметы, добавить в класс ученика или удалить ученика из класса, удалить класс.'#13#10#13#10'Внимание! При внесении любых изменений в класс, журнал класса создаётся заново.'
    else
        Help :=  'Добавление класса.'#13#10#13#10'Для добавления класса нужно указать его номер (число от 1 до 11), буквенное обозначение (любая буква русского алфавита), указать хотя бы один изучаемый предмет и минмум одного ученика.'#13#10#13#10'';
    MessageBox(Application.Handle, PChar(Help), 'Справка', MB_ICONINFORMATION);
end;

function TFormAddClass.IsDataCorrect: Boolean;
var
    IsCorrect, IsChecked: Boolean;
    Error: string;
    I, J: Integer;
    Symbols: Set of 0..63;
    Cap: string;
begin
    IsCorrect := true;
    IsChecked := false;
    if ForEditing then
        Cap := 'Редактирование класса'
    else
        Cap := 'Добавление класса';
    if not(ForEditing) and (LetterEdit.Text = '') then
    begin
        IsCorrect := false;
        MessageBox(Application.Handle, 'Вы не ввели буквенное обозначение класса.', PChar(Cap), MB_ICONERROR);
    end;
    if IsCorrect then
    begin
        I := 0;
        while (I <= SUBJECTS) and not IsChecked do
        begin
            If SubjectsCheckListBox.Checked[I] = True then
                IsChecked := True;
            Inc(I);
        end;
        if not IsChecked then
        begin
            IsCorrect := false;
            MessageBox(Application.Handle, 'Вы не выбрали изучаемые предметы.', PChar(Cap), MB_ICONERROR);
        end;
    end;
    for I := 1040 to 1103 do
      Include(Symbols, I);
    I := 1;
    while IsCorrect and (I < StudentsSG.RowCount) do
    begin
        J := 1;
        if (Length(StudentsSG.Cells[1, I]) < 2) or (Length(StudentsSG.Cells[1, I]) > 19) then
            IsCorrect := False;
        while IsCorrect and (J <= Length(StudentsSG.Cells[1, I])) do
        begin
            if (Ord((StudentsSG.Cells[1, I][J])) < 1040) or (Ord((StudentsSG.Cells[1, I][J])) > 1103) then
                IsCorrect := False;
            Inc(J);
        end;
        J := 1;
        if (Length(StudentsSG.Cells[2, I]) < 2) or (Length(StudentsSG.Cells[2, I]) > 19) then
            IsCorrect := False;
        while IsCorrect and (J <= Length(StudentsSG.Cells[2, I])) do
        begin
            if (Ord((StudentsSG.Cells[2, I][J])) < 1040) or (Ord((StudentsSG.Cells[2, I][J])) > 1103) then
                IsCorrect := False;
            Inc(J);
        end;
        if Not IsCorrect then
        begin
            Error := 'Вы ввели некорректные данные ' + IntToStr(I) + ' ученика';
            MessageBox(Application.Handle, PChar(Error), PChar(Cap), MB_ICONERROR);
        End;
        Inc(I);
    end;
    Result := IsCorrect;
end;

function TFormAddClass.MakeDir(): Boolean;
var
    ClassDir: string;
    LetterNumber: string;
begin
    LetterNumber := LetterEdit.Text;
    LetterNumber := LetterNumber.ToUpper;
    ClassDir := IntToStr(NumberSpinEdit.Value) + ' ' + LetterNumber;
    if not DirectoryExists('E_Journal/' + ClassDir) then
    begin
        CreateDir('E_Journal/' + ClassDir);
        Result := True;
    end
    else
    begin
        MessageBox(Application.Handle, 'Класс уже существует.', 'Добавление класса', MB_ICONERROR);
        Result := False;
    end;
end;

procedure TFormAddClass.MakeClassLessonsFile;
var
    I: Integer;
    ClassLessonsFile: TextFile;
    ClassLessonsDir: string;
    LetterNumber: string;
begin
    LetterNumber := LetterEdit.Text;
    LetterNumber := LetterNumber.ToUpper;
    ClassLessonsDir := 'E_Journal/' +  IntToStr(NumberSpinEdit.Value) + ' ' + LetterNumber + '/lessons.lessons';
    AssignFile(ClassLessonsFile, ClassLessonsDir);
    Rewrite(ClassLessonsFile);
    for I := 0 to SUBJECTS do
        if SubjectsCheckListBox.Checked[I] = True then
            Writeln(ClassLessonsFile, SubjectsCheckListBox.Items[I]);
     CloseFile(ClassLessonsFile);
end;

procedure TFormAddClass.MakeClassStudentsFile;
var
    ClassStudentsDir: string;
    LetterNumber: string;
    ClassStudentsFile: TextFile;
begin
    LetterNumber := LetterEdit.Text;
    LetterNumber := LetterNumber.ToUpper;
    ClassStudentsDir := 'E_Journal/' +  IntToStr(NumberSpinEdit.Value) + ' ' + LetterNumber + '/students.students';
    AssignFile(ClassStudentsFile, ClassStudentsDir);
    Rewrite(ClassStudentsFile);
    Write(ClassStudentsFile, '');
    CloseFile(ClassStudentsFile);
end;

procedure TFormAddClass.MakeClassJournal;
var
    LetterNumber, JournalDir: string;
    I, J: Integer;
    NotesFile, LessonsFile: TextFile;
begin
    LetterNumber := LetterEdit.Text;
    LetterNumber := LetterNumber.ToUpper;
    JournalDir := 'E_Journal/' +  IntToStr(NumberSpinEdit.Value) + ' ' +  LetterNumber + '/journal';
    CreateDir(JournalDir);
    CreateDir(JournalDir + '/1');
    CreateDir(JournalDir + '/2');
    CreateDir(JournalDir + '/3');
    CreateDir(JournalDir + '/4');
    for J := 1 to 4 do
        for I := 0 to SUBJECTS do
            if SubjectsCheckListBox.Checked[I] then
            begin
                CreateDir(JournalDir + '/' + IntToStr(J) + '/' + SubjectsCheckListBox.Items[I]);
                AssignFile(NotesFile, JournalDir + '/' + IntToStr(J) + '/' +
                          SubjectsCheckListBox.Items[I] + '/notes.notes');
                Rewrite(NotesFile);
                Write(NotesFile, '');
                CloseFile(NotesFile);
                CreateDir(JournalDir + '/' + IntToStr(J) + '/' + SubjectsCheckListBox.Items[I]);
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

procedure TFormAddClass.AddButtonClick(Sender: TObject);
begin
    StudentsSG.RowCount := StudentsSG.RowCount + 1;
    StudentsSG.Cells[0, StudentsSG.RowCount - 1] := IntToStr(StudentsSG.RowCount - 1);
    StudentsSG.Cells[1, StudentsSG.RowCount - 1] := '';
    StudentsSG.Cells[2, StudentsSG.RowCount - 1] := '';
    if StudentsSG.RowCount >= 2 then
        DeleteButton.Enabled := True;
    if StudentsSG.RowCount = 31 then
        AddButton.Enabled := False;
    StudentsSG.Row := StudentsSG.RowCount - 1;
    NeedSave := True;
    AddClassButton.Enabled := NeedSave;
end;

function TFormAddClass.CreateNewStudent(I: Integer): TStudent;
var
    Student: TStudent;
    Name, LastName: string;
begin
    Name := StudentsSG.Cells[2, I].ToLower;
    Name[1] := Chr(Ord(Name[1]) - 32);
    LastName := StudentsSG.Cells[1, I].ToLower;
    LastName[1] := Chr(Ord(LastName[1]) - 32);
    Student.NewStudent(Name, LastName);
    Result := Student;
end;

procedure TFormAddClass.SortSG;
var
    TempFirstName, TempLastName: string;
    I, J, N: Byte;
    IsChecked, IsSorted: Boolean;
begin
    IsSorted := False;
    if (StudentsSG.RowCount > 2) then
    begin
        if (StudentsSG.RowCount = 3) then
        begin
            if(CompareStr(StudentsSG.Cells[1, 1], StudentsSG.Cells[1, 2]) > 0) then
            begin
                TempLastName := StudentsSG.Cells[1, 2];
                TempFirstName := StudentsSG.Cells[2, 2];
                StudentsSG.Cells[1, 2] := StudentsSG.Cells[1, 1];
                StudentsSG.Cells[2, 2] := StudentsSG.Cells[2, 1];
                StudentsSG.Cells[1, 1] := TempLastName;
                StudentsSG.Cells[2, 1] := TempFirstName;
            end;
            IsSorted := True;
        end;
        if not IsSorted then
        begin
            for J := 1 to StudentsSG.RowCount - 1 do
                for I := 1 to StudentsSG.RowCount - 1 - J do
                   If CompareStr(StudentsSG.Cells[1, I], StudentsSG.Cells[1, I + 1]) > 0 then
                    begin
                        TempLastName := StudentsSG.Cells[1, I + 1];
                        TempFirstName := StudentsSG.Cells[2, I + 1];
                        StudentsSG.Cells[1, I + 1] := StudentsSG.Cells[1, I];
                        StudentsSG.Cells[2, I + 1] := StudentsSG.Cells[2, I];
                        StudentsSG.Cells[1, I] := TempLastName;
                        StudentsSG.Cells[2, I] := TempFirstName;
                    end;
        end;
    end;
end;

procedure TFormAddClass.AddStudents;
var
    Student: TStudent;
    StudCur: TPt;
    StudentsFile: file of TStudent;
    ClassDir: string;
    LetterNumber: string;
    I: Integer;
begin
    for I := 1 to StudentsSG.RowCount - 1 do
    begin
        StudentsSG.Cells[1, I] := StudentsSG.Cells[1, I].ToLower;
        StudentsSG.Cells[2, I] := StudentsSG.Cells[2, I].ToLower;
    end;
    SortSG;
    New(StudCur);
    StudHead := StudCur;
    for I := 1 to StudentsSG.RowCount - 1 do
    begin
        Student.NewStudent('', '');
        Student := CreateNewStudent(I);
        if Student.GetName <> '' then
        begin
            New(StudCur^.Next);
            StudCur := StudCur^.Next;
            StudCur^.Student := Student;
        end;
    end;
    StudCur^.Next := nil;
    LetterNumber := LetterEdit.Text;
    LetterNumber := LetterNumber.ToUpper;
    ClassDir := IntToStr(NumberSpinEdit.Value) + ' ' + LetterNumber;
    AssignFile(StudentsFile, 'E_Journal/' + ClassDir + '/students.students');
    Rewrite(StudentsFile);
    StudCur := StudHead^.Next;
    for I := 1 to StudentsSG.RowCount - 1 do
    begin
        Write(StudentsFile, StudCur^.Student);
        StudCur := StudCur^.Next;
    end;
    CloseFile(StudentsFile);
end;

procedure TFormAddClass.AddClass();
begin
    if IsDataCorrect then
    if ForEditing then
        SaveChanges
    else
        if MakeDir then
        begin
            MakeClassLessonsFile;
            MakeClassStudentsFile;
            MakeClassJournal;
            AddStudents;
            MessageBox(Application.Handle, 'Класс успешно создан.', 'Добавление класса', MB_ICONINFORMATION);
            Close;
        end;
end;

procedure TFormAddClass.AddClassButtonClick(Sender: TObject);
begin
    AddClass();
end;

procedure TFormAddClass.SaveChanges();
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
        Close;
    end;
end;

procedure TFormAddClass.SaveClass;
var
    LessonsFile: TextFile;
    StudentsFile: file of TStudent;
    I: Integer;
    Student: TStudent;
begin
    NeedSave := False;
    AssignFile(LessonsFile, 'E_Journal/' + ClassName + '/lessons.lessons');
    Rewrite(LessonsFile);
    for I := 0 to SUBJECTS do
        if SubjectsCheckListBox.Checked[I] then
            if SubjectsCheckListBox.Checked[I] then
                Writeln(LessonsFile, SubjectsCheckListBox.Items[I]);
    CloseFile(LessonsFile);
    DeleteClassInfo(False);
    UpdateJournal;
    AssignFile(StudentsFile, 'E_Journal/' + ClassName + '/students.students');
    Rewrite(StudentsFile);
    for I := 1 to StudentsSG.RowCount - 1 do
    begin
        StudentsSG.Cells[1, I] := StudentsSG.Cells[1, I].ToLower;
        StudentsSG.Cells[2, I] := StudentsSG.Cells[2, I].ToLower;
    end;
    SortSG;
    for I := 1 to StudentsSG.RowCount - 1 do
    begin
        Student.NewStudent('', '');
        Student := CreateNewStudent(I);
        Write(StudentsFile, Student);
    end;
    CloseFile(StudentsFile);
end;

procedure TFormAddClass.UpdateJournal;
var
    LetterNumber, JournalDir, LessonDir: string;
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
        begin
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
end;

procedure TFormAddClass.DeleteButtonClick(Sender: TObject);
var
    I, J: Integer;
begin
    if ForEditing then
    begin
        NeedSave := True;
        AddClassButton.Enabled := NeedSave;
    end;
    with StudentsSG do
    begin
        for I := Row + 1 to RowCount - 1 do
            for J := 0 to RowCount - 1 do
                Cells[J, I - 1] := Cells[J, I];
        for I := 0 to ColCount - 1 do
            Cells[I, RowCount - 1] := '';
        RowCount := RowCount - 1;
        if RowCount = 1 then
            DeleteButton.Enabled := False;
        for I := 1 to StudentsSG.RowCount - 1 do
            Cells[0, I] := IntToStr(I);
    end;
    if StudentsSG.RowCount = 2 then
        DeleteButton.Enabled := False;
    if StudentsSG.RowCount < 31 then
        AddButton.Enabled := True;

end;

procedure TFormAddClass.DeleteClassMenuItemClick(Sender: TObject);
var
    CanDelete: Integer;
begin
    CanDelete := MessageBox(Application.Handle, 'Вы точно хотите удалить класс?'#13#10'Вся информация о классе будет утеряна.', 'Удаление класса', MB_YESNO);
    if CanDelete = IDYES then
    begin
        DeleteClassInfo(True);
        MessageBox(Application.Handle, 'Класс усешно удален.', 'Удаление класса', MB_ICONINFORMATION);
        Self.Close;
    end;
end;

procedure TFormAddClass.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    CanSave: Integer;
begin
    if ForEditing and NeedSave then
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

procedure TFormAddClass.FormCreate(Sender: TObject);
begin
    with StudentsSG do
    begin
        ColWidths[0] := 25;
        Cells[0, 0] := '№';
        Cells[0, 1] := '1';
        Cells[1, 0] := 'Фамилия';
        Cells[2, 0]  := 'Имя';
    end;
end;

procedure TFormAddClass.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if Button = mbRight then
        Caption := Caption + 'wef';
end;

procedure TFormAddClass.PrepareForEditing;
begin
    Caption := 'Редактирование класса';
    CaptionLabel.Caption := 'Редактирование класса';
    CaptionLabel.Left := 282;
    InfoLabel.Visible := True;
    ClassLabel.Visible := True;
    ClassLabel.Caption := 'Класс: ' + ClassName.ToUpper;
    AddClassButton.Caption := 'Сохранить изменения';
    NumberLabel.Visible := False;
    LetterLabel.Visible := False;
    NumberSpinEdit.Visible := False;
    LetterEdit.Visible := False;
    DeleteClassMenuItem.Visible := True;
    NeedSave := false;
    AddClassButton.Enabled := NeedSave;
    ClassLabel.Caption := 'Класс: ' + ClassName;
    LessonsList := TList<String>.Create;
    FillLessonsList;
    CheckLessons;
    FillStudentsList;
    WriteStudents;
    if StudentsSG.RowCount > 2 then
        DeleteButton.Enabled := True;
end;

procedure TFormAddClass.PrepareForAdding;
begin
    Caption := 'Добавление класса';
    CaptionLabel.Caption := 'Добавление класса';
    CaptionLabel.Left := 289;
    InfoLabel.Visible := False;
    ClassLabel.Visible := False;
    AddClassButton.Caption := 'Добавить класс';
    NumberLabel.Visible := True;
    LetterLabel.Visible := True;
    NumberSpinEdit.Visible := True;
    LetterEdit.Visible := True;
    DeleteClassMenuItem.Visible := False;
    AddClassButton.Enabled := True;
    NumberSpinEdit.Text := '1';
    NumberSpinEdit.OnChange(NumberSpinEdit);
    with StudentsSG do
    begin
        Cells[1, 1] := '';
        Cells[2, 1]  := '';
        RowCount := 2;
        Row := 1;
    end;
    LetterEdit.Text := '';
end;


procedure TFormAddClass.FormShow(Sender: TObject);
var
    I: Integer;
begin
    for I := 1 to StudentsSG.RowCount - 1 do
    begin
        StudentsSG.Cells[1, I] := '';
        StudentsSG.Cells[2, I] := '';
    end;
    if ForEditing then
        PrepareForEditing
    else
        PrepareForAdding
end;

procedure TFormAddClass.FillLessonsList;
var
    LessonsFile: TextFile;
    TempStr: String;
begin
    AssignFile(LessonsFile, 'E_Journal/' + ClassName + '/lessons.lessons');
    Reset(LessonsFile);
    while Not Eof(LessonsFile) do
    begin
        Readln(LessonsFile, TempStr);
        if LessonsList.IndexOf(TempStr) = -1 then
            LessonsList.Add(TempStr);
    end;
    CloseFile(LessonsFile);
end;

procedure TFormAddClass.FillStudentsList;
var
    StudentsFile: file of TStudent;
    Student: TStudent;
    StudCur: TPt;
begin
    AssignFile(StudentsFile, 'E_Journal/' + ClassName + '/students.students');
    Reset(StudentsFile);
    New(StudCur);
    StudHead := StudCur;
    while not Eof(StudentsFile) do
    begin
        Read(StudentsFile, Student);
        New(StudCur^.Next);
        StudCur := StudCur^.Next;
        StudCur^.Student := Student;
    end;
    StudCur^.Next := nil;
    CloseFile(StudentsFile);
end;

procedure TFormAddClass.CheckLessons;
var
    I: Integer;
begin
    for I := 0 to SUBJECTS do
        SubjectsCheckListBox.Checked[I] := False;
    I := 0;
    while (I <= SUBJECTS) do
    begin
        if LessonsList.Contains(SubjectsCheckListBox.Items[I]) then
            SubjectsCheckListBox.Checked[I] := True;
        Inc(I);
        NeedSave := False;
        AddClassButton.Enabled := NeedSave;
    end;
end;

procedure TFormAddClass.WriteStudents;
var
    I: Integer;
    StudCur: TPt;
begin
    StudCur := StudHead^.Next;
    I := 0;
    while StudCur <> Nil do
    begin
        Inc(I);
        StudCur := StudCur^.Next;
    end;
    StudentsSG.RowCount := I + 1;
    I := 1;
    StudCur := StudHead^.Next;
    while StudCur <> nil do
    begin
        StudentsSG.Cells[0, I] := IntToStr(I);
        StudentsSG.Cells[1, I] := StudCur^.Student.GetLastName;
        StudentsSG.Cells[2, I] := StudCur^.Student.GetName;
        StudCur := StudCur^.Next;
        Inc(I);
    end;
end;

procedure TFormAddClass.DeleteClassInfo(DeleteAll: Boolean);
var
    sr: TSearchRec;
    I: Integer;
begin
    if DeleteAll then
    Begin
        DeleteFile('E_Journal/' + ClassName + '/lessons.lessons');
        DeleteFile('E_Journal/' + ClassName + '/students.students');
    End;
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
    if DeleteAll then
    begin
        RemoveDir('E_Journal/' + ClassName + '/journal/1');
        RemoveDir('E_Journal/' + ClassName + '/journal/2');
        RemoveDir('E_Journal/' + ClassName + '/journal/3');
        RemoveDir('E_Journal/' + ClassName + '/journal/4');
        RemoveDir('E_Journal/' + ClassName + '/journal');
        RemoveDir('E_Journal/' + ClassName);
    end;
end;

procedure TFormAddClass.LetterEditKeyPress(Sender: TObject; var Key: Char);
begin
    If (Key <> #8) and ((Key < #128) or (Key > #159))then
        Key := #0;
end;

procedure TFormAddClass.PutChecks();
var
    I: Byte;
begin
    with SubjectsCheckListBox Do
    begin
        Checked[BEL_Y] := True;
        Checked[RUS_Y] := True;
        Checked[MAT] := True;
        Checked[BEL_L] := True;
        Checked[RUS_L] := True;
        Checked[FIZR] := True;
        case StrToInt(NumberSpinEdit.Text) of
            1, 2, 3, 4, 5:
            begin
                for I := 0 to OBZ do
                    if I in NOT_FOR_YOUNG then
                        Checked[I] := False;
                Checked[OBZ] := True;
                Checked[CHEL] := True;
                Checked[IZO] := True;
                Checked[MUS] := True;
                Checked[TRUD] := True;
                if StrToInt(NumberSpinEdit.Text) in [3..5] then
                    Checked[IN_Y] := True;
                if StrToInt(NumberSpinEdit.Text) = 5 then
                    Checked[IST] := True;
            end;
            6, 7, 8, 9, 10, 11:
            begin
                for I := 0 to OBZ do
                    if I in NOT_FOR_OLD then
                        Checked[I] := False;
                Checked[IN_Y] := True;
                Checked[BIO] := True;
                Checked[IST] := True;
                Checked[GEOG] := True;
                Checked[INF] := True;
                Checked[IST_BEL] := True;
                if StrToInt(NumberSpinEdit.Text) > 6 then
                begin
                    Checked[CHIM] := True;
                    Checked[FIZ] := True;
                end;
                if StrToInt(NumberSpinEdit.Text) > 8 then
                    Checked[OBSH] := True;
                if StrToInt(NumberSpinEdit.Text) = 11 then
                begin
                    Checked[ASTR] := True;
                    Checked[DPMP] := True;
                end;
                If StrToInt(NumberSpinEdit.Text) = 10 then
                begin
                    Checked[CHER] := True;
                    Checked[DPMP] := True;
                end;
            end;
        end;
    end;
end;

procedure TFormAddClass.StudentsSGKeyPress(Sender: TObject; var Key: Char);
begin
    if ForEditing then
    begin
        NeedSave := True;
        AddClassButton.Enabled := NeedSave;
    end;
    if ((Key < #128) or (Key > #159)) and (Key <> #8) then
        Key := #0;
    if (Length(StudentsSG.Cells[StudentsSG.Col, StudentsSG.Row]) > 18) and Not(Key in [#8, #13]) then
        Key := #0;
    if (Key = 'ё') then
        Key := #0;
end;

procedure TFormAddClass.StudentsSGSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    if (ARow = 0) or (ACol = 0)then
        CanSelect := False;
end;

procedure TFormAddClass.SubjectsCheckListBoxClick(Sender: TObject);
begin
    if ForEditing then
    begin
        NeedSave := true;
        AddClassButton.Enabled := NeedSave;
    end;
end;

procedure TFormAddClass.NumberSpinEditChange(Sender: TObject);
begin
    PutChecks;
end;

procedure TFormAddClass.NumberSpinEditKeyPress(Sender: TObject; var Key: Char);
begin
    Key := #0;
end;

end.
