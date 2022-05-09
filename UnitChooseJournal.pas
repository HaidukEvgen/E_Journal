unit UnitChooseJournal;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
    TFormChooseJournal = class(TForm)
        InfoLabel: TLabel;
        ClassLabel: TLabel;
        QuaterLabel: TLabel;
        LessonLabel: TLabel;
        ConfirmButton: TButton;
        ClassComboBox: TComboBox;
        QuaterComboBox: TComboBox;
        LessonComboBox: TComboBox;
        MainMenu: TMainMenu;
        InformationMenuItem: TMenuItem;
        PopupMenu: TPopupMenu;
        procedure ConfirmButtonClick(Sender: TObject);
        procedure ClassComboBoxChange(Sender: TObject);
        procedure FillQuaterComboBox;
        procedure FillLessonComboBox;
        procedure FillClassComboBox;
        procedure LessonComboBoxChange(Sender: TObject);
        procedure QuaterComboBoxChange(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure InformationMenuItemClick(Sender: TObject);
        procedure FormShow(Sender: TObject);

  private

  public
    ForEditing: Boolean;
  end;

var
  FormChooseJournal: TFormChooseJournal;

implementation

{$R *.dfm}

uses UnitViewJournal, UnitEditJournal, UnitJournal;

procedure TFormChooseJournal.FillClassComboBox;
var
    sr: TSearchRec;
begin
    ClassComboBox.Clear;
    if FindFirst('E_Journal/*', faDirectory, sr) = 0 then
        repeat
            if (sr.Name <> '') and (sr.Name <> '.') and (sr.Name <> '..') then
                if sr.Attr = faDirectory then
                    ClassComboBox.Items.Add(sr.Name);
        until (FindNext(sr) <> 0);
    FindClose(sr);
end;

procedure TFormChooseJournal.FillQuaterComboBox;
var
    sr: TSearchRec;
begin
    if FindFirst('E_Journal/' + ClassComboBox.Text + '/journal/*', faDirectory, sr) = 0 then
        repeat
            if (sr.Name <> '') and (sr.Name <> '.') and (sr.Name <> '..') then
                if sr.Attr = faDirectory then
                    QuaterComboBox.Items.Add(sr.Name);
        until (FindNext(sr) <> 0);
    FindClose(sr);
end;

procedure TFormChooseJournal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    ClassComboBoxChange(Sender);
end;

procedure TFormChooseJournal.FormCreate(Sender: TObject);
begin
    FillClassComboBox;
    QuaterComboBox.Enabled := false;
    QuaterComboBox.Text := '';
    LessonComboBox.Enabled := false;
    LessonComboBox.Text := '';
    ConfirmButton.Enabled := false;
end;

procedure TFormChooseJournal.FormShow(Sender: TObject);
begin
    ClassComboBox.Text := '';
end;

procedure TFormChooseJournal.InformationMenuItemClick(Sender: TObject);
Const
    HELP = 'В данном окне вам необходимо выбрать журнал класса, необходмую четверть и предмет, чтобы впоследствии работать с ними. Это удобно сделать, воспользовавшись выпадающими списками, в которых содержатся все возможные варианты.';
begin
    MessageBox(Application.Handle, HELP, 'Справка', MB_ICONINFORMATION);
end;

procedure TFormChooseJournal.LessonComboBoxChange(Sender: TObject);
begin
    ConfirmButton.Enabled := false;
    if LessonComboBox.Items.IndexOf(LessonComboBox.Text) <> -1 then
    begin
        ConfirmButton.Enabled := true;
    end;
end;

procedure TFormChooseJournal.QuaterComboBoxChange(Sender: TObject);
begin
    LessonComboBox.Items.Clear;
    LessonComboBox.Enabled := false;
    LessonComboBox.Text := '';
    ConfirmButton.Enabled := false;
    if QuaterComboBox.Items.IndexOf(QuaterComboBox.Text) <> -1 then
    begin
        FillLessonComboBox;
        LessonComboBox.Enabled := true;
    end;

end;

procedure TFormChooseJournal.FillLessonComboBox;
var
    sr: TSearchRec;
begin
    if FindFirst('E_Journal/' + ClassComboBox.Text + '/journal/' + QuaterComboBox.Text + '/*',
                 faDirectory, sr) = 0 then
        repeat
            if (sr.Name <> '') and (sr.Name <> '.') and (sr.Name <> '..') then
                if sr.Attr = faDirectory then
                    LessonComboBox.Items.Add(sr.Name);
        until (FindNext(sr) <> 0);
    FindClose(sr);
end;



procedure TFormChooseJournal.ClassComboBoxChange(Sender: TObject);
begin
    LessonComboBox.Items.Clear;
    LessonComboBox.Enabled := false;
    LessonComboBox.Text := '';
    QuaterComboBox.Items.Clear;
    QuaterComboBox.Enabled := false;
    QuaterComboBox.Text := '';
    ConfirmButton.Enabled := false;
    if ClassComboBox.Items.IndexOf(ClassComboBox.Text) <> -1 then
    begin
        FillQuaterComboBox;
        QuaterComboBox.Enabled := true;
    end;
end;

procedure TFormChooseJournal.ConfirmButtonClick(Sender: TObject);
var
    Journal: TJournal;
    JournalFile, StudentsFile: TextFile;
begin
    Journal.SetClassName(ClassComboBox.Text);
    Journal.SetLesson(LessonComboBox.Text);
    Journal.SetQuater(QuaterComboBox.Text);
    if ForEditing then
    begin
        FormEditJournal := TFormEditJournal.Create(Self);
        FormEditJournal.Journal := Journal;
        FormEditJournal.ForEditing := True;
        FormEditJournal.Caption := 'Редактирование журнала';
        FormEditJournal.CaptionLabel.Caption := 'Редактирование журнала';
        AssignFile(StudentsFile, 'E_Journal/' + Journal.GetClassName + '/students.students');
        Reset(StudentsFile);
        if Eof(StudentsFile) then
        begin
            CloseFile(StudentsFile);
            MessageBox(Application.Handle, 'В классе нет учеников.', 'Редактирование журнала', MB_ICONERROR);
        end
        else
        begin
            CloseFile(StudentsFile);
            FormEditJournal.ShowModal;
            FormEditJournal.Destroy;
        end;
    end
    else
    begin
        FormEditJournal := TFormEditJournal.Create(Self);
        FormEditJournal.Journal := Journal;
        FormEditJournal.ForEditing := False;
        FormEditJournal.Caption := 'Просмотр журнала';
        FormEditJournal.CaptionLabel.Caption := 'Просмотр журнала';
        AssignFile(JournalFile, 'E_Journal/' + Journal.GetClassName + '/journal/' +
                   Journal.GetQuater + '/' + Journal.GetLesson + '/lessons.lessons');
        Reset(JournalFile);
        if Eof(JournalFile)  then
        begin
            CloseFile(JournalFile);
            MessageBox(Application.Handle, 'У класса еще не было уроков по этому предмету.', 'Журнал класса', MB_ICONERROR);
        end
        else
        begin
            CloseFile(JournalFile);
            FormEditJournal.ShowModal;
            FormEditJournal.Destroy;
        end;
    end;
end;

end.
