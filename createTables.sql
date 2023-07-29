
-- Database Managers entity, it is an isolated entity, 
-- At the end of the file, we check the number of entries and reject if there are already 4 entries.
CREATE TABLE IF NOT EXISTS DatabaseManagers (
	username VARCHAR(100),
	password_ VARCHAR(100) NOT NULL, -- password is a keyword in MySQL, so I added an underscore
	PRIMARY KEY (username) -- In the description it is not specified but this is the most natural way to define the primary key.
);

CREATE TABLE IF NOT EXISTS RatingPlatforms(
	platform_id VARCHAR(100),
	platform_name VARCHAR(100) NOT NULL UNIQUE, -- platform_name should be unique, We added additionally the "not null" constraint since it makes more sense to us that way.
	PRIMARY KEY (platform_id)
);

-- We cannot put the attributes in a movie and thus, need a seperate table for Genre.
-- Because, if we do it that way, we cannot catch the UNIQUE constraint on the genre_name.
-- Moreover, a movie can also have more than one genre, so this seems to be the only solution.
CREATE TABLE IF NOT EXISTS Genres(
	genre_id VARCHAR(100),  -- Since it is primary key, by default it is not null and unique.
	genre_name VARCHAR(100) NOT NULL UNIQUE, -- Genre name should not be null, because it makes no sense and its name must be unique.
	PRIMARY KEY(genre_id)
);

CREATE TABLE IF NOT EXISTS Audiences(
	username VARCHAR(100),
	password_ VARCHAR(100) NOT NULL, -- 'password' is reserved, so I added an underscore
	name_ VARCHAR(100), -- 'name' is reserved, so I added an underscore
	surname VARCHAR(100),
	PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS Directors(
	username VARCHAR(100),
	password_ VARCHAR(100) NOT NULL, -- 'password' is reserved, so I added an underscore
	name_ VARCHAR(100), -- 'name' is reserved, so I added an underscore
	surname VARCHAR(100),
	nationality VARCHAR(100) NOT NULL,
	platform_id VARCHAR(100), -- This attribute is sufficient to describe Member_Of relation between Director and RatingPlatform entities since the relationship has key constraint.
	PRIMARY KEY (username),
	FOREIGN KEY (platform_id) REFERENCES RatingPlatforms(platform_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Movies(
	movie_id VARCHAR(100),
	movie_name VARCHAR(100) NOT NULL, -- Movie should not be nameless
	duration INT NOT NULL, -- It cannot have float values in our project. Therefore we use int, also duration must be added, otherwise we reject its addition.
	director_username VARCHAR(100) NOT NULL,
	average_rating REAL,
	PRIMARY KEY (movie_id),
	FOREIGN KEY (director_username) REFERENCES Directors(username)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);



-- How to enforce participation constraint ????
-- We couldn't enforce that constraint 
CREATE TABLE IF NOT EXISTS MovieHasGenres (
	movie_id VARCHAR(100),
	genre_id VARCHAR(100),
	PRIMARY KEY (movie_id, genre_id),
	FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Subscribes(
	username VARCHAR(100),
	platform_id VARCHAR(100),
	PRIMARY KEY (username, platform_id),
	FOREIGN KEY (username) REFERENCES Audiences(username)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (platform_id) REFERENCES RatingPlatforms(platform_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

-- Remember that directors cannot rate a movie
-- We check the condition that a user cannot rate a movie more than once in the trigger section. It is at the end of the file.

CREATE TABLE IF NOT EXISTS Rates(
	username VARCHAR(100),
	movie_id VARCHAR(100),
	rating REAL NOT NULL,
	FOREIGN KEY (username) REFERENCES Audiences(username)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
	FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);




CREATE TABLE IF NOT EXISTS Theaters(
	theater_id VARCHAR(100),
	theater_name VARCHAR(100) NOT NULL, -- Every theatre must have a name
	theater_capacity INT NOT NULL, -- We thought that capacity must be specified while creating the theatre. Otherwise, in the future, we may encounter problems.
	theater_district VARCHAR(100),

	PRIMARY KEY (theater_id)
);

CREATE TABLE IF NOT EXISTS MovieSessions(
	session_id VARCHAR(100),
	movie_id VARCHAR(100) NOT NULL,
	theater_id VARCHAR(100) NOT NULL,
	date_ DATE,
	time_slot INT,

	PRIMARY KEY(session_id),
	FOREIGN KEY(movie_id) REFERENCES Movies(movie_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY(theater_id) REFERENCES Theaters(theater_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS BoughtTickets(
	username VARCHAR(100),
	session_id VARCHAR(100),
	PRIMARY KEY (username, session_id),
	FOREIGN KEY (username) REFERENCES Audiences(username)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (session_id) REFERENCES MovieSessions(session_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS MoviePrerequisites(
	movie_id_predecessor VARCHAR(100),
	movie_id_successor VARCHAR(100),
	PRIMARY KEY (movie_id_predecessor, movie_id_successor),
	FOREIGN KEY (movie_id_predecessor) REFERENCES Movies(movie_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (movie_id_successor) REFERENCES Movies(movie_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
);



-- If a user has already rated the movie, reject the insertion.
DELIMITER $$
CREATE TRIGGER insertRating
    BEFORE INSERT
    ON Rates FOR EACH ROW 
    BEGIN  
        DECLARE row_count_ INT;
        SELECT COUNT(*) INTO row_count_ FROM Rates WHERE username = NEW.username AND movie_id = NEW.movie_id;
        IF row_count_ > 0 THEN
            SIGNAL SQLSTATE '23555' SET MESSAGE_TEXT = 'A user cannot rate a movie more than once';
        END IF;
    END $$
DELIMITER ; 

## Update average rating after a rating is added to a Rates table
DELIMITER ##
CREATE TRIGGER updateAverageRating
    AFTER INSERT 
    ON Rates FOR EACH ROW 
    BEGIN
        DECLARE total_ratings DECIMAL(4,2);
        DECLARE total_sum DECIMAL(4,2);
        SET total_ratings = (SELECT COUNT(*) FROM Rates WHERE movie_id = NEW.movie_id);
        SET total_sum = (SELECT SUM(rating) FROM Rates WHERE movie_id = NEW.movie_id);
        UPDATE Movies SET average_rating = total_sum / total_ratings WHERE movie_id = NEW.movie_id;
    END ##
DELIMITER ;

DELIMITER %%
CREATE TRIGGER InsertDatabaseManager 
    BEFORE INSERT 
    ON DatabaseManagers FOR EACH ROW 
    BEGIN
        IF ((SELECT COUNT(*) FROM DatabaseManagers) >= 4) THEN 
            SIGNAL SQLSTATE '23555' SET MESSAGE_TEXT = 'No more than 4 database managers are allowed';
        END IF;
    END %%
DELIMITER ;
