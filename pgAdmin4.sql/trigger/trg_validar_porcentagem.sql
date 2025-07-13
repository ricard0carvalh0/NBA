CREATE OR REPLACE FUNCTION validar_porcentagem()
RETURNS trigger AS $$
BEGIN
    IF NEW.fg_pct  NOT BETWEEN 0 AND 1
       OR NEW.ft_pct  NOT BETWEEN 0 AND 1
       OR NEW.fg3_pct NOT BETWEEN 0 AND 1
    THEN
        RAISE EXCEPTION
            'Percentual fora do intervalo permitido (0–1): fg_pct=%, ft_pct=%, fg3_pct=%',
            NEW.fg_pct, NEW.ft_pct, NEW.fg3_pct;
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_validar_porcentagem
BEFORE INSERT OR UPDATE
ON norm_game
FOR EACH ROW
EXECUTE FUNCTION validar_porcentagem();

--  DOCUMENTAÇÃO:
--      Garante integridade de dados na tabela **norm_game**, impedindo que percentuais de arremesso sejam gravados fora do intervalo lógico [0, 1].
--      A trigger é disparada antes de cada operação INSERT ou UPDATE na tabela **norm_game**.
--      Caso algum valor esteja fora do intervalo permitido, a função lança uma exceção (`RAISE EXCEPTION`) e a operação é abortada.
--      Se todos os valores forem válidos, a linha (`NEW`) é retornada normalmente e permite que a transação prossiga.