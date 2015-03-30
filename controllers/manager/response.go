package manager

import (
	"../../models"
)

const (
	ERR_SUCC = iota
	ERR_SQL
	ERR_INPUT
	ERR_LOGIN
	ERR_AUTH
	ERR_KEEP_FILE
)

type PostEcho struct {
	Code    int
	Message string
	List    []models.Post
	Count   int64
	CurPage int64
	PageNum int64
	One     models.Post
}

type UserEcho struct {
	Code    int
	Message string
	List    []models.User
	One     models.User
}

type CategoryEcho struct {
	Code    int
	Message string
	List    []models.Category
	One     models.Category
}

type TagEcho struct {
	Code    int
	Message string
	List    []models.Tag
	One     models.Tag
}

type LoginEcho struct {
	Code    int
	Message string
}

type ResourceEcho struct {
	Code    int
	Message string
	One     models.Resource
}
