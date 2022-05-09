unit UnitChooseClass;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
    Vcl.Samples.Spin;

type
    TFormChooseClass = class(TForm)
        MainMenu: TMainMenu;
        InformationMenuItem: TMenuItem;
        InfoLabel: TLabel;
        ClassLabel: TLabel;
        ConfirmButton: TButton;
        ComboBox: TComboBox;
        PopupMenu: TPopupMenu;
        procedure ConfirmButtonClick(Sender: TObject);
        procedure FillCBOX();
        procedure FormCreate(Sender: TObject);
        procedure InformationMenuItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    FormChooseClass: TFormChooseClass;

implementation

{$R *.dfm}

uses UnitEditClass, UnitAddClass;

procedure TFormChooseClass.FillCBOX();
var
    sr: TSearchRec;
begin
    if FindFirst('E_Journal/*', faDirectory, sr) = 0 then
        repeat
            If (sr.Name <> '') and (sr.Name <> '.') and (sr.Name <> '..') then
                if sr.Attr = faDirectory then
                    ComboBox.Items.Add(sr.Name);
        until (FindNext(sr) <> 0);
    FindClose(sr);
end;

procedure TFormChooseClass.FormCreate(Sender: TObject);
begin
    FillCBOX;
end;

procedure TFormChooseClass.InformationMenuItemClick(Sender: TObject);
const
    HELP = '¬ данном окне вам необходимо выбрать класс дл€ редактировани€. Ёто удобно сделать, воспользовавшись выпадающим списком, в котором содержатс€ все созданные классы.';
begin
    MessageBox(Application.Handle, HELP, '—правка', MB_ICONINFORMATION);
end;

procedure TFormChooseClass.ConfirmButtonClick(Sender: TObject);
var
    IsCorrect: Boolean;
begin
    IsCorrect := true;
    if ComboBox.Text = '' then
    begin
        MessageBox(Application.Handle, '¬ы не выбрали класс дл€ редактировани€.', '–едактирование класса', MB_ICONERROR);
        IsCorrect := false;
    end;
    if IsCorrect and not DirectoryExists('E_Journal/' + ComboBox.Text) then
    begin
        MessageBox(Application.Handle, '¬ыбранного класса не существует.', '–едактирование класса', MB_ICONERROR);
        IsCorrect := false;
    end;
    if IsCorrect then
    begin
        with FormAddCLass do
        begin
            ForEditing := True;
            ClassName := ComboBox.Text;
            ShowModal;
        end;
        Self.Close;
    end;
end;

end.
