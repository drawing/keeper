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
		this.Data["SiteTitle"] = beego.AppConfig.String("SiteTitle")
		this.Data["SiteDesc"] = beego.AppConfig.String("SiteDesc")
		this.TplNames = "manager/login.tpl"
	} else if page == "manager" {
		u := this.GetSession("user")
		if u != nil && u.(models.User).Privilege == "super" {
			this.Data["SiteTitle"] = beego.AppConfig.String("SiteTitle")
			this.Data["SiteDesc"] = beego.AppConfig.String("SiteDesc")
			this.TplNames = "manager/manager.tpl"
		} else {
			this.Redirect("/manager/login.html", 302)
		}
	} else {
		this.Abort("404")
	}
}
