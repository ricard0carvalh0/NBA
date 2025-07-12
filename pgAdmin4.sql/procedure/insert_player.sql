CREATE OR REPLACE PROCEDURE insert_player( p_first_name TEXT, p_last_name TEXT, p_jersey INT, p_position TEXT, p_team_id INT)
LANGUAGE plpgsql 
AS $$
DECLARE
	new_id INT;
BEGIN
	SELECT COALESCE(MAX(id), 0) + 1 INTO new_id FROM player_info;
	INSERT INTO player_info (id, first_name, last_name, Jersey, position, team_id)
	VALUES(new_id, p_first_name, p_last_name, p_jersey, p_position, p_team_id);
END;
$$

-- Documentação:
--  Essa procedure é capaz de adicionar novos jogadores na tabela de player_info, passando seu primeiro nome, sobrenome, camisa, posição e id do time;
--  Foi adicionado uma lógica de incrementação de id para cada jogador inserido, por conta do id do player ser um INT ao invés de um SERIAL.