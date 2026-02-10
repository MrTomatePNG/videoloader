package dto

type UserDto struct {
	ID       int64  `json:"id"`
	Username string `json:"username"`
	Bio      string `json:"bio"`
}
