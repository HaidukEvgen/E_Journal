unit UnitMenu;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
    Vcl.Menus, Vcl.StdCtrls, System.Generics.Collections;

type
    TFormMenu = class(TForm)
        Image: TImage;
        MainMenu: TMainMenu;
        InformationMenuItem: TMenuItem;
        AboutDeveloperMenuItem: TMenuItem;
        AddClassButton: TButton;
        EditClassButton: TButton;
        ViewJournalButton: TButton;
        EditJournalButton: TButton;
        procedure AboutDeveloperMenuItemClick(Sender: TObject);
        procedure InformationMenuItemClick(Sender: TObject);
        procedure AddClassButtonClick(Sender: TObject);
        procedure EditClassButtonClick(Sender: TObject);
        procedure ViewJournalButtonClick(Sender: TObject);
        procedure EditJournalButtonClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure CheckClasses();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenu: TFormMenu;

implementation

{$R *.dfm}

uses UnitAddClass, UnitEditClass, UnitViewJournal, UnitEditJournal,
  UnitChooseClass, UnitChooseJournal;

const
    HELP = 'Программное средство "Электронный журнал".'#13#10#13#10'В данной программе можно создавать учебные классы, редактировать классы, просматривать и редактировать электронные журналы классов.';

procedure TFormMenu.AboutDeveloperMenuItemClick(Sender: TObject);
var
    Str1, Str2: string;
begin
    Str1 := 'Данная программа разработана студентом БГУИР группы 151002';
    Str2 := 'Гайдуком Евгением Денисовичем в рамках курсового проекта';
    MessageBox(Application.Handle, PChar(Str1+ sLineBreak + Str2), 'О разработчике', MB_ICONINFORMATION);
end;

procedure TFormMenu.CheckClasses();
var
    Sr: TSearchRec;
    Amount: Integer;
begin
    if FindFirst('E_Journal/*', faDirectory, Sr) = 0 then
        repeat
            if (Sr.Name <> '') and (Sr.Name <> '.') and (Sr.Name <> '..') then
                if Sr.Attr = faDirectory then
                    Inc(Amount);
        until (FindNext(sr) <> 0);
    FindClose(sr);
    if Amount = 0 then
    begin
        ViewJournalButton.Enabled := False;
        EditJournalButton.Enabled := False;
        EditClassButton.Enabled := False;
    end
    else
    begin
        ViewJournalButton.Enabled := True;
        EditJournalButton.Enabled := True;
        EditClassButton.Enabled := True;
    end;
end;

procedure TFormMenu.AddClassButtonClick(Sender: TObject);
begin
    FormAddClass.ForEditing := False;
    FormAddClass.ShowModal();
    CheckClasses;
end;

procedure TFormMenu.EditClassButtonClick(Sender: TObject);
begin
    FormChooseClass := TFormChooseClass.Create(Self);
    FormChooseClass.ShowModal();
    FormChooseClass.Free;
    CheckClasses;
end;

procedure TFormMenu.EditJournalButtonClick(Sender: TObject);
begin
    with FormChooseJournal do
    begin
        FillClassComboBox;
        Caption := 'Редактирование журнала';
        ConfirmButton.Caption := 'Редактировать журнал';
        ForEditing := True;
        Showmodal();
    end;
end;

Procedure MakeDir();
Begin
    if not(DirectoryExists('E_Journal')) then
        CreateDir('E_Journal');
    if not(DirectoryExists('E_Journal')) then
        CreateDir('E_Journal/classes');
End;

procedure TFormMenu.FormCreate(Sender: TObject);
begin
    MakeDir;
    CheckClasses;
end;

procedure TFormMenu.InformationMenuItemClick(Sender: TObject);
begin
    MessageBox(Application.Handle, HELP, 'Справка', MB_ICONINFORMATION);
end;

procedure TFormMenu.ViewJournalButtonClick(Sender: TObject);
begin
    with FormChooseJournal do
    begin
        Caption := 'Просмотр журнала';
        ConfirmButton.Caption := 'Просмотреть журнал';
        ForEditing := False;
        ShowModal();
    end;
end;

end.
