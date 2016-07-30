package manager

import (
	"fmt"
	"os"
	"time"

	"../../models"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego/validation"
)

type ResourceController struct {
	beego.Controller
}

func (this *ResourceController) Post() {
	echo := new(ResourceEcho)
	this.Data["json"] = echo
	defer this.ServeJSON()

	u := this.GetSession("user")
	if u == nil || u.(models.User).Privilege != "super" {
		echo.Code = ERR_AUTH
		echo.Message = "you must login first!"
		return
	}

	echo.One.Name = this.GetString("Name")
	echo.One.Post = new(models.Post)

	var err error
	echo.One.Post.Id, err = this.GetInt64("PostId")
	if err != nil || echo.One.Post.Id == 0 {
		echo.Code = ERR_INPUT
		echo.Message = "post id error"
	}

	valid := validation.Validation{}
	valid.MinSize(echo.One.Name, 2, "name")
	if valid.HasErrors() {
		echo.Code = ERR_INPUT
		echo.Message = valid.Errors[0].Key + " : " + valid.Errors[0].Message
		return
	}

	path := fmt.Sprintf("upload/%d", time.Now().Year())
	err = os.MkdirAll(path, 0766)
	if err != nil {
		echo.Code = ERR_KEEP_FILE
		echo.Message = err.Error()
		return
	}

	echo.One.ReqURI = fmt.Sprintf("/keep/%d/%d_%s", time.Now().Year(), echo.One.Id, echo.One.Name)
	echo.One.Path = fmt.Sprintf("%s/%d_%s", path, echo.One.Id, echo.One.Name)

	o := orm.NewOrm()
	err = o.Begin()
	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
		return
	}

	echo.One.Id, err = o.Insert(&echo.One)

	if err == nil {
		err = this.SaveToFile("file", echo.One.Path)
	}

	if err != nil {
		echo.Code = ERR_SQL
		echo.Message = err.Error()
		o.Rollback()
	} else {
		o.Commit()
	}
}
