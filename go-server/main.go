package main

import (
	"github.com/parikshitg/flutter_api_call/go-server/handler"

	"github.com/gin-gonic/gin"
	cors "github.com/rs/cors/wrapper/gin"
)

func main() {
	r := gin.Default()
	r.Use(cors.Default())

	r.GET("/ping", handler.Ping)

	r.POST("/register", handler.Register)
	r.POST("/login", handler.Login)
	r.GET("/list", handler.List)
	r.PATCH("/update-password", handler.UpdatePassword)
	r.DELETE("/delete", handler.Delete)

	r.Run()
}
