package api

type User struct {
	ID    int    `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
}

type ListResponse struct {
	Status int    `json:"status"`
	Users  []User `json:"users"`
}
