CREATE TABLE dim_player (
    player_sk SERIAL PRIMARY KEY,
    player_id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    player_slug VARCHAR(40),
    birthdate DATE,
    height VARCHAR(5),
    weight FLOAT,
    position VARCHAR(8),
    rosterstatus VARCHAR(10),
    team_id INT,
    draft_year VARCHAR(12),
    draft_round VARCHAR(12),
    draft_number VARCHAR(12),
    country_name INT,
    school_name INT
);

CREATE TABLE dim_team (
    team_sk SERIAL PRIMARY KEY,
    team_id INT,
    abbreviation VARCHAR(3),
    nickname VARCHAR(20),
    city VARCHAR(30),
    state VARCHAR(30),
    arena VARCHAR(50),
    arenacapacity INT,
    owner VARCHAR(40),
    generalmanager VARCHAR(40),
    headcoach VARCHAR(40),
    dleagueaffiliation VARCHAR(70),
    year_founded INT,
    year_active_till INT
);

CREATE TABLE dim_official (
    official_sk SERIAL PRIMARY KEY,
    official_id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    jersey_num INT
);

CREATE TABLE dim_line_score (
    line_score_sk SERIAL PRIMARY KEY,
    game_id INT,
    game_date DATE,
    team_id INT,
    home_or_away VARCHAR(1),
    team_wins_losses VARCHAR(15),
    pts_qtr1 INT,
    pts_qtr2 INT,
    pts_qtr3 INT,
    pts_qtr4 INT,
    pts_ot1 INT,
    pts_ot2 INT,
    pts_ot3 INT,
    pts_ot4 INT,
    pts_ot5 INT,--só temos dados até pts_ot5 (aqui) 
    pts INT
);

CREATE TABLE dim_tempo (
    tempo_sk SERIAL PRIMARY KEY,
    data DATE,
    dia INT,
    mes INT,
    ano INT,
    trimestre INT
);

CREATE TABLE dim_hora (
    hora_sk SERIAL PRIMARY KEY,
    hora INT,
    minuto INT,
    segundo INT,
    turno VARCHAR(15)
);

CREATE TABLE dim_plays (
    play_sk SERIAL PRIMARY KEY,
    game_id INT,
    season INT,
    eventnum INT,
    eventmsgtype INT,
    eventmsgactiontype INT,
    period INT,
    flag_description VARCHAR(10),
    description VARCHAR(150),
    score VARCHAR(10),
    scoremargin VARCHAR(4),
    flag_player VARCHAR(1),
    persontype INT,
    video_available_flag INT
);


CREATE TABLE fato_play_by_play (
    fato_sk SERIAL PRIMARY KEY,
    tempo_sk INT,
    hora_sk INT,
    line_score_sk INT,
    player_sk INT,
    team_sk INT,
    official_sk INT,
    play_sk INT, 
    FOREIGN KEY (tempo_sk) REFERENCES public.dim_tempo(tempo_sk),
    FOREIGN KEY (hora_sk) REFERENCES public.dim_hora(hora_sk),
    FOREIGN KEY (line_score_sk) REFERENCES public.dim_line_score(line_score_sk),
    FOREIGN KEY (player_sk) REFERENCES public.dim_player(player_sk),
    FOREIGN KEY (team_sk) REFERENCES public.dim_team(team_sk),
    FOREIGN KEY (official_sk) REFERENCES public.dim_official(official_sk),
    FOREIGN KEY (play_sk) REFERENCES public.dim_plays(play_sk) 
);
