package api

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type LoginResponse struct {
	Status Status `json:"status"`
	Name   string `json:"name"`
	Email  string `json:"email"`
}
