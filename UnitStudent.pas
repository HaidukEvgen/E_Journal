unit UnitStudent;

interface

uses
    DateUtils, SysUtils, StrUtils;

type
    TStudent = record
        private Name: string[20];
        private LastName: string[20];
        private ID: Int64;
        public procedure NewStudent(StudentName, StudentLastName: string);
        function GetName: string;
        function GetLastName: string;
        function GetID: Int64;
    end;

implementation

procedure TStudent.NewStudent(StudentName: string; StudentLastName: string);
begin
    Self.Name := StudentName;
    Self.LastName := StudentLastName;
    Self.ID := DateTimeToUnix(Now) + Random(100000);
end;

function TStudent.GetName: string;
begin
    Result := Self.Name;
end;

function TStudent.GetLastName: string;
begin
    Result := Self.LastName;
end;

function TStudent.GetID: Int64;
begin
    Result := Self.ID;
end;

end.






