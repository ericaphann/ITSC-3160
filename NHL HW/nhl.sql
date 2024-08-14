DROP DATABASE IF EXISTS NHL;
CREATE DATABASE NHL;
USE NHL;

DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS game; 
DROP TABLE IF EXISTS belongs;
DROP TABLE IF EXISTS plays;
DROP TABLE IF EXISTS injury_record;

CREATE TABLE team (
	tname VARCHAR(50) NOT NULL,
    city VARCHAR(30) NOT NULL,
    coach VARCHAR(50) NOT NULL,
    captain VARCHAR(50) NOT NULL,
    player VARCHAR(50) NOT NULL,
    PRIMARY KEY(tname)
);

CREATE TABLE player(
	pname VARCHAR(50) NOT NULL,
    position VARCHAR(50),
    skill_level VARCHAR(50),
    PRIMARY KEY(pname)
);

CREATE TABLE belongs(
	pname VARCHAR(50) NOT NULL,
    tname VARCHAR(50) NOT NULL,
	position VARCHAR(50) NOT NULL,
    skill_level VARCHAR(50) NOT NULL,
    PRIMARY KEY(pname, tname), 
    FOREIGN KEY(pname) REFERENCES player(pname),
	FOREIGN KEY(tname) REFERENCES team(tname)

);


CREATE TABLE game_played(
	host_team VARCHAR(50) NOT NULL,
	guest_team VARCHAR(50) NOT NULL,
    score VARCHAR(3) NOT NULL,
    date DATE NOT NULL,
    constraint unique_team UNIQUE (host_team, guest_team)
);


CREATE TABLE injury_record(
	pname VARCHAR(50) NOT NULL,
	id VARCHAR(10) NOT NULL,
    description VARCHAR(100) NOT NULL,
    PRIMARY KEY(id, pname),
    FOREIGN KEY (pname) REFERENCES player(pname)
);

INSERT INTO player VALUES('Tony DeAngelo', 'Defense', null);
INSERT INTO player VALUES('Chris Kreider', 'Winger', null);
INSERT INTO player VALUES('Oliver Ekman-Larsson', 'Defense', null);
INSERT INTO player VALUES('Lawson Crouse', 'Winger', null);
INSERT INTO team VALUES ('Rangers', 'New York', 'David Quinn', 'Chris Kreider','Tony DeAngelo');
INSERT INTO team VALUES('Coyotes', 'Arizona', 'Rick Tocchet', 'Oliver Ekman-Larsson', 'Lawson Crouse');
INSERT INTO game_played VALUES ('Rangers', 'Coyotes', '4-2', '2019-03-04');
INSERT INTO game_played VALUES ('Coyotes', 'Rangers', '3-4', '2020-10-22');
INSERT INTO injury_record VALUES('Tony DeAngelo', 0028374658, 'Pulled hamstring on 10/22/2020. Cannot play for two weeks.');

SELECT *
FROM team;

SELECT *
FROM player;

SELECT t_host.captain AS host_captain, t_guest.captain AS guest_captain, score, date
FROM game_played g
JOIN team t_host ON g.host_team = t_host.tname
JOIN team t_guest ON g.guest_team = t_guest.tname;

SELECT *
FROM game_played;

SELECT *
FROM injury_record;



