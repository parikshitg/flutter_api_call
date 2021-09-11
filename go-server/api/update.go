package api

type UpdateUserPasswordRequest struct {
	Email           string `json:"email"`
	OldPassword     string `json:"old_password"`
	NewPassword     string `json:"new_password"`
	ConfirmPassword string `json:"confirm_password"`
}

// There is no specific response structure we will use Response structure in api/api.go
