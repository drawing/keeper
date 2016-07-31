package controllers

import (
	"../models"

	"strconv"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

type MainController struct {
	beego.Controller
}

func (this *MainController) Get() {
	u := this.GetSession("user")
	pass := this.GetSession("pass")

	var forbid_friend bool = true
	var total int64
	var limit int64 = 15
	var id int64

	page, err := this.GetInt("page")
	if err != nil {
		page = 0
	}

	classify := "category"
	slug := beego.AppConfig.String("SiteDefaultCategory")

	o := orm.NewOrm()

	var classElem models.Category
	classElem.Slug = slug
	err = o.Read(&classElem, "slug")
	if err == nil {
		id = classElem.Id
		this.Data["Classify"] = classElem
	}

	var posts []*models.Post

	if err == nil {
		qs := o.QueryTable("post").Filter(classify+"_id", id).OrderBy("-id")
		if u == nil {
			qs = qs.Filter("status__in", "Publish", "Friend")
			if pass != nil {
				forbid_friend = false
			}
		} else {
			forbid_friend = false
		}

		total, err = qs.Count()

		qs = qs.Limit(limit, page*int(limit))
		if err == nil {
			_, err = qs.All(&posts)
		}
		if err == nil {
			this.Data["Posts"] = posts
		}
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

	page_num := (total - 1) / limit
	if page >= 1 {
		this.Data["Previous"] = "/" + classify + "/" + slug + ".html?page=" + strconv.Itoa(int(page-1))
	}
	if page < int(page_num) {
		this.Data["Next"] = "/" + classify + "/" + slug + ".html?page=" + strconv.Itoa(int(page+1))
	}

	this.Data["SiteTitle"] = beego.AppConfig.String("SiteTitle")
	this.Data["SiteDesc"] = beego.AppConfig.String("SiteDesc")
	this.Data["CDN"] = beego.AppConfig.String("CDN")
	this.Data["ForbidFriend"] = forbid_friend
	this.TplName = "classify.tpl"
}
