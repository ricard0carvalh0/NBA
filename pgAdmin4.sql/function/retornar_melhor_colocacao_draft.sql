CREATE OR REPLACE FUNCTION retornar_melhor_colocacao_draft(p_player_id int) 
RETURNS int
STABLE               
AS $$
BEGIN
   	SELECT MIN(overall_pick)               
      FROM norm_draft_history
    WHERE player_id = p_player_id;
END;
$$ LANGUAGE plpgsql;

--  DOCUMENTAÇÃO:
--    Informa a melhor colocação (menor valor de *overall_pick*) que um jogador já alcançou em todas as edições do draft registradas na tabela **norm_draft_history**.
--    Recebe como parâmetro o identificador de qualquer jogador e retorna o número da colocação.
--    Caso exista mais de um ano de draft para o mesmo atleta (situação rara), a função sempre retorna a melhor posição alcançada.
--    Marquei a função como STABLE, permitindo que o otimizador a avalie apenas uma vez por linha quando usada em WHERE ou SELECT dentro de uma view ou consulta mais complexa.
--    Se o atleta nunca tiver sido draftado, o resultado é NULL