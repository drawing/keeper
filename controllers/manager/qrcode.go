package manager

import (
	"github.com/astaxie/beego"
	"github.com/balasanjay/totp"
)

type QrCodeController struct {
	beego.Controller
}

func (this *QrCodeController) Get() {
	secret := this.GetString("Secret")
	issuer := this.GetString("Issuer")

	data, err := totp.BarcodeImage(issuer, []byte(secret), nil)
	if err != nil {
		this.Ctx.Abort(404, "input data error")
	} else {
		this.Ctx.Output.Header("Content-Type", "image/png")
		this.Ctx.Output.Body(data)
	}
}
