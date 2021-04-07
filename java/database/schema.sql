BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS seq_user_id;
DROP TABLE IF EXISTS catlist;
DROP SEQUENCE IF EXISTS seq_cat_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_cat_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE catlist (
	cat_id int DEFAULT nextval('seq_cat_id'::regclass) NOT NULL,
	name varchar(50) NOT NULL,
	age int NOT NULL,
	breed varchar(50) NOT NULL,
	color varchar(50) NOT NULL,
	occupation varchar(50) NOT NULL,
	tagline varchar(200) NOT NULL,
	address varchar(200) NOT NULL,
	summary varchar(1000) NOT NULL,
	CONSTRAINT PK_catlist PRIMARY KEY (cat_id),
	CONSTRAINT FK_catlist_users FOREIGN KEY (cat_id) REFERENCES users (user_id)
);

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

COMMIT TRANSACTION;
