package handler

import (
	"net/http"

	"github.com/parikshitg/flutter_api_call/go-server/api"

	"github.com/gin-gonic/gin"
)

func Login(c *gin.Context) {
	req := api.LoginRequest{}
	res := api.LoginResponse{}

	err := c.BindJSON(&req)
	if err != nil {
		res.Status.ErrorMessage = err.Error()
		c.JSON(http.StatusBadRequest, res)
		return
	}

	u, ok := db[req.Email]
	if !ok {
		res.Status.ErrorMessage = "user does not exists!!"
		c.JSON(http.StatusNotFound, res)
		return
	}

	if u.Password != req.Password {
		res.Status.ErrorMessage = "Invalid Password!!"
		c.JSON(http.StatusNotFound, res)
		return
	}

	res.Status.Success = true
	res.Email = u.Email
	res.Name = u.Name
	c.JSON(http.StatusOK, res)
}
