unit UnitNote;

interface
type
    TNote = record
        private Note: string[2];
        private StudentID: Int64;
        private LessonID: Int64;
        public function GetNote: string;
        public function GetStudenID: Int64;
        public function GetLessonID: Int64;
        public procedure SetNote(Note: string);
        public procedure SetStudenID(StudentID: Int64);
        public procedure SetLessonID(LessonID: Int64);
    end;

implementation

function TNote.GetNote: string;
begin
    Result := Self.Note;
end;

function TNote.GetStudenID: Int64;
begin
    Result := Self.StudentID;
end;

function TNote.GetLessonID: Int64;
begin
    Result := Self.LessonID;
end;

procedure TNote.SetNote(Note: string);
begin
    Self.Note := Note;
end;

procedure TNote.SetStudenID(StudentID: Int64);
begin
    Self.StudentID := StudentID;
end;

procedure TNote.SetLessonID(LessonID: Int64);
begin
    Self.LessonID := LessonID;
end;

end.
