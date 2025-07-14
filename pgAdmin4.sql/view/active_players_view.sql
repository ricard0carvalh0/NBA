CREATE OR REPLACE VIEW active_players_view AS
SELECT
    p.id AS id,
    INITCAP(p.first_name || ' ' || p.last_name) AS full_name,
    p.first_name,
    p.last_name,
    p.rosterstatus
FROM norm_player_info p
WHERE p.rosterstatus = 'Active';

-- Documentação:
--  Essa view retorna todos os jogadores em atividade presentes no banco de dados (active_players);
--  Além das informações exibidas, existe uma condição where e um INITCAP;
--  O initicap serve para fazer a concatenação do primeiro e último nome do jogador;
--  Já a condição é para justamente filtrar apenas jogadores a partir do rosterstatus presente na tabela player_info.

-- Chamada: SELECT * FROM active_players_view;