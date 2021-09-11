package api

type User struct {
	Name  string `json:"name"`
	Email string `json:"email"`
}

type ListResponse struct {
	Status Status `json:"status"`
	Users  []User `json:"users"`
}
