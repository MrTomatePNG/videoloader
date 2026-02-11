-- name: CreatePostEnum
CREATE TYPE post_status AS ENUM ('pending','processing','completed','failed');

-- name: CreatePostTable
CREATE TABLE posts(
	id BIGSERIAL PRIMARY KEY ,
	user_id BIGINT NOT NULL REFERENCES	users(id),
	COMMENT TEXT,

	-- IDENTIFICAÇÂO e TIPO
	media_hash VARCHAR(64) NOT NULL,
	media_type VARCHAR(10) NOT null , -- 'image' ou 'video'

	-- CAMINHOS NO STORAGE (começam nulos e sao preenchidos pelo Worker)
	media_url TEXT,
	thumb_url TEXT,

	status post_status NOT NULL DEFAULT 'pending',

	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP
);

-- INDICES
CREATE INDEX idx_posts_status ON posts(status) WHERE status = 'completed';
CREATE INDEX idx_posts_created_at ON posts(created_at DESC);
