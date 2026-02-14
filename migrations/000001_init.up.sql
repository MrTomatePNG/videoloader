CREATE TABLE users (
    id          BIGSERIAL PRIMARY KEY,
    username    VARCHAR(30) NOT NULL UNIQUE,
    email       VARCHAR(255) NOT NULL UNIQUE,
    password    TEXT NOT NULL,
    avatar_url  TEXT,
    bio         VARCHAR(160),
    created_at  TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_username ON users(username);

CREATE TYPE post_status AS ENUM ('pending','processing','completed','failed');

CREATE TABLE posts(
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    comment TEXT,
    media_hash VARCHAR(64) NOT NULL,
    media_type VARCHAR(10) NOT NULL,
    media_url TEXT,
    thumb_url TEXT,
    status post_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_posts_status ON posts(status) WHERE status = 'completed';
CREATE INDEX idx_posts_created_at ON posts(created_at DESC);

CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE post_tags (
    post_id BIGINT REFERENCES posts(id) ON DELETE CASCADE,
    tag_id INT REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (post_id, tag_id)
);

CREATE INDEX idx_post_tags_post ON post_tags(post_id);
CREATE INDEX idx_post_tags_tag ON post_tags(tag_id);
