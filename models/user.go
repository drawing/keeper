package models

type User struct {
	Id        int64  `orm:"auto"`
	Name      string `orm:"index;unique"`
	Email     string `orm:"index;unique"`
	Password  string
	Privilege string
}
