package controllers

import (
	"github.com/astaxie/beego"
)

type SEOController struct {
	beego.Controller

	robots []byte
}

func (this *SEOController) Get() {
	if this.Ctx.Input.URI() == "/robots.txt" {
		if this.robots == nil {
			robots_string := "User-agent: *\n"
			robots_string += "Disallow: /upload/\n"
			robots_string += "Disallow: /static/\n"
			robots_string += "Disallow: /manager/\n"
			this.robots = []byte(robots_string)
		}
		this.Ctx.Output.Header("Content-Type", "text/plain")
		this.Ctx.Output.Body(this.robots)
		return
	}
	this.Abort("404")
}
