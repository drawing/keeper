package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/mattn/go-sqlite3"
)

func init() {
	driver := beego.AppConfig.String("sqldriver")
	target := beego.AppConfig.String("sqltarget")

	if driver == "mysql" {
		orm.RegisterDriver("mysql", orm.DR_MySQL)
		// root:root@/orm_test?charset=utf8
		orm.RegisterDataBase("default", "mysql", target)
	} else {
		orm.RegisterDriver("sqlite", orm.DR_Sqlite)
		orm.RegisterDataBase("default", "sqlite3", target)
	}

	orm.RegisterModel(new(Tag), new(User), new(Category))
	orm.RegisterModel(new(Resource))
	orm.RegisterModel(new(Post))

	// ./keepnow orm syncdb --help
	// ./keepnow orm syncdb -force=true -v
	orm.RunCommand()
}
