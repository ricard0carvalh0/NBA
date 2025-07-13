CREATE OR REPLACE VIEW jogos_acima_150_pts_view AS
SELECT
        gi.game_id,
        gi.game_date,
        calcular_total_pontos_partida(gi.game_id) AS total_pontos
FROM    norm_game_info gi
WHERE   calcular_total_pontos_partida(gi.game_id) > 150;

--  DOCUMENTAÇÃO:
--      Apresenta as partidas nas quais a soma dos pontos de ambas as equipes ultrapassa 150 pontos.
--      Utiliza a função **calcular_total_pontos_partida**.
--      Quando usada, também faz a entrega da data na qual o jogo ocorreu.