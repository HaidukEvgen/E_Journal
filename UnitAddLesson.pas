unit UnitAddLesson;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitLesson, Vcl.StdCtrls, Vcl.Menus,
  Vcl.ComCtrls;

type
  TFormAddLesson = class(TForm)
    CaptionLabel: TLabel;
    MainMenu: TMainMenu;
    InformationMenuItem: TMenuItem;
    NumberLabel: TLabel;
    InformationEdit: TEdit;
    HometaskLabel: TLabel;
    HomeTaskEdit: TEdit;
    DateLabel: TLabel;
    DateTimePicker: TDateTimePicker;
    AddButton: TButton;
    function CreateLesson: TLesson;
    procedure FormShow(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure InformationMenuItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAddLesson: TFormAddLesson;

implementation

{$R *.dfm}

var
    Lesson: TLesson;
Const
    HELP = '���������� �����.'#13#10#13#10'��� ���������� ����� ����� ������� ���������� �� ����� (��������, ���������� �� ����� ����), �������� �������, ������� ���� ������ �� ���� �����, ���� ���������� �����.';


procedure TFormAddLesson.AddButtonClick(Sender: TObject);
begin
    if InformationEdit.Text = '' then
        MessageBox(Application.Handle, '�� �� ����� ���������� �� �����.', '���������� �����',
                   MB_ICONERROR)
    else
    if HomeTaskEdit.Text = '' then
         MessageBox(Application.Handle, '�� �� ����� �������� �������.', '���������� �����',
                    MB_ICONERROR)
    else
    begin
        Lesson.NewLesson(DateTimepicker.Date, InformationEdit.Text, HometaskEdit.Text);
        MessageBox(Application.Handle, '���� ������� ��������.', '���������� �����',
                   MB_ICONINFORMATION);
        Self.Close;
    end;

end;

function TFormAddLesson.CreateLesson: TLesson;
var
    Date: TDate;
begin
    Date := Now;
    Lesson.NewLesson(Date, '', '');
    Self.ShowModal;
    Result := Lesson;
end;


procedure TFormAddLesson.FormShow(Sender: TObject);
begin
    DateTimePicker.Date := Now;
end;

procedure TFormAddLesson.InformationMenuItemClick(Sender: TObject);
begin
    MessageBox(Application.Handle, HELP, '�������', MB_ICONINFORMATION);
end;

end.
