/*
 * Copyright 2022 CloudWeGo Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package pack

import (
	"github.com/cloudwego/hertz-examples/bizdemo/hertz_gorm/biz/model"
	"github.com/cloudwego/hertz-examples/bizdemo/hertz_gorm/biz/model/student_gorm"
)

// Students Convert model.Student list to student_gorm.Student list
func Students(models []*model.Student) []*student_gorm.Student {
	users := make([]*student_gorm.Student, 0, len(models))
	for _, m := range models {
		if u := Student(m); u != nil {
			users = append(users, u)
		}
	}
	return users
}

// Student Convert model.Student to student_gorm.Student
func Student(model *model.Student) *student_gorm.Student {
	if model == nil {
		return nil
	}
	return &student_gorm.Student{
		StudentID: int64(model.ID),
		Name:      model.Name,
		Gender:    student_gorm.Gender(model.Gender),
		Age:       model.Age,
		Introduce: model.Introduce,
	}
}
