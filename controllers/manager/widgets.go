package manager

import (
	"../../models"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego/validation"
)

type WidgetController struct {
	beego.Controller
}

func (this *WidgetController) Get() {
	echo := new(WidgetEcho)
	this.Data["json"] = echo
	defer this.ServeJson()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.Family, _ = this.GetString(":family")

	o := orm.NewOrm()
	qs := o.QueryTable("post").Filter("family", echo.Family)

	cnt, err = qs.Count()
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
		this.Abort("503")
	}

	if cnt == 1 {
		var one models.Widget
		err = qs.One(&one)
		if err != nil {
			echo.Code = ERR_SQL
			echo.Message = err.Error()
			this.Abort("503")
		}

		// decode
	}
}

func (this *WidgetController) Put() {
	echo := new(WidgetEcho)
	this.Data["json"] = echo
	defer this.ServeJson()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.Family = this.GetString("Family")

	var one models.Widget
	one.Family = echo.Family

	o := orm.NewOrm()
	_, err := o.Update(&one)
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	}
}