package models

import (
	"time"
)

type Post struct {
	Id         int64     `orm:"auto"`
	Title      string    `orm:"unique"`
	Slug       string    `orm:"index;unique"`
	CreateDate time.Time `orm:"auto_now_add;type(datetime)"`
	UpdateDate time.Time `orm:"auto_now;type(datetime)"`
	Category   *Category `orm:"rel(fk)"`
	Tag        *Tag      `orm:"rel(fk)"`
	Author     *User     `orm:"rel(fk)"`
	Status     string
	Content    string      `orm:"type(text)"`
	Resource   []*Resource `orm:"reverse(many)"`
}

type Category struct {
	Id   int64  `orm:"auto"`
	Name string `orm:"unique"`
	Slug string `orm:"index;unique"`
	Desc string
}

type Tag struct {
	Id   int64  `orm:"auto"`
	Name string `orm:"unique"`
	Slug string `orm:"index;unique"`
	Desc string
}
