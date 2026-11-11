DROP TABLE IF EXISTS result CASCADE;
DROP TABLE IF EXISTS task CASCADE;
DROP TABLE IF EXISTS module_card CASCADE;
DROP TABLE IF EXISTS module CASCADE;
DROP TABLE IF EXISTS card_tag CASCADE;
DROP TABLE IF EXISTS tag CASCADE;
DROP TABLE IF EXISTS card CASCADE;
DROP TABLE IF EXISTS dictionary CASCADE;
DROP TABLE IF EXISTS progress CASCADE;
DROP TABLE IF EXISTS app_user CASCADE;
DROP TABLE IF EXISTS language CASCADE;

CREATE TABLE language (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE app_user (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE progress (
    id SERIAL PRIMARY KEY,
    user_id INT UNIQUE REFERENCES app_user(id) ON DELETE CASCADE
);

CREATE TABLE dictionary (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    author_id INT REFERENCES app_user(id) ON DELETE CASCADE,
    source_language_id INT REFERENCES language(id) ON DELETE RESTRICT,
    target_language_id INT REFERENCES language(id) ON DELETE RESTRICT
);

CREATE TABLE card (
    id SERIAL PRIMARY KEY,
    dictionary_id INT REFERENCES dictionary(id) ON DELETE CASCADE,
    term VARCHAR(255) NOT NULL,
    translation VARCHAR(255) NOT NULL
);

CREATE TABLE tag (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE card_tag (
    card_id INT REFERENCES card(id) ON DELETE CASCADE,
    tag_id INT REFERENCES tag(id) ON DELETE CASCADE,
    PRIMARY KEY (card_id, tag_id)
);

CREATE TABLE module (
    id SERIAL PRIMARY KEY,
    dictionary_id INT REFERENCES dictionary(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE module_card (
    module_id INT REFERENCES module(id) ON DELETE CASCADE,
    card_id INT REFERENCES card(id) ON DELETE CASCADE,
    PRIMARY KEY (module_id, card_id)
);

CREATE TABLE task (
    id SERIAL PRIMARY KEY,
    module_id INT REFERENCES module(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL
);

CREATE TABLE result (
    id SERIAL PRIMARY KEY,
    task_id INT REFERENCES task(id) ON DELETE CASCADE,
    user_id INT REFERENCES app_user(id) ON DELETE CASCADE,
    errors_count INT DEFAULT 0
);

CREATE INDEX idx_dict_langs ON dictionary(source_language_id, target_language_id);
CREATE INDEX idx_card_dict ON card(dictionary_id);
CREATE INDEX idx_module_dict ON module(dictionary_id);
CREATE INDEX idx_result_user ON result(user_id);
CREATE INDEX idx_task_module ON task(module_id);