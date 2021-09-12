package handler

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/parikshitg/flutter_api_call/go-server/api"
)

func Delete(c *gin.Context) {
	req := api.DeleteRequest{}
	res := api.Response{}

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

	if req.Password != u.Password {
		res.Status.ErrorMessage = "invalid password!!"
		c.JSON(http.StatusNotFound, res)
		return
	}

	delete(db, u.Email)
	res.Status.Success = true
	c.JSON(http.StatusOK, res)
}
