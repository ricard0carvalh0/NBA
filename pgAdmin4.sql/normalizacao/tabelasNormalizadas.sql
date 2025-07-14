CREATE TABLE school (
    id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE
);

CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE
);

CREATE TABLE norm_player_info (
    id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    display_first_last VARCHAR(40),
    display_last_comma_first VARCHAR(40),
    display_fi_last VARCHAR(40),
    player_slug VARCHAR(40),
    birthdate DATE,
    last_affiliation VARCHAR(70),
    height VARCHAR (5),
    weight VARCHAR(20),
    season_exp INT,
    jersey VARCHAR(20),
    position VARCHAR(8),
    rosterstatus VARCHAR(10),
    games_played_current_season_flag VARCHAR(1),
    team_id INT,
    playercode VARCHAR(60),
    from_year INT,
    to_year INT,
    dleague_flag VARCHAR(1),
    nba_flag VARCHAR(1),
    games_played_flag VARCHAR(1),
    draft_year VARCHAR(12),
    draft_round VARCHAR(12),
    draft_number VARCHAR(12),
    greatest_75_flag VARCHAR(1),
    school_id INT REFERENCES school(id),
    country_id INT REFERENCES country(id)
);

CREATE TABLE norm_player_combine_stats (
    season INT,
    player_id INT,
    height_wo_shoes VARCHAR(10),
    height_wo_shoes_ft_in VARCHAR(10),
    height_w_shoes VARCHAR(10),
    height_w_shoes_ft_in VARCHAR(10),
    wingspan FLOAT,
    wingspan_ft_in VARCHAR(10),
    standing_reach FLOAT,
    standing_reach_ft_in VARCHAR(10),
    body_fat_pct FLOAT,
    hand_length FLOAT,
    hand_width FLOAT,
    standing_vertical_leap FLOAT,
    max_vertical_leap FLOAT,
    lane_agility_time FLOAT,
    modified_lane_agility_time FLOAT,
    three_quarter_sprint FLOAT,
    bench_press FLOAT,
    PRIMARY KEY (season, player_id),
    FOREIGN KEY (player_id) REFERENCES norm_player_info(id)
);

CREATE TABLE norm_player_fifteen_college_nba_stats (
    season INT,
    player_id INT,
    college_fifteen_nba VARCHAR (10),
    spot_corner_left VARCHAR(10),
    spot_break_left VARCHAR(10),
    spot_top_key VARCHAR(10),
    spot_break_right VARCHAR(10),
    spot_corner_right VARCHAR(10),
    off_drib_break_left VARCHAR(10),
    off_drib_top_key VARCHAR(10),
    off_drib_break_right VARCHAR(10),
    on_move VARCHAR(10),
    PRIMARY KEY (season, player_id),
    FOREIGN KEY (player_id) REFERENCES norm_player_info(id)
);
  
CREATE TABLE norm_draft_history (
    player_id INT,
    season INT,
    round_number INT,
    round_pick INT,
    overall_pick INT,
    draft_type VARCHAR(12),
    team_id INT,
    organization VARCHAR(60),
    organization_type VARCHAR(20),
    player_profile_flag INT,
    PRIMARY KEY (player_id, season),
    FOREIGN KEY (player_id) REFERENCES norm_player_info(id),
    FOREIGN KEY (team_id) REFERENCES norm_team(id)
);

CREATE TABLE norm_game (
    season_id INT,
    team_id INT,
    game_id INT,
    home_or_away varchar (1),
    matchup VARCHAR(15),
    wl VARCHAR(1),
    min INT,
    fgm FLOAT,
    fga FLOAT,
    fg_pct FLOAT,
    fg3m FLOAT,
    fg3a FLOAT,
    fg3_pct FLOAT,
    ftm FLOAT,
    fta FLOAT,
    ft_pct FLOAT,
    oreb FLOAT,
    dreb FLOAT,
    reb FLOAT,
    ast FLOAT,
    stl FLOAT,
    blk FLOAT,
    tov FLOAT,
    pf FLOAT,
    pts FLOAT,
    plus_minus INT,
    video_available INT,
    season_type VARCHAR(15),
    PRIMARY KEY ( game_id, team_id);),
    FOREIGN KEY (team_id) REFERENCES norm_team(id)
);

