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

# CREATE USER 'CTF_reseau_site'@localhost IDENTIFIED BY 'azerty18';
# GRANT ALL PRIVILEGES ON *.* TO 'CTF_reseau_site'@localhost IDENTIFIED BY 'azerty18';