CREATE OR REPLACE FUNCTION validate_jersey_number()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.jersey IS NULL OR NEW.jersey <= 0 OR NEW.jersey >= 99 THEN
		RAISE EXCEPTION 'Número da camisa inválido: deve estar entre 0 e 99 (inclusive 0, 00 e 99)';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validate_jersey
BEFORE INSERT OR UPDATE ON player_info
FOR EACH ROW
EXECUTE FUNCTION validate_jersey_number();

-- Documentação 
--  Essa trigger é responsável por validar o número da camisa do jogador sempre que houver uma inserção ou update na tabela player_info;
--  Ela respeita a regra na NBA de só ter camisas de numeração entre 0 e 99, incluindo ambos e o 00;

--  Exemplo de funcionamento:
--  INSERT INTO player_info (id, first_name, last_name, Jersey, position, team_id)
--	VALUES(x, 'Pascal', 'Siakam', 100, 'PF', y)
	
--	Retorna erro; Número da camisa inválido: deve estar entre 0 e 99 (inclusive 0, 00 e 99)