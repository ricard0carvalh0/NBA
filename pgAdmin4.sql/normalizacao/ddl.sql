CREATE TABLE IF NOT EXISTS normalizada.country
(
    id serial NOT NULL,
    name character varying COLLATE pg_catalog."default",
    CONSTRAINT country_pkey PRIMARY KEY (id),
    CONSTRAINT country_name_key UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_draft_history
(
    player_id integer NOT NULL,
    season integer NOT NULL,
    round_number integer,
    round_pick integer,
    overall_pick integer,
    draft_type character varying(12) COLLATE pg_catalog."default",
    team_id integer,
    organization character varying(60) COLLATE pg_catalog."default",
    organization_type character varying(20) COLLATE pg_catalog."default",
    player_profile_flag integer,
    CONSTRAINT norm_draft_history_pkey PRIMARY KEY (player_id, season)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_game
(
    season_id integer,
    team_id integer,
    game_id integer NOT NULL,
    home_or_away character varying(1) COLLATE pg_catalog."default",
    matchup character varying(15) COLLATE pg_catalog."default",
    wl character varying(1) COLLATE pg_catalog."default",
    min integer,
    fgm double precision,
    fga double precision,
    fg_pct double precision,
    fg3m double precision,
    fg3a double precision,
    fg3_pct double precision,
    ftm double precision,
    fta double precision,
    ft_pct double precision,
    oreb double precision,
    dreb double precision,
    reb double precision,
    ast double precision,
    stl double precision,
    blk double precision,
    tov double precision,
    pf double precision,
    pts double precision,
    plus_minus integer,
    video_available integer,
    season_type character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT norm_game_pkey PRIMARY KEY (game_id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_game_info
(
    game_id integer NOT NULL,
    game_date date,
    attendance integer,
    game_time character varying(12) COLLATE pg_catalog."default",
    CONSTRAINT norm_game_info_pkey PRIMARY KEY (game_id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_game_summary
(
    game_date_est date,
    game_sequence integer,
    game_id integer NOT NULL,
    game_status_id integer,
    game_status_text character varying(12) COLLATE pg_catalog."default",
    gamecode character varying(40) COLLATE pg_catalog."default",
    home_or_away character varying(1) COLLATE pg_catalog."default",
    team_id integer,
    season integer,
    live_period integer,
    live_pc_time character varying(10) COLLATE pg_catalog."default",
    natl_tv_broadcaster_abbreviation character varying(20) COLLATE pg_catalog."default",
    live_period_time_bcast character varying(25) COLLATE pg_catalog."default",
    wh_status integer,
    CONSTRAINT norm_game_summary_pkey PRIMARY KEY (game_id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_line_score
(
    game_date_est date,
    game_sequence integer,
    game_id integer NOT NULL,
    team_id integer NOT NULL,
    home_or_away character varying(1) COLLATE pg_catalog."default",
    team_wins_losses character varying(15) COLLATE pg_catalog."default",
    pts integer,
    CONSTRAINT norm_line_score_pkey PRIMARY KEY (game_id, team_id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_officials
(
    game_id integer NOT NULL,
    official_id integer NOT NULL,
    first_name character varying(20) COLLATE pg_catalog."default",
    last_name character varying(20) COLLATE pg_catalog."default",
    jersey_num integer,
    CONSTRAINT norm_officials_pkey PRIMARY KEY (game_id, official_id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_other_stats
(
    game_id integer NOT NULL,
    league_id integer,
    team_id integer,
    home_or_away character varying(1) COLLATE pg_catalog."default",
    pts_paint integer,
    pts_2nd_chance integer,
    pts_fb integer,
    largest_lead integer,
    lead_changes integer,
    times_tied integer,
    team_turnovers integer,
    total_turnovers integer,
    team_rebounds integer,
    pts_off_to integer,
    CONSTRAINT norm_other_stats_pkey PRIMARY KEY (game_id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_play_by_play
(
    game_id integer NOT NULL,
    season integer,
    eventnum integer NOT NULL,
    eventmsgtype integer,
    eventmsgactiontype integer,
    period integer,
    wctimestring character varying(10) COLLATE pg_catalog."default",
    pctimestring character varying(8) COLLATE pg_catalog."default",
    flag_description character varying(10) COLLATE pg_catalog."default",
    description character varying(100) COLLATE pg_catalog."default",
    score character varying(10) COLLATE pg_catalog."default",
    scoremargin character varying(4) COLLATE pg_catalog."default",
    flag_player character varying(1) COLLATE pg_catalog."default",
    persontype integer,
    player_id integer,
    player_team_id integer,
    video_available_flag integer,
    CONSTRAINT norm_play_by_play_pkey PRIMARY KEY (game_id, eventnum)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_player_combine_stats
(
    season integer NOT NULL,
    player_id integer NOT NULL,
    height_wo_shoes character varying(10) COLLATE pg_catalog."default",
    height_wo_shoes_ft_in character varying(10) COLLATE pg_catalog."default",
    height_w_shoes character varying(10) COLLATE pg_catalog."default",
    height_w_shoes_ft_in character varying(10) COLLATE pg_catalog."default",
    wingspan double precision,
    wingspan_ft_in character varying(10) COLLATE pg_catalog."default",
    standing_reach double precision,
    standing_reach_ft_in character varying(10) COLLATE pg_catalog."default",
    body_fat_pct double precision,
    hand_length double precision,
    hand_width double precision,
    standing_vertical_leap double precision,
    max_vertical_leap double precision,
    lane_agility_time double precision,
    modified_lane_agility_time double precision,
    three_quarter_sprint double precision,
    bench_press double precision,
    CONSTRAINT norm_player_combine_stats_pkey PRIMARY KEY (season, player_id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_player_fifteen_college_nba_stats
(
    season integer NOT NULL,
    player_id integer NOT NULL,
    college_fifteen_nba character varying(10) COLLATE pg_catalog."default",
    spot_corner_left character varying(10) COLLATE pg_catalog."default",
    spot_break_left character varying(10) COLLATE pg_catalog."default",
    spot_top_key character varying(10) COLLATE pg_catalog."default",
    spot_break_right character varying(10) COLLATE pg_catalog."default",
    spot_corner_right character varying(10) COLLATE pg_catalog."default",
    off_drib_break_left character varying(10) COLLATE pg_catalog."default",
    off_drib_top_key character varying(10) COLLATE pg_catalog."default",
    off_drib_break_right character varying(10) COLLATE pg_catalog."default",
    on_move character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT norm_player_fifteen_college_nba_stats_pkey PRIMARY KEY (season, player_id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_player_info
(
    id integer NOT NULL,
    first_name character varying(20) COLLATE pg_catalog."default",
    last_name character varying(20) COLLATE pg_catalog."default",
    display_first_last character varying(40) COLLATE pg_catalog."default",
    display_last_comma_first character varying(40) COLLATE pg_catalog."default",
    display_fi_last character varying(40) COLLATE pg_catalog."default",
    player_slug character varying(40) COLLATE pg_catalog."default",
    birthdate date,
    last_affiliation character varying(70) COLLATE pg_catalog."default",
    height character varying(5) COLLATE pg_catalog."default",
    weight double precision,
    season_exp integer,
    jersey integer,
    "position" character varying(8) COLLATE pg_catalog."default",
    rosterstatus character varying(10) COLLATE pg_catalog."default",
    games_played_current_season_flag character varying(1) COLLATE pg_catalog."default",
    team_id integer,
    playercode character varying(60) COLLATE pg_catalog."default",
    from_year integer,
    to_year integer,
    dleague_flag character varying(1) COLLATE pg_catalog."default",
    nba_flag character varying(1) COLLATE pg_catalog."default",
    games_played_flag character varying(1) COLLATE pg_catalog."default",
    draft_year character varying(12) COLLATE pg_catalog."default",
    draft_round character varying(12) COLLATE pg_catalog."default",
    draft_number character varying(12) COLLATE pg_catalog."default",
    greatest_75_flag character varying(1) COLLATE pg_catalog."default",
    school_id integer,
    country_id integer,
    CONSTRAINT norm_player_info_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS normalizada.norm_score
(
    game_id integer,
    team_id integer,
    home_or_away character varying(1) COLLATE pg_catalog."default",
    pts_qtr1 integer,
    pts_qtr2 integer,
    pts_qtr3 integer,
    pts_qtr4 integer,
    pts_ot1 integer,
    pts_ot2 integer,
    pts_ot3 integer,
    pts_ot4 integer,
    pts_ot5 integer,
    pts_ot6 integer,
    pts_ot7 integer,
    pts_ot8 integer,
    pts_ot9 integer,
    pts_ot10 integer,
    pts integer
);

CREATE TABLE IF NOT EXISTS normalizada.norm_team
(
    id integer NOT NULL,
    abbreviation character varying(3) COLLATE pg_catalog."default",
    nickname character varying(20) COLLATE pg_catalog."default",
    city character varying(30) COLLATE pg_catalog."default",
    state character varying(30) COLLATE pg_catalog."default",
    arena character varying(50) COLLATE pg_catalog."default",
    arenacapacity integer,
    owner character varying(40) COLLATE pg_catalog."default",
    generalmanager character varying(40) COLLATE pg_catalog."default",
    headcoach character varying(40) COLLATE pg_catalog."default",
    dleagueaffiliation character varying(70) COLLATE pg_catalog."default",
    year_founded integer,
    year_active_till integer,
    CONSTRAINT norm_team_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS normalizada.school
(
    id serial NOT NULL,
    name character varying COLLATE pg_catalog."default",
    CONSTRAINT school_pkey PRIMARY KEY (id),
    CONSTRAINT school_name_key UNIQUE (name)
);

ALTER TABLE IF EXISTS normalizada.norm_draft_history
    ADD CONSTRAINT norm_draft_history_player_id_fkey FOREIGN KEY (player_id)
    REFERENCES normalizada.norm_player_info (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_draft_history
    ADD CONSTRAINT norm_draft_history_team_id_fkey FOREIGN KEY (team_id)
    REFERENCES normalizada.norm_team (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_game
    ADD CONSTRAINT norm_game_team_id_fkey FOREIGN KEY (team_id)
    REFERENCES normalizada.norm_team (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_game_info
    ADD CONSTRAINT norm_game_info_game_id_fkey FOREIGN KEY (game_id)
    REFERENCES normalizada.norm_game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
CREATE INDEX IF NOT EXISTS norm_game_info_pkey
    ON normalizada.norm_game_info(game_id);


ALTER TABLE IF EXISTS normalizada.norm_game_summary
    ADD CONSTRAINT norm_game_summary_game_id_fkey FOREIGN KEY (game_id)
    REFERENCES normalizada.norm_game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
CREATE INDEX IF NOT EXISTS norm_game_summary_pkey
    ON normalizada.norm_game_summary(game_id);


ALTER TABLE IF EXISTS normalizada.norm_game_summary
    ADD CONSTRAINT norm_game_summary_team_id_fkey FOREIGN KEY (team_id)
    REFERENCES normalizada.norm_team (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_line_score
    ADD CONSTRAINT norm_line_score_game_id_fkey FOREIGN KEY (game_id)
    REFERENCES normalizada.norm_game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_line_score
    ADD CONSTRAINT norm_line_score_team_id_fkey FOREIGN KEY (team_id)
    REFERENCES normalizada.norm_team (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_officials
    ADD CONSTRAINT norm_officials_game_id_fkey FOREIGN KEY (game_id)
    REFERENCES normalizada.norm_game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_other_stats
    ADD CONSTRAINT norm_other_stats_game_id_fkey FOREIGN KEY (game_id)
    REFERENCES normalizada.norm_game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
CREATE INDEX IF NOT EXISTS norm_other_stats_pkey
    ON normalizada.norm_other_stats(game_id);


ALTER TABLE IF EXISTS normalizada.norm_other_stats
    ADD CONSTRAINT norm_other_stats_team_id_fkey FOREIGN KEY (team_id)
    REFERENCES normalizada.norm_team (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_play_by_play
    ADD CONSTRAINT norm_play_by_play_game_id_fkey FOREIGN KEY (game_id)
    REFERENCES normalizada.norm_game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_play_by_play
    ADD CONSTRAINT norm_play_by_play_player_id_fkey FOREIGN KEY (player_id)
    REFERENCES normalizada.norm_player_info (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_play_by_play
    ADD CONSTRAINT norm_play_by_play_player_team_id_fkey FOREIGN KEY (player_team_id)
    REFERENCES normalizada.norm_team (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_player_combine_stats
    ADD CONSTRAINT norm_player_combine_stats_player_id_fkey FOREIGN KEY (player_id)
    REFERENCES normalizada.norm_player_info (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_player_fifteen_college_nba_stats
    ADD CONSTRAINT norm_player_fifteen_college_nba_stats_player_id_fkey FOREIGN KEY (player_id)
    REFERENCES normalizada.norm_player_info (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_player_info
    ADD CONSTRAINT norm_player_info_country_id_fkey FOREIGN KEY (country_id)
    REFERENCES normalizada.country (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS normalizada.norm_player_info
    ADD CONSTRAINT norm_player_info_school_id_fkey FOREIGN KEY (school_id)
    REFERENCES normalizada.school (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;