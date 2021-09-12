package api

type DeleteRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

// There is no specific response structure we will use Response structure in api/api.go
