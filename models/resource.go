package models

type Resource struct {
	Id     int64 `orm:"auto"`
	Name   string
	Post   *Post  `orm:"index;rel(fk)"`
	ReqURI string `orm:"index;unique"`
	Path   string `orm:"unique"`
}
