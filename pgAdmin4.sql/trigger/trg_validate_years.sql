CREATE OR REPLACE FUNCTION validate_player_years()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.from_year IS NOT NULL AND NEW.to_year IS NOT NULL THEN
        IF NEW.from_year > NEW.to_year THEN
            RAISE EXCEPTION 'Ano de estreia não pode ser maior que o ano final.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_validate_years
BEFORE INSERT OR UPDATE ON player_info
FOR EACH ROW
EXECUTE FUNCTION validate_player_years();

-- Documentação:
--  Essa trigger é responsável por validar o ano de estreia do jogador, garantindo que o ano de estreia não seja o ano final dele na carreira.

--  Exemplo de funcionamento:
--	INSERT INTO player_info (id, first_name, last_name, Jersey, position, team_id, from_year, to_year)
--	VALUES(x, 'Pascal', 'Siakam', 100, 'PF', y, 2025, 2019);
	
--	Retorna erro: Ano de estreia não pode ser maior que o ano final.