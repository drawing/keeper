package models

import (
	"time"
)

type TaskItem struct {
	Content    string
	UpdateTime time.Time
}

type ScheduleTask struct {
	Name        string
	TargetCount int64
	FinishCount int64
	TargetItem  []TaskItem
	FinishItem  []TaskItem
}

type Schedule struct {
	Task []ScheduleTask
}

type Widget struct {
	Id     int64  `orm:"auto"`
	Family string `orm:"index;unique"`
	Data   []byte
}
