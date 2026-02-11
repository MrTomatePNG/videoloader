-- name: ListPostsWithTags :many
SELECT
    p.id,
    p.comment,
    p.media_url,
    p.thumb_url,
    p.status,
    u.username AS author_name,
    COALESCE(
        json_agg(
            json_build_object('id', t.id, 'name', t.name)
        ) FILTER (WHERE t.id IS NOT NULL),
        '[]'
    ) AS tags
FROM posts p
JOIN users u ON p.user_id = u.id
LEFT JOIN post_tags pt ON p.id = pt.post_id
LEFT JOIN tags t ON pt.tag_id = t.id
WHERE p.status = 'completed'
  AND p.created_at < $1  -- cursor: último created_at da página anterior
GROUP BY p.id, u.username, p.created_at
ORDER BY p.created_at DESC
LIMIT $2;


-- name: CreatePost :one
INSERT INTO posts (user_id,media_type,media_hash)
VALUES ($1,$2,$3)
RETURNING * ;

-- name: UpdataPostProgress :exec
UPDATE posts
SET status = $1, updated_at = CURRENT_TIMESTAMP
WHERE id = $2 AND status = 'processing';
