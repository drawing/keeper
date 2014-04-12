package main

import (
	_ "./routers"

	"github.com/astaxie/beego"
	"github.com/russross/blackfriday"
	"html/template"
)

func markdown(input string) template.HTML {
	htmlFlags := 0
	htmlFlags |= blackfriday.HTML_USE_XHTML
	htmlFlags |= blackfriday.HTML_USE_SMARTYPANTS
	htmlFlags |= blackfriday.HTML_SMARTYPANTS_FRACTIONS
	htmlFlags |= blackfriday.HTML_SMARTYPANTS_LATEX_DASHES
	// htmlFlags |= blackfriday.HTML_SANITIZE_OUTPUT
	htmlFlags |= blackfriday.HTML_TOC
	renderer := blackfriday.HtmlRenderer(htmlFlags, "", "")

	// set up the parser
	extensions := 0
	extensions |= blackfriday.EXTENSION_NO_INTRA_EMPHASIS
	extensions |= blackfriday.EXTENSION_TABLES
	extensions |= blackfriday.EXTENSION_FENCED_CODE
	extensions |= blackfriday.EXTENSION_AUTOLINK
	extensions |= blackfriday.EXTENSION_STRIKETHROUGH
	extensions |= blackfriday.EXTENSION_SPACE_HEADERS

	output := blackfriday.Markdown([]byte(input), renderer, extensions)

	return template.HTML(output)
}

func main() {
	beego.TemplateLeft = "{%"
	beego.TemplateRight = "%}"

	beego.SetStaticPath("/keep", "upload")
	beego.AddFuncMap("markdown", markdown)

	beego.Run()
}