CREATE TABLE norm_game_info (
    game_id INT PRIMARY KEY,
    game_date DATE,
    attendance INT,
    game_time VARCHAR(12),
    FOREIGN KEY (game_id) REFERENCES norm_game(game_id)
);

CREATE TABLE norm_game_summary (
    game_date_est DATE,
    game_sequence INT,
    game_id INT,
    game_status_id INT,
    game_status_text VARCHAR(12),
    gamecode VARCHAR(40),
    home_or_away VARCHAR(1),
    team_id INT,
    season INT,
    live_period INT,
    live_pc_time VARCHAR(10),
    natl_tv_broadcaster_abbreviation VARCHAR(20),
    live_period_time_bcast VARCHAR(25),
    wh_status INT,
    PRIMARY KEY (game_id, home_or_away),
    FOREIGN KEY (team_id) REFERENCES norm_team(id),
    FOREIGN KEY (game_id) REFERENCES norm_game(game_id)
);

CREATE TABLE norm_line_score (
    game_date_est DATE,
    game_sequence INT,
    game_id INT,
    team_id INT,
	home_or_away varchar (1),
    team_wins_losses varchar (15),
    pts INT,
    PRIMARY KEY (game_id, team_id),
    FOREIGN KEY (game_id) REFERENCES norm_game(game_id),
    FOREIGN KEY (team_id) REFERENCES norm_team(id)
);

CREATE TABLE norm_score (
	game_id INT,
	team_id INT,
	home_or_away varchar (1),
    pts_qtr1 INT,
    pts_qtr2 INT,
    pts_qtr3 INT,
    pts_qtr4 INT,
    pts_ot1 INT,
    pts_ot2 INT,
    pts_ot3 INT,
    pts_ot4 INT,
    pts_ot5 INT,
    pts_ot6 INT,
    pts_ot7 INT,
    pts_ot8 INT,
    pts_ot9 INT,
    pts_ot10 INT,
    pts INT 
);

CREATE TABLE norm_officials (
    game_id INT,
    official_id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    jersey_num INT,
    PRIMARY KEY (game_id, official_id),
    FOREIGN KEY (game_id) REFERENCES norm_game(game_id)
);

CREATE TABLE norm_other_stats (
    game_id INT,
    league_id INT,
    team_id INT,
    home_or_away varchar (1),
    pts_paint INT,
    pts_2nd_chance INT,
    pts_fb INT,
    largest_lead INT,
    lead_changes INT,
    times_tied INT,
    team_turnovers INT,
    total_turnovers INT,
    team_rebounds INT,
    pts_off_to INT,
    PRIMARY KEY (game_id, home_or_away),
    FOREIGN KEY (game_id) REFERENCES norm_game(game_id),
    FOREIGN KEY (team_id) REFERENCES norm_team(id)
);

CREATE TABLE norm_play_by_play (
    game_id INT,
	season INT,
    eventnum INT,
    eventmsgtype INT,
    eventmsgactiontype INT,
    period INT,
    wctimestring VARCHAR (10),
    pctimestring VARCHAR (8),
    flag_description VARCHAR (10),
    description VARCHAR (100),
    score VARCHAR(10),
    scoremargin VARCHAR(4),
    flag_player VARCHAR (1),
    persontype INT,
    player_id INT,
    player_team_id INT,
    video_available_flag INT,
    PRIMARY KEY (game_id, eventnum, player_id, flag_description),
    FOREIGN KEY (game_id) REFERENCES norm_game(game_id),
    FOREIGN KEY (player_id) REFERENCES norm_player_info(id),
    FOREIGN KEY (player_team_id) REFERENCES norm_team(id)
);

CREATE TABLE norm_team (
    id INT PRIMARY KEY,
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