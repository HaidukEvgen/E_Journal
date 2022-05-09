program E_Journal;

uses
  Vcl.Forms,
  UnitMenu in 'UnitMenu.pas' {FormMenu},
  Vcl.Themes,
  Vcl.Styles,
  UnitAddClass in 'UnitAddClass.pas' {FormAddClass},
  UnitEditJournal in 'UnitEditJournal.pas' {FormEditJournal},
  UnitChooseClass in 'UnitChooseClass.pas' {FormChooseClass},
  UnitChooseJournal in 'UnitChooseJournal.pas' {FormChooseJournal},
  UnitStudent in 'UnitStudent.pas',
  UnitLesson in 'UnitLesson.pas',
  UnitJournal in 'UnitJournal.pas',
  UnitNote in 'UnitNote.pas',
  UnitAddLesson in 'UnitAddLesson.pas' {FormAddLesson};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TFormMenu, FormMenu);
  Application.CreateForm(TFormAddClass, FormAddClass);
  Application.CreateForm(TFormEditJournal, FormEditJournal);
  Application.CreateForm(TFormChooseClass, FormChooseClass);
  Application.CreateForm(TFormChooseJournal, FormChooseJournal);
  Application.CreateForm(TFormAddLesson, FormAddLesson);
  Application.Run;
end.
