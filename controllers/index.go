package controllers

import (
	"../models"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

type MainController struct {
	beego.Controller
}

func (this *MainController) Get() {
	var categories []*models.Category

	o := orm.NewOrm()
	_, err := o.QueryTable("category").All(&categories)
	if err != nil {
		beego.Error(err)
	}

	this.Data["Categories"] = categories

	this.Data["SiteTitle"] = beego.AppConfig.String("SiteTitle")
	this.Data["SiteDesc"] = beego.AppConfig.String("SiteDesc")
	this.TplNames = "index.tpl"
}
