CREATE OR REPLACE VIEW inactive_players_view AS
SELECT 
    p.id AS player_id,
    p.first_name,
    p.last_name,
    p.jersey AS jersey_num,
    t.id AS team_id,
    t.city AS team_city,
    t.nickname AS team_name,
    t.abbreviation AS team_abbreviation
FROM norm_player_info p
LEFT JOIN norm_team t ON p.team_id = t.id
WHERE p.rosterstatus IS DISTINCT FROM 'Active';

-- Documentação:
--  Essa view retorna todos os jogadores aposentados presentes no banco de dados (inactive players);
--  Além das informações exibidas, existe o join e condição where;
--  A condição where é usada para filtrar apenas jogadores inativos (p.rosterstatus IS DISTINCT FROM 'Active'), considerando que players inativos tenham um valor "Active";
--  O left join com team (team t ON p.team_id = t.id) significa que todos os jogadores aposentados serão considerados, inclusive aqueles que não possuem vinculo com algum time.

-- Chamada: SELECT * FROM inactive_players_view;