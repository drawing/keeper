package manager

import (
	"../../models"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego/validation"
)

type TagsController struct {
	beego.Controller
}

func (this *TagsController) Get() {
	echo := new(TagEcho)
	this.Data["json"] = echo
	defer this.ServeJson()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	o := orm.NewOrm()
	_, err := o.QueryTable("tag").All(&echo.List)
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	}
}

func (this *TagsController) Post() {
	echo := new(TagEcho)
	this.Data["json"] = echo
	defer this.ServeJson()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.One.Name = this.GetString("Name")
	echo.One.Slug = this.GetString("Slug")
	echo.One.Desc = this.GetString("Desc")

	valid := validation.Validation{}
	valid.MinSize(echo.One.Name, 3, "name")
	valid.MinSize(echo.One.Slug, 3, "custom url")
	valid.MinSize(echo.One.Desc, 3, "desc")

	if valid.HasErrors() {
		echo.Code = ERR_INPUT
		echo.Message = valid.Errors[0].Key + ":" + valid.Errors[0].Message
		return
	}

	o := orm.NewOrm()
	Id, err := o.Insert(&echo.One)
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	} else {
		echo.One.Id = Id
	}
}

func (this *TagsController) Put() {
	echo := new(TagEcho)
	this.Data["json"] = echo
	defer this.ServeJson()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.One.Id, _ = this.GetInt("Id")
	echo.One.Name = this.GetString("Name")
	echo.One.Slug = this.GetString("Slug")
	echo.One.Desc = this.GetString("Desc")

	valid := validation.Validation{}
	valid.MinSize(echo.One.Name, 3, "name")
	valid.MinSize(echo.One.Slug, 3, "custom url")
	valid.MinSize(echo.One.Desc, 3, "desc")

	if valid.HasErrors() {
		echo.Code = ERR_INPUT
		echo.Message = valid.Errors[0].Key + " : " + valid.Errors[0].Message
		return
	}

	o := orm.NewOrm()
	_, err := o.Update(&echo.One)
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	}
}
