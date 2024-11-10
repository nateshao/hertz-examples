// refer to  https://www.cloudwego.io/zh/docs/hertz/tutorials/toolkit/toolkit/

namespace go student_gorm
namespace py student_gorm
namespace java student_gorm

enum Code {
     Success         = 1
     ParamInvalid    = 2
     DBErr           = 3
}

enum Gender {
    Unknown = 0
    Male    = 1
    Female  = 2
}

struct Student {
    1: i64 student_id
    2: string name
    3: Gender gender
    4: i64    age
    5: string introduce
}

struct CreateStudentRequest{
    1: string name      (api.body="name", api.form="name",api.vd="(len($) > 0 && len($) < 100)")
    2: Gender gender    (api.body="gender", api.form="gender",api.vd="($ == 1||$ == 2)")
    3: i64    age       (api.body="age", api.form="age",api.vd="$>0")
    4: string introduce (api.body="introduce", api.form="introduce",api.vd="(len($) > 0 && len($) < 1000)")
}

struct CreateStudentResponse{
   1: Code code
   2: string msg
}

struct QueryStudentRequest{
   1: optional string Keyword (api.body="keyword", api.form="keyword",api.query="keyword")
   2: i64 page (api.body="page", api.form="page",api.query="page",api.vd="$ > 0")
   3: i64 page_size (api.body="page_size", api.form="page_size",api.query="page_size",api.vd="($ > 0 || $ <= 100)")
}

struct QueryStudentResponse{
   1: Code code
   2: string msg
   3: list<Student> students
   4: i64 total
}

struct DeleteStudentRequest{
   1: i64    student_id   (api.path="student_id",api.vd="$>0")
}

struct DeleteStudentResponse{
   1: Code code
   2: string msg
}

struct UpdateStudentRequest{
    1: i64    student_id   (api.path="student_id",api.vd="$>0")
    2: string name      (api.body="name", api.form="name",api.vd="(len($) > 0 && len($) < 100)")
    3: Gender gender    (api.body="gender", api.form="gender",api.vd="($ == 1||$ == 2)")
    4: i64    age       (api.body="age", api.form="age",api.vd="$>0")
    5: string introduce (api.body="introduce", api.form="introduce",api.vd="(len($) > 0 && len($) < 1000)")
}

struct UpdateStudentResponse{
   1: Code code
   2: string msg
}


service StudentService {
   UpdateStudentResponse UpdateUser(1:UpdateStudentRequest req)(api.post="/v1/student/update/:student_id")
   DeleteStudentResponse DeleteUser(1:DeleteStudentRequest req)(api.post="/v1/student/delete/:student_id")
   QueryStudentResponse  QueryUser(1: QueryStudentRequest req)(api.post="/v1/student/query/")
   CreateStudentResponse CreateUser(1:CreateStudentRequest req)(api.post="/v1/student/create/")
}