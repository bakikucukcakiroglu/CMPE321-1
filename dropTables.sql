
-- Foreign Key dependencies of Relations are determined. A Relation can be dropped safely when no relation left in its "Foreign Key of" list. 
-- That means if "Foreign Key of" list is empty or all elements on the list are already dropped, corresponding Relation can be safely dropped.

DROP TABLE IF EXISTS DatabaseManagers; 		-- Foreign Key of []

DROP TABLE IF EXISTS MovieHasGenres;			-- Foreign Key of []

DROP TABLE IF EXISTS Subscribes;				-- Foreign Key of []

DROP TABLE IF EXISTS Rates;					-- Foreign Key of []

DROP TABLE IF EXISTS BoughtTickets;			-- Foreign Key of []

DROP TABLE IF EXISTS MoviePrerequisites;		-- Foreign Key of []

DROP TABLE IF EXISTS MovieSessions;			-- Foreign Key of [BoughtTickets]  --> BoughtTickets dropped

DROP TABLE IF EXISTS Theaters;				-- Foreign Key of [MovieSessions]  --> MovieSessions dropped

DROP TABLE IF EXISTS Genres;					-- Foreign Key of [MovieHasGenres] --> MovieHasGenres dropped

DROP TABLE IF EXISTS Audiences;				-- Foreign Key of [Subscribes, Rates, BoughtTickets] --> Subscribes, Rates and, BoughtTickets dropped

DROP TABLE IF EXISTS Movies;					-- Foreign Key of [MovieHasGenres, Rates, MovieSessions, MoviePrerequisites]  --> MovieHasGenres, Rates, MovieSessions and, MoviePrerequisites dropped

DROP TABLE IF EXISTS Directors;				-- Foreign Key of [Movies]  --> Movies dropped

DROP TABLE IF EXISTS RatingPlatforms;			-- Foreign Key of [Directors, Subscribes] --> Directors and Subscribes dropped









