package controllers

import (
	"../models"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

type ReadingController struct {
	beego.Controller
}

func (this *ReadingController) Get() {
	u := this.GetSession("user")
	var post models.Post

	post.Slug = this.GetString(":slug")

	o := orm.NewOrm()

	err := o.Read(&post, "Slug")
	if err == nil {
		err = o.Read(post.Category)
	}
	if err == nil {
		err = o.Read(post.Tag)
	}
	if err == nil {
		var categories []models.Category
		_, err = o.QueryTable("category").All(&categories)
		if err == nil {
			this.Data["Categories"] = categories
		}
	}
	if err == nil {
		var tags []models.Tag
		_, err = o.QueryTable("tag").All(&tags)
		if err == nil {
			this.Data["Tags"] = tags
		}
	}

	if err != nil {
		beego.Error(err)
		this.Abort("404")
	}

	if u == nil && post.Status != "Publish" && post.Status != "Friend" {
		this.Abort("404")
	}

	this.Data["Post"] = post
	this.Data["SiteTitle"] = beego.AppConfig.String("SiteTitle")
	this.Data["SiteDesc"] = beego.AppConfig.String("SiteDesc")
	this.Data["SiteCommentConfig"] = beego.AppConfig.String("SiteCommentConfig")
	this.Data["CDN"] = beego.AppConfig.String("CDN")

	if u == nil && this.GetSession("pass") == nil {
		this.Data["ForbidFriend"] = true
	} else {
		this.Data["ForbidFriend"] = false
	}

	this.TplName = "reading.tpl"
}

func (this *ReadingController) Post() {
	pass := this.GetString("pass")
	if pass == beego.AppConfig.String("FriendPassword") {
		this.SetSession("pass", true)
	}
	this.Redirect("/reading/"+this.GetString(":slug")+".html", 302)
}
