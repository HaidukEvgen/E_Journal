unit UnitViewJournal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Menus,
  UnitLesson, UnitNote, UnitStudent, UnitJournal, System.Generics.Collections;

type
  TFormViewJournal = class(TForm)
    RecordSG: TStringGrid;
    Label1: TLabel;
    MainMenu: TMainMenu;
    InformationMenuItem: TMenuItem;
    private
        StudentList: TList<TStudent>;
        LessonsList: TList<TLesson>;
        NotesList: TList<TNote>;
    public
        Journal: TJournal;

  end;

var
  FormViewJournal: TFormViewJournal;

implementation

{$R *.dfm}

end.
