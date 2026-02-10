-- sql/queries/users.sql

-- name: CreateUser :one
INSERT INTO users (username, email, password)
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetUserByEmail :one
SELECT * FROM users
WHERE email = $1 LIMIT 1;

-- name: GetUserByID :one
SELECT * FROM users
WHERE id = $1 LIMIT 1;

-- name: UpdateUserBio :exec
UPDATE users
SET bio = $2,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1;

-- name: UpdateUserAvatar :exec
UPDATE users
SET avatar_url = $2,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1;


-- name: DeleteUserByID :exec
DELETE FROM users WHERE id = $1;
