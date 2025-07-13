CREATE OR REPLACE FUNCTION calcular_total_pontos_partida(p_game_id int)
RETURNS int AS $$
DECLARE
    total_pts int;
BEGIN
    SELECT SUM(pts)
      INTO total_pts
      FROM norm_score
    WHERE game_id = p_game_id;

    RETURN total_pts;
END;
$$ LANGUAGE plpgsql;

--  DOCUMENTAÇÃO:
--      Calcula a soma total de pontos anotados em uma partida a partir da tabela **norm_score**.
--      Considera todas as linhas cujo **game_id** seja igual ao valor do parâmetro.
--      Variável **total_pts** é declarada apenas para facilitar o código.
--      Caso um jogo não exista na tabela, a função devolve NULL, permitindo ao chamador decidir como tratar.