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
	var post models.Post

	o := orm.NewOrm()
	err := o.QueryTable("post").Filter("Slug", "main").RelatedSel().One(&post)
	if err != nil {
		post.Content = "no main page"
	}

	var categories []models.Category
	_, err = o.QueryTable("category").All(&categories)
	if err == nil {
		this.Data["Categories"] = categories
	}

	var tags []models.Tag
	_, err = o.QueryTable("tag").All(&tags)
	if err == nil {
		this.Data["Tags"] = tags
	}

	this.Data["Post"] = post

	this.Data["SiteTitle"] = beego.AppConfig.String("SiteTitle")
	this.Data["SiteDesc"] = beego.AppConfig.String("SiteDesc")
	this.Data["CDN"] = beego.AppConfig.String("CDN")
	this.TplNames = "reading.tpl"

}
