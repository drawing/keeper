package manager

import (
	"../../models"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/balasanjay/totp"

	"encoding/json"
)

type LoginController struct {
	beego.Controller
}

func (this *LoginController) Post() {
	echo := new(LoginEcho)
	this.Data["json"] = echo
	defer this.ServeJSON()

	var user models.User
	var u models.User

	err := json.Unmarshal(this.Ctx.Input.RequestBody, &u)
	if err != nil || u.Email == "" || u.Password == "" {
		echo.Code = ERR_INPUT
		echo.Message = "request error"
		return
	}

	o := orm.NewOrm()

	user.Email = u.Email
	err = o.Read(&user, "email")
	if err != nil || !totp.Authenticate([]byte(user.Password), u.Password, nil) {
		echo.Code = ERR_LOGIN
		echo.Message = "user name or password error"
	} else {
		echo.Code = ERR_SUCC
		echo.Message = "/manager/index.html"
		this.SetSession("user", user)

		beego.Warn("login:", user, u)
	}
}
