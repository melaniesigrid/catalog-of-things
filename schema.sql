CREATE TABLE item (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  publish_date  DATE  NOT NULL,
  archived BOOLEAN NOT NULL,
  author_id INT,
  label_id INT,

  CONSTRAINT fk_author
      FOREIGN KEY (author_id)
      REFERENCES author (id)
      ON DELETE SET NULL
)

CREATE TABLE author (
  id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name  VARCHAR(50) NOT NULL,
)

CREATE TABLE game (
  id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  multiplayer BOOLEAN NOT NULL,
  last_played_at DATE NOT NULL
  item_id INT NOT NULL,
  genre_id INT,
  FOREIGN KEY (genre_id) REFERENCES genre(id) ON DELETE SET NULL ON UPDATE CASCADE,

  CONSTRAINT fk_item
      FOREIGN KEY (item_id)
      REFERENCES item (id)
      ON DELETE CASCADE
)

CREATE TABLE music_album(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  genre_id INT,
  publish_date DATE,
  archived BOOLEAN,
  on_spotify BOOLEAN,
  FOREIGN KEY(genre_id) references genre(id) on DELETE
  SET NULL ON UPDATE CASCADE
);

CREATE TABLE genre(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50)
);
