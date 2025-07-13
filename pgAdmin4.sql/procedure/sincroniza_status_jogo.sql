CREATE OR REPLACE PROCEDURE sincroniza_status_jogo(p_game_id int, p_status_text text)
AS $$
BEGIN
    UPDATE normalizada.norm_game_summary
       SET game_status_text = p_status_text,
           game_status_id   = CASE
                                WHEN p_status_text = 'Final'       THEN 3
                                WHEN p_status_text = 'In Progress' THEN 2
                                WHEN p_status_text = 'Scheduled'   THEN 1
                                ELSE game_status_id
                              END
     WHERE game_id = p_game_id;

    RAISE NOTICE 'Status do jogo % atualizado para "%"', p_game_id, p_status_text;
END;
$$ LANGUAGE plpgsql;

--  DOCUMENTAÇÃO:
--      Sincroniza o status textual (**game_status_text**) e o código numérico (**game_status_id**) de uma partida específica na tabela norm_game_summary.
--      A tabela utiliza os seguintes códigos internos:
--              • 1 → *Scheduled*   (agendada)
--              • 2 → *In Progress* (em andamento)
--              • 3 → *Final*       (encerrada)
--      Recebe como parâmetros o novo status do jogo e seu identificador para possibilitar a alteração.