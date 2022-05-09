unit UnitLesson;

interface

uses
    DateUtils, SysUtils;

type
    TLesson = record
        private Date: TDate;
        private ID: Int64;
        private Info: string[100];
        private HomeWork: string[50];
        public procedure NewLesson(Date: TDate; Info, HomeWork: string);
        public function GetID: Int64;
        public function GetDate: TDate;
        public function GetInfo: string;
        public function GetHomeWork: string;
    End;

implementation

procedure TLesson.NewLesson(Date: TDate; Info, HomeWork: string);
begin
    Self.Date := Date;
    Self.ID := DateTimeToUnix(Now);
    Self.Info := Info;
    Self.HomeWork := HomeWork;
end;

function TLesson.GetDate: TDate;
begin
    Result := Self.Date;
end;

function TLesson.GetID: Int64;
begin
    Result := Self.ID;
end;

function TLesson.GetInfo: string;
begin
    Result := Self.Info;
end;

function TLesson.GetHomeWork: string;
begin
    Result := Self.HomeWork;
end;

end.

