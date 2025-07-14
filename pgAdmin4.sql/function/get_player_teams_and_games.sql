CREATE OR REPLACE FUNCTION get_player_teams_and_games (fname TEXT, lname TEXT)
RETURNS TABLE (
	team_id INT,
	team_name TEXT,
	total_games BIGINT
) AS $$ 
BEGIN
	RETURN QUERY
	SELECT 
		pb.player_team_id AS team_id,
		t.city || ' ' || t.nickname AS team_name, 
		COUNT(DISTINCT pb.game_id) AS total_games 
	FROM norm_player_info p
	JOIN norm_play_by_play pb ON pb.player_id = p.id
	JOIN norm_team t ON t.id = pb.player_team_id
	WHERE p.first_name = fname AND p.last_name = lname
	GROUP BY pb.player_team_id, t.city, t.nickname;
END
$$ LANGUAGE plpgsql;

-- Documentação:
--  Essa é uma função que recebe como parâmetro o nome e sobrenome de um jogador e retorna uma tabela com todos os times pelos quais ele atuou ao longo da carreira, assim como a quantidade total de jogos que ele disputou por cada um desses times;
--  Foi utilizado o comando RETURN QUERY para executar e retornar diretamente os dados de uma consulta, funcionando como uma espécie de "mini view";
--  Há também a concatenação de t.city com t.nickname de team para formar o nome do time que o jogador atuou, como por exemplo "Oklahoma City Thunder".

-- Chamada: SELECT * FROM get_player_teams_and_games('Jonas', 'Valanciunas');