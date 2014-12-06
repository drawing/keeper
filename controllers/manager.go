package controllers

import (
	"../models"

	"github.com/astaxie/beego"
)

type ManagerController struct {
	beego.Controller
}

func (this *ManagerController) Get() {
	page := this.GetString(":page")

	if page == "login" {
		u := this.GetSession("user")
		if u != nil {
			this.DelSession("user")
		}
		this.Data["SiteTitle"] = beego.AppConfig.String("SiteTitle")
		this.Data["SiteDesc"] = beego.AppConfig.String("SiteDesc")
		this.Data["CDN"] = beego.AppConfig.String("CDN")
		this.TplNames = "manager/login.tpl"
	} else {
		u := this.GetSession("user")
		if u != nil && u.(models.User).Privilege == "super" {
			this.Data["SiteTitle"] = beego.AppConfig.String("SiteTitle")
			this.Data["SiteDesc"] = beego.AppConfig.String("SiteDesc")
			this.Data["CDN"] = beego.AppConfig.String("CDN")
			this.TplNames = "manager/" + page + ".tpl"
		} else {
			this.Redirect("/manager/login.html", 302)
		}
	}
}
