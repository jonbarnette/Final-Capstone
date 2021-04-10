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
	imageName varchar(15),
	lives int NOT NULL,
	breed varchar(50) NOT NULL,
	color varchar(50) NOT NULL,
	occupation varchar(50) NOT NULL,
	tagline varchar(200) NOT NULL,
	address varchar(200) NOT NULL,
	summary varchar(1000) NOT NULL,
	CONSTRAINT PK_catlist PRIMARY KEY (cat_id),
	CONSTRAINT FK_catlist_users FOREIGN KEY (cat_id) REFERENCES users (user_id)
);

CREATE TABLE msystem (
	cat_id int NOT NULL,
	sender varchar(50) NOT NULL,
	message varchar(1000) NOT NULL,
	CONSTRAINT PK_msystem PRIMARY KEY (cat_id),
	CONSTRAINT FK_msystem_users FOREIGN KEY (cat_id) REFERENCES users (user_id)
);

-- Inserting users into USERS table
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('puma','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('cat','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('fleas','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('meowly','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('catwick','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('katty','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('jennipurr','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');

-- Inserting users into CATLIST table
INSERT INTO catlist (name,imageName,lives,breed,color,occupation,tagline,address,summary) VALUES ('Admin','1001.jpg','9','Human','n/a','Recruiter','Helping put the floofsters to work!','Working','I became a crazy cat person many years ago, it all began with one fluffball. I only have 30 but plan for more!');
INSERT INTO catlist (name,imageName,lives,breed,color,occupation,tagline,address,summary) VALUES ('Puma Thurman','1007.jpg','5','Persian','White','Plumber','You clog it, I clear it!','Dumpster of TE Columbus','I have a lot of experience in clearing hairballs, no matter how big they are. I like to clear them and leave them for the "Very Smart Dog" to eat!');
INSERT INTO catlist (name,imageName,lives,breed,color,occupation,tagline,address,summary) VALUES ('Cat Damon','1011.jpg','4','Tabby','Marble','Actor','Shepherdspear is my thing!','Sitting on Steves head','I enjoy pretending to be a toupee, just ask Steve! I love to nap so it was the purrfect job to have. Looking for a similar job, that does not require much work.');
INSERT INTO catlist (name,imageName,lives,breed,color,occupation,tagline,address,summary) VALUES ('Fleas Witherspoon','1008.jpg','6','Russian Blue','Grey','Software Developur','Hello World Domination!','Sitting on a keyboard','Never thought I could be a coder until I went to school for it. Now I enjoy chasing bugs for hours. Purrenthesis are not my favorite!');
INSERT INTO catlist (name,imageName,lives,breed,color,occupation,tagline,address,summary) VALUES ('Meowly Cyrus','1000.jpg','8','Shorthair','Black/White','Singer','I placed 5th on Americat Idol!','Backstage of Americat Idol','When I sing its the purrfect tone to sooth your soul, unless you are ignoring me or I am hungry. Then I sing as loud as possible to annoy you!');
INSERT INTO catlist (name,imageName,lives,breed,color,occupation,tagline,address,summary) VALUES ('Catwick Swayze','1014.jpg','1','Sphinx','White/Grey','Dancer','Dancing Dirty under the street lights!','MeowTown Philly','When the devil went down to Georgia, I ghosted him and danced him into the grave! Great in a bar or on the farm!');
INSERT INTO catlist (name,imageName,lives,breed,color,occupation,tagline,address,summary) VALUES ('Katty Purry','1012.jpg','7','Scottish Fold','Grey','Teacher','EduCation is my passion!','Prowling around classrooms','The teachers pet has become the teacher, one more step to taking over the world. I like to teach the kittens about attack mode.');
INSERT INTO catlist (name,imageName,lives,breed,color,occupation,tagline,address,summary) VALUES ('Jennipurr Aniston','1005.jpg','3','Calico','Multi','Plumber','I do not like water!','Chasing a mouse down the street','One time I was in the bathroom walking on the side of the tub. The human claims I slipped but I am sure he pushed me. Anyways I did not think I was gonna make it out alive. Traggic.');

COMMIT TRANSACTION;
