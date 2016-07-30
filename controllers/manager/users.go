package manager

import (
	"regexp"

	"../../models"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego/validation"
)

type UsersController struct {
	beego.Controller
}

func (this *UsersController) Get() {
	echo := new(UserEcho)
	this.Data["json"] = echo
	defer this.ServeJSON()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	o := orm.NewOrm()
	// real user only one, so do not need pagination
	_, err := o.QueryTable("user").All(&echo.List)
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	}
}

func (this *UsersController) Post() {
	echo := new(UserEcho)
	this.Data["json"] = echo
	defer this.ServeJSON()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.One.Name = this.GetString("Name")
	echo.One.Email = this.GetString("Email")
	echo.One.Privilege = this.GetString("Privilege")
	echo.One.Password = this.GetString("Password")

	valid := validation.Validation{}
	valid.MinSize(echo.One.Name, 3, "name")
	valid.Email(echo.One.Email, "email")
	valid.Match(echo.One.Privilege, regexp.MustCompile("(super|friend)"), "privilege")
	valid.MinSize(echo.One.Password, 6, "password")

	if valid.HasErrors() {
		echo.Code = ERR_INPUT
		echo.Message = valid.Errors[0].Key + " : " + valid.Errors[0].Message
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

func (this *UsersController) Put() {
	echo := new(UserEcho)
	this.Data["json"] = echo
	defer this.ServeJSON()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.One.Id, _ = this.GetInt64("Id")
	echo.One.Name = this.GetString("Name")
	echo.One.Email = this.GetString("Email")
	echo.One.Privilege = this.GetString("Privilege")
	echo.One.Password = this.GetString("Password")

	valid := validation.Validation{}
	valid.MinSize(echo.One.Name, 3, "name")
	valid.Email(echo.One.Email, "email")
	valid.Match(echo.One.Privilege, regexp.MustCompile("(super|friend)"), "privilege")
	valid.MinSize(echo.One.Password, 6, "password")

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
