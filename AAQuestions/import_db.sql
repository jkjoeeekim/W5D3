PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  following_user_id INTEGER NOT NULL,
  following_question_id INTEGER NOT NULL,

  FOREIGN KEY (following_user_id) REFERENCES users(id),
  FOREIGN KEY (following_question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Joe', 'Kim'),
  ('Zeke', 'Yu'),
  ('Mike', 'Madsen'),
  ('Jordan', 'Tom'),
  ('Andy', 'Huang');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('How to Ruby?!', 'How do you Ruby', 1),
  ('How to SQL?!', 'How do you SQL', 2),
  ('Why is my class disappointing', 'I am so disappointed', 3),
  ('Why am I sleepy', 'Whyyy', 4),
  ('How can I help you', 'IDK', 5);

INSERT INTO
  question_follows (following_user_id, following_question_id)
VALUES
  (1, 2),
  (3, 4),
  (3, 5),
  (3, 5),
  (1, 1),
  (2, 1),
  (4, 1),
  (1, 3),
  (2, 3),
  (4, 3),
  (5, 3),
  (3, 3);

INSERT INTO
  replies (body, question_id, parent_reply_id, user_id)
VALUES
  ('This is the reply', 2, NULL, 2),
  ('This is another reply', 2, 1, 3),
  ('This is the last reply', 2, 2, 1);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 1),
  (1, 4),
  (2, 1),
  (2, 3),
  (2, 4),
  (3, 2),
  (3, 4),
  (3, 3);
