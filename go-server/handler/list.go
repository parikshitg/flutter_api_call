package handler

import (
	"github.com/gin-gonic/gin"
	"github.com/parikshitg/flutter_api_call/go-server/api"
)

func List(c *gin.Context) {
	res := api.ListResponse{}
	var users []api.User

	for _, v := range db {
		users = append(users, api.User{
			Name:  v.Name,
			Email: v.Email,
		})
	}

	res.Status.Success = true
	res.Users = users
	c.JSON(200, res)
}
