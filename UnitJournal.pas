unit UnitJournal;

interface

type
    TJournal = record
        private ClassName: string;
        private Lesson: string;
        private Quater: string;
        public function GetClassName: string;
        public function GetLesson: string;
        public function GetQuater: string;
        public procedure SetClassName(ClassName: string);
        public procedure SetLesson(Lesson: string);
        public procedure SetQuater(Quater: string);
    end;

implementation

function TJournal.GetClassName: String;
begin
    Result := Self.ClassName;
end;

function TJournal.GetLesson: String;
begin
    Result := Self.Lesson;
end;

function TJournal.GetQuater: String;
begin
    Result := Self.Quater;
end;

procedure TJournal.SetClassName(ClassName: string);
begin
    Self.ClassName := ClassName;
end;

procedure TJournal.SetLesson(Lesson: string);
begin
    Self.Lesson := Lesson;
end;

procedure TJournal.SetQuater(Quater: string);
begin
    Self.Quater := Quater;
end;

end.

