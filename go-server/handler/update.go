package handler

import (
	"net/http"

	"github.com/parikshitg/flutter_api_call/go-server/api"

	"github.com/gin-gonic/gin"
)

func UpdatePassword(c *gin.Context) {
	req := api.UpdateUserPasswordRequest{}
	res := api.Response{}

	err := c.BindJSON(&req)
	if err != nil {
		res.Status.ErrorMessage = err.Error()
		c.JSON(http.StatusBadRequest, res)
		return
	}

	if req.NewPassword != req.ConfirmPassword {
		res.Status.ErrorMessage = "Passwords doesn't match!!"
		c.JSON(http.StatusBadRequest, res)
		return
	}

	u, ok := db[req.Email]
	if !ok {
		res.Status.ErrorMessage = "user does not exists!!"
		c.JSON(http.StatusNotFound, res)
		return
	}

	if u.Password != req.OldPassword {
		res.Status.ErrorMessage = "invalid user!!"
		c.JSON(http.StatusNotFound, res)
		return
	}

	user := User{
		Name:     u.Name,
		Email:    u.Email,
		Password: req.NewPassword,
	}

	db[user.Email] = user

	res.Status.Success = true
	c.JSON(http.StatusOK, res)
}
