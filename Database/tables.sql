CREATE TABLE IF NOT EXISTS city_data (
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR(17) NULL,
	country VARCHAR(2) NULL,
	coord_lon INT NULL,
	coord_lat INT NULL
);


CREATE TABLE IF NOT EXISTS added_city(
	id INTEGER PRIMARY KEY NOT NULL,
	favorite BOOLEAN,
	FOREIGN KEY (id) REFERENCES city_data(id)
);

CREATE TABLE IF NOT EXISTS city_history(
	id INTEGER NOT NULL,
	currTime  DOUBLE NOT NULL,
	mainTemp FLOAT NOT NULL,
	minTemp FLOAT NOT NULL,
	maxTemp FLOAT NOT NULL,
	description TEXT,
	icon TEXT,
	PRIMARY KEY (id,currTime),
	FOREIGN KEY (id) REFERENCES added_city(id) ON DELETE CASCADE
);