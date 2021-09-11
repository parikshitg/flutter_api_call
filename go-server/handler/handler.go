package handler

import "github.com/gin-gonic/gin"

// This is our user model
type User struct {
	Name     string `json:"name"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

var db = make(map[string]User)

// Ping Handler - it's just a healthcheck api
func Ping(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong!!, the service is up and running...",
	})
}
