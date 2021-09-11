package api

type Status struct {
	Success      bool   `json:"success"`
	ErrorMessage string `json:"error_message,omitempty"`
}

type Response struct {
	Status Status `json:"status"`
}
