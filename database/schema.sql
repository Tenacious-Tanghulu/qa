DROP TABLE IF EXISTS questions, answers, photos;

CREATE TABLE questions (
  id SERIAL PRIMARY KEY,
  product_id INTEGER NOT NULL,
  body VARCHAR(1000),
  date_written DOUBLE PRECISION,
  asker_name VARCHAR(60),
  asker_email VARCHAR(100),
  reported INTEGER DEFAULT 0,
  helpful INTEGER DEFAULT 0
);

-- CREATE TABLE temp_questions (
--   id SERIAL PRIMARY KEY,
--   product_id INTEGER NOT NULL,
--   body VARCHAR(1000),
--   date_written DOUBLE PRECISION,
--   asker_name VARCHAR(60),
--   asker_email VARCHAR(100),
--   reported INTEGER DEFAULT 0,
--   helpful INTEGER DEFAULT 0
-- );

CREATE TABLE answers (
  id SERIAL PRIMARY KEY,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  body VARCHAR(1000),
  date_written DOUBLE PRECISION,
  answerer_name VARCHAR(60),
  answerer_email VARCHAR(100),
  reported INTEGER DEFAULT 0,
  helpful INTEGER DEFAULT 0
);

-- CREATE TABLE temp_answers (
--   id SERIAL PRIMARY KEY,
--   question_id INTEGER NOT NULL REFERENCES questions(id),
--   body VARCHAR(1000),
--   date_written DOUBLE PRECISION,
--   answerer_name VARCHAR(60),
--   answerer_email VARCHAR(100),
--   reported INTEGER DEFAULT 0,
--   helpful INTEGER DEFAULT 0
-- );

CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  answer_id INTEGER NOT NULL REFERENCES answers(id),
  photo_url VARCHAR(255)
);

-- CREATE TABLE temp_photos (
--   id SERIAL PRIMARY KEY,
--   answer_id INTEGER NOT NULL REFERENCES answers(id),
--   photo_url VARCHAR(255)
-- );

COPY questions(id, product_id, body, date_written, asker_name, asker_email, reported, helpful)
FROM '/Users/katejeon/Desktop/cs/hackreactor/system-design-capstone/data/questions.csv'
DELIMITER ','
CSV HEADER;

-- COPY temp_questions(id, product_id, body, date_written, asker_name, asker_email, reported, helpful)
-- FROM '/Users/katejeon/Desktop/cs/hackreactor/system-design-capstone/data/temp-questions.csv'
-- DELIMITER ','
-- CSV HEADER;
-- ALTER TABLE temp_questions ALTER COLUMN date_written TYPE timestamp USING to_timestamp(date_written/1000);

COPY answers(id, question_id, body, date_written, answerer_name, answerer_email, reported, helpful)
FROM '/Users/katejeon/Desktop/cs/hackreactor/system-design-capstone/data/answers.csv'
DELIMITER ','
CSV HEADER;

-- COPY temp_answers(id, question_id, body, date_written, answerer_name, answerer_email, reported, helpful)
-- FROM '/Users/katejeon/Desktop/cs/hackreactor/system-design-capstone/data/temp-answers.csv'
-- DELIMITER ','
-- CSV HEADER;
-- ALTER TABLE temp_answers ALTER COLUMN date_written TYPE timestamp USING to_timestamp(date_written/1000);

COPY photos(id, answer_id, photo_url)
FROM '/Users/katejeon/Desktop/cs/hackreactor/system-design-capstone/data/photos.csv'
DELIMITER ','
CSV HEADER;

-- COPY temp_photos(id, answer_id, photo_url)
-- FROM '/Users/katejeon/Desktop/cs/hackreactor/system-design-capstone/data/temp-photos.csv'
-- DELIMITER ','
-- CSV HEADER;

ALTER TABLE questions ALTER COLUMN date_written TYPE timestamp USING to_timestamp(date_written/1000);
ALTER TABLE answers ALTER COLUMN date_written TYPE timestamp USING to_timestamp(date_written/1000);

ALTER TABLE questions ALTER COLUMN reported SET DEFAULT 0;
ALTER TABLE questions ALTER COLUMN helpful SET DEFAULT 0;
ALTER TABLE answers ALTER COLUMN reported SET DEFAULT 0;
ALTER TABLE answers ALTER COLUMN helpful SET DEFAULT 0;

CREATE INDEX product_id_index ON questions(product_id);
CREATE INDEX question_id_index ON answers(question_id);
CREATE INDEX answer_id_index ON photos(answer_id);
