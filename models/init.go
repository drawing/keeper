package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/mattn/go-sqlite3"
)

func init() {
	target := beego.AppConfig.String("database")

	orm.RegisterDriver("sqlite", orm.DR_Sqlite)
	orm.RegisterDataBase("default", "sqlite3", target)

	orm.RegisterModel(new(Tag), new(User), new(Category))
	orm.RegisterModel(new(Resource))
	orm.RegisterModel(new(Post))

	// ./keeper orm syncdb --help
	// ./keeper orm syncdb -force=true -v
	orm.RunCommand()
}
