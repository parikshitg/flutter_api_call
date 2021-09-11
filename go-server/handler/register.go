package handler

import (
	"net/http"

	"github.com/gin-gonic/gin"

	"github.com/parikshitg/flutter_api_call/go-server/api"
)

func Register(c *gin.Context) {
	req := api.RegisterRequest{}
	res := api.Response{}

	err := c.BindJSON(&req)
	if err != nil {
		res.Status.ErrorMessage = err.Error()
		c.JSON(http.StatusBadRequest, res)
		return
	}

	if req.Password != req.ConfirmPassword {
		res.Status.ErrorMessage = "Passwords doesn't match!!"
		c.JSON(http.StatusBadRequest, res)
		return
	}

	_, ok := db[req.Email]
	if ok {
		res.Status.ErrorMessage = "user already exists!!"
		c.JSON(http.StatusBadRequest, res)
		return
	}

	user := User{
		Name:     req.Name,
		Email:    req.Email,
		Password: req.Password,
	}

	db[user.Email] = user

	res.Status.Success = true
	c.JSON(http.StatusOK, res)
}
