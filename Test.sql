-- Testing --

-- To test the DB system, first execute createTables.sql file. 
-- createTables.sql creates a DB named "Group26" and all necessary tables. It also sets some triggers. 
-- Current version of the file consists of valid queries. You can add invalid queries to check system integrity. (e.g. a user rates a movie more than once, two user with the same username)
-- After executing Test.sql, execute dropTables.sql.

USE GROUP26;

-- Insert data into RatingPlatforms table
INSERT INTO RatingPlatforms (platform_id, platform_name) VALUES ("rotten_tomatoes", "Rotten Tomatoes");
INSERT INTO RatingPlatforms (platform_id, platform_name) VALUES ("imdb", "IMDb");
INSERT INTO RatingPlatforms (platform_id, platform_name) VALUES ("metacritic", "Metacritic");

-- Insert data into Genres table
INSERT INTO Genres (genre_id, genre_name) VALUES ("1", "Action");
INSERT INTO Genres (genre_id, genre_name) VALUES ("2", "Comedy");
INSERT INTO Genres (genre_id, genre_name) VALUES ("3", "Drama");

-- Insert data into Audiences table
INSERT INTO Audiences (username, password_, name_, surname) VALUES ("user1", "password1", "John", "Doe");
INSERT INTO Audiences (username, password_, name_, surname) VALUES ("user2", "password2", "Jane", "Doe");
-- INSERT INTO Audiences (username, password_, name_, surname) VALUES ("user2", "password3", "JaneX", "DoeX"); Duplicate username


-- Insert data into Directors table
INSERT INTO Directors (username, password_, name_, surname, nationality, platform_id) VALUES ("nuri_bilge", "sanatsever123", "Nuri Bilge", "Ceylan", "Turkish", "rotten_tomatoes");
INSERT INTO Directors (username, password_, name_, surname, nationality, platform_id) VALUES ("quentin", "killbill123", "Quentin", "Tarantino", "American", "imdb");
INSERT INTO Directors (username, password_, name_, surname, nationality, platform_id) VALUES ("francis", "francis123456789", "Francis", "Coppola", "American", "imdb");

-- Insert data into Movies table
INSERT INTO Movies (movie_id, movie_name, duration, director_username, average_rating) VALUES ("1", "Pulp Fiction", 3, "quentin", null);
INSERT INTO Movies (movie_id, movie_name, duration, director_username, average_rating) VALUES ("2", "Once Upon a Time in Hollywood", 4 , "quentin", null);
INSERT INTO Movies (movie_id, movie_name, duration, director_username, average_rating) VALUES ("3", "The Godfather", 4 , "francis", null);
INSERT INTO Movies (movie_id, movie_name, duration, director_username, average_rating) VALUES ("4", "The Godfather2", 4 , "francis", null);
INSERT INTO Movies (movie_id, movie_name, duration, director_username, average_rating) VALUES ("5", "The Godfather3", 4 , "francis", null);


-- Insert data into MovieHasGenres table
INSERT INTO MovieHasGenres (movie_id, genre_id) VALUES ("1", "2");
INSERT INTO MovieHasGenres (movie_id, genre_id) VALUES ("1", "3");
INSERT INTO MovieHasGenres (movie_id, genre_id) VALUES ("2", "2");
INSERT INTO MovieHasGenres (movie_id, genre_id) VALUES ("2", "3");

-- Insert data into Subscribes table
INSERT INTO Subscribes (username, platform_id) VALUES ("user1", "rotten_tomatoes");
INSERT INTO Subscribes (username, platform_id) VALUES ("user2", "imdb");

-- Insert data into Rates table
INSERT INTO Rates (username, movie_id, rating) VALUES ("user1", "1", 9);
-- INSERT INTO Rates (username, movie_id, rating) VALUES ("user1", "1", 10); Duplicate rate by the same user
INSERT INTO Rates (username, movie_id, rating) VALUES ("user2", "1", 6);
INSERT INTO Rates (username, movie_id, rating) VALUES ("user2", "2", 7);



-- Insert data into Theaters table
INSERT INTO Theaters (theater_id, theater_name, theater_capacity, theater_district) VALUES ("1", "Cinemax", 100, "Central");
-- INSERT INTO Theaters (theater_id, theater_name, theater_capacity, theater_district) VALUES ("2", "Cinemax", 100, "Central"); -- Duplicate theater_id
INSERT INTO Theaters (theater_id, theater_name, theater_capacity, theater_district) VALUES ("2", "IMAX", 200, "East");

-- Insert data into MovieSessions table
INSERT INTO MovieSessions (session_id, movie_id, theater_id, date_, time_slot) VALUES ("1", "1", "1", "2023-04-05", 3);
INSERT INTO MovieSessions (session_id, movie_id, theater_id, date_, time_slot) VALUES ("2", "2", "2", "2023-04-06", 4);

-- Insert data into BoughtTickets table
INSERT INTO BoughtTickets (username, session_id) VALUES ("user1", "1");
-- INSERT INTO BoughtTickets (username, session_id) VALUES ("user1", "1"); -- Duplicate ticket to the same session by the same user
INSERT INTO BoughtTickets (username, session_id) VALUES ("user2", "2");

-- Insert data into MoviePrerequisites table
INSERT INTO MoviePrerequisites (movie_id_predecessor, movie_id_successor) VALUES ("3", "4");
INSERT INTO MoviePrerequisites (movie_id_predecessor, movie_id_successor) VALUES ("4", "5");

-- Insert data into DatabaseManagers table
INSERT INTO DatabaseManagers (username, password_) VALUES ("admin1", "admin123456789");
-- INSERT INTO DatabaseManagers (username, password_) VALUES ("admin1", "admin12345678910"); -- Duplicate username
INSERT INTO DatabaseManagers (username, password_) VALUES ("admin2", "password123");

-- -----------------Visualizaation----------------- --

-- Select all rows from the Audiences table
SELECT * FROM Audiences;

-- Select all rows from the Directors table
SELECT * FROM Directors;

-- Select all rows from the Genres table
SELECT * FROM Genres;

-- Select all rows from the MovieHasGenres table
SELECT * FROM MovieHasGenres;

-- Select all rows from the Movies table
SELECT * FROM Movies;

-- Select all rows from the RatingPlatforms table
SELECT * FROM RatingPlatforms;

-- Select all rows from the Rates table
SELECT * FROM Rates;

-- Select all rows from the Subscribes table
SELECT * FROM Subscribes;

-- Select all rows from the Theaters table
SELECT * FROM Theaters;

-- Select all rows from the MovieSessions table
SELECT * FROM MovieSessions;

-- Select all rows from the BoughtTickets table
SELECT * FROM BoughtTickets;

-- Select all rows from the MoviePrerequisites table
SELECT * FROM MoviePrerequisites;

-- Select all rows from the DatabaseManagers table
SELECT * FROM DatabaseManagers;





