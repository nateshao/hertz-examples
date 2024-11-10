package mysql

import "github.com/cloudwego/hertz-examples/bizdemo/hertz_gorm/biz/model"

func CreateStudent(student []*model.Student) error {
	return DB.Create(student).Error
}

func DeleteStudent(studentId int64) error {
	return DB.Where("id = ?", studentId).Delete(&model.Student{}).Error
}

func UpdateStudent(student *model.Student) error {
	return DB.Updates(student).Error
}

func QueryStudent(keyword *string, page, pageSize int64) ([]*model.Student, int64, error) {
	db := DB.Model(model.Student{})
	if keyword != nil && len(*keyword) != 0 {
		db.Where(DB.Or("name like ?", "%"+*keyword+"%").
			Or("introduce like ?", "%"+*keyword+"%"))
	}
	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var res []*model.Student
	if err := db.Limit(int(pageSize)).Offset(int(pageSize * (page - 1))).Find(&res).Error; err != nil {
		return nil, 0, err
	}
	return res, total, nil
}
