CREATE TABLE users (
    id SERIAL PRIMARY KEY
    username VARCHAR(25) NOT NULL UNIQUE);
    
CREATE TABLE topics (
    id SERIAL PRIMARY KEY
    user_id VARCHAR(25) FOREIGN KEY REFERENCES users(id)
    topic_name VARCHAR(30) NOT NULL UNIQUE
    description VARCHAR(500) DEFAULT NULL);
    
CREATE TABLE posts (
    id SERIAL PRIMARY KEY
    title VARCHAR(100) NOT NULL UNIQUE
    user_id INT FOREIGN KEY REFERENCES users(id) ON DELETE SET NULL
    topic_id INT FOREIGN KEY REFERENCES topics(id) ON DELETE CASCADE
    url TEXT CHECK (text_content IS NULL)
    text_content TEXT CHECK (url IS NULL)
    votes );
    
CREATE TABLE comments (
    id SERIAL PRIMARY KEY
    post_id INT FOREIGN KEY REFERENCES posts(id) ON DELETE CASCADE
    user_id INT FOREIGN KEY REFERENCES users(id) ON DELETE SET NULL
    comment TEXT NOT NULL
    parent_id INT FOREIGN KEY REFERENCES comments(id) ON DELETE CASCADE);
    
CREATE TABLE votes (
    id SERIAL PRIMARY KEY
    upvote BINARY CHECK (downvote = 0)
    downvote ~BINARY CHECK (upvote = 0)
    user_id INT FOREIGN KEY REFERENCES users(id)
    post_id INT FOREIGN KEY REFERENCES posts(id) ON DELETE CASCADE);