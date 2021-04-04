CREATE TABLE badhit (
       ip	    CHAR(15)	PRIMARY KEY,
       first_seen   TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
       last_seen    TIMESTAMP,
       hitcount	    SMALLINT UNSIGNED DEFAULT 0
);
