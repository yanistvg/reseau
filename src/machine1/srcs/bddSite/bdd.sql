DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS prescriptions;

CREATE TABLE reviews (
	id		INT PRIMARY KEY AUTO_INCREMENT,
	email	TEXT,
	review 	TEXT,
	stars	INT,
	ip		TEXT
);

CREATE TABLE prescriptions (
	id		INT PRIMARY KEY AUTO_INCREMENT,
	email	TEXT,
	linkImg	TEXT,
	ip 		TEXT
);

# CREATE USER 'CTF_reseau_site'@localhost IDENTIFIED BY 'q9mChiFtU4YC2568';
# GRANT ALL PRIVILEGES ON *.* TO 'CTF_reseau_site'@localhost IDENTIFIED BY 'q9mChiFtU4YC2568';

INSERT INTO reviews VALUES(0, "flag_Y_X", "4COQUINS{PUfBTEdYcPU5h5ncg062wMvd}", 5, "0.0.0.0");