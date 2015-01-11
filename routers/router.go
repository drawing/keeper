package routers

import (
	"../controllers"
	"../controllers/manager"
	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.MainController{})

	beego.Router("/robots.txt", &controllers.SEOController{})

	beego.Router("/reading/:slug(\\S+).html", &controllers.ReadingController{})
	beego.Router("/:classify(category|tag)/:slug(\\S+).html", &controllers.ClassifyController{})

	beego.Router("/manager/:page(\\S+).html", &controllers.ManagerController{})

	beego.Router("/api/login", &manager.LoginController{})
	beego.Router("/api/posts/:id([0-9]+)", &manager.PostController{})
	beego.Router("/api/posts", &manager.PostsController{})
	beego.Router("/api/categories", &manager.CategoriesController{})
	beego.Router("/api/tags", &manager.TagsController{})
	beego.Router("/api/users", &manager.UsersController{})
	beego.Router("/api/resource", &manager.ResourceController{})

	beego.Router("/api/widget", &manager.WidgetController{})
}
