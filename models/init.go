package models

import (
	"log"
	"os"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/mattn/go-sqlite3"
)

/*
import (
	_ "github.com/go-sql-driver/mysql"
	"log"
)

func convert() {
	// convert
	orm.RegisterDataBase("from", "mysql", "root:root@/orm_db2?charset=utf8")
	orm.RegisterDataBase("to", "sqlite3", "./orm_db2.db")

	from := orm.NewOrm()
	from.Using("from")

	to := orm.NewOrm()
	to.Using("to")

	List := make([]Post, 0, 100)
	_, err := from.QueryTable("post").OrderBy("id").All(&List)
	if err != nil {
		log.Fatalln("QueryFailed", err)
	}
	successNums, err := to.InsertMulti(len(List), List)
	if err != nil || int(successNums) != len(List) {
		log.Fatalln("InsertMulti failed", err, successNums, len(List))
	}

	log.Fatalln("Convert Succ")
	// end convert
}
*/

func init() {
	target := beego.AppConfig.String("database")

	// orm.RegisterDriver("sqlite", orm.DR_Sqlite)
	orm.RegisterDataBase("default", "sqlite3", target)

	orm.RegisterModel(new(Tag), new(User), new(Category))
	orm.RegisterModel(new(Resource))
	orm.RegisterModel(new(Post))

	// ./keeper orm syncdb --help
	// ./keeper orm syncdb -force=true -v
	orm.RunCommand()

	// ./keeper initdb
	if len(os.Args) < 2 || os.Args[1] != "initdb" {
		return
	}
	user := User{}
	user.Email = "init@fancymore.com"
	user.Name = "init"
	user.Password = "ebb2fb8bdd8f9e797dd5f7250d347f5d"
	user.Privilege = "super"
	o := orm.NewOrm()
	_, err := o.Insert(&user)
	if err != nil {
		log.Fatalln("insert init user failed:", err)
	} else {
		log.Fatalln("insert init user succ!")
	}
}
