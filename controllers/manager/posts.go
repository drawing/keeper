package manager

import (
	"encoding/json"
	"regexp"

	"../../models"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego/validation"
)

type PostsController struct {
	beego.Controller
}

func (this *PostsController) Get() {
	var limit int64 = 15

	echo := new(PostEcho)
	this.Data["json"] = echo
	defer this.ServeJSON()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.CurPage, _ = this.GetInt64("page")
	query_status := this.GetString("status")

	o := orm.NewOrm()
	qs := o.QueryTable("post")

	if query_status != "" {
		qs = qs.Filter("Status", query_status)
	}

	qs = qs.OrderBy("-id")

	var err error
	echo.Count, err = qs.Count()
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
		return
	}

	echo.PageNum = (echo.Count-1)/limit + 1

	_, err = qs.Limit(limit, echo.CurPage*limit).All(&echo.List,
		"Id", "Title", "Slug", "CreateDate", "Status")
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	}
}

func (this *PostsController) Post() {
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

	author := u.(models.User)
	echo.One.Author = &author

	Id, err := o.Insert(&echo.One)
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
	} else {
		echo.One.Id = Id
	}
}
