package manager

import (
	"encoding/json"
	"regexp"

	"../../models"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego/validation"
)

type PostController struct {
	beego.Controller
}

func (this *PostController) Get() {
	echo := new(PostEcho)
	this.Data["json"] = echo
	defer this.ServeJSON()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.One.Id, _ = this.GetInt64(":id")

	o := orm.NewOrm()
	err := o.QueryTable("post").Filter("Id", echo.One.Id).RelatedSel().One(&echo.One)
	if err == nil {
		_, err = o.LoadRelated(&echo.One, "Resource")
	}
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	}
}

func (this *PostController) Put() {
	echo := new(PostEcho)
	this.Data["json"] = echo
	defer this.ServeJSON()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	err := json.Unmarshal(this.Ctx.Input.RequestBody, &echo.One)
	if err != nil {
		echo.Code = ERR_INPUT
		echo.Message = err.Error()
		return
	}

	valid := validation.Validation{}
	valid.MinSize(echo.One.Title, 2, "title")
	valid.MinSize(echo.One.Slug, 3, "slug")
	valid.Match(echo.One.Status, regexp.MustCompile("(Publish|Draft|Secret|Friend)"), "status")
	valid.MinSize(echo.One.Content, 3, "content")

	if valid.HasErrors() {
		echo.Code = ERR_INPUT
		echo.Message = valid.Errors[0].Key + " : " + valid.Errors[0].Message
		return
	}

	o := orm.NewOrm()

	echo.One.Id, _ = this.GetInt64(":id")
	author := u.(models.User)
	echo.One.Author = &author

	_, err = o.Update(&echo.One)
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	}
}
