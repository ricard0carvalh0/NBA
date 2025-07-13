CREATE OR REPLACE PROCEDURE atualizar_flag_idade_jogador(p_reference date DEFAULT current_date)
AS $$
BEGIN
    UPDATE norm_player_info
       SET games_played_current_season_flag = 'V'      
     WHERE date_part('year', age(p_reference, birthdate)) >= 35;

    UPDATE norm_player_info
       SET games_played_current_season_flag = NULL
     WHERE date_part('year', age(p_reference, birthdate)) < 35;
END;
$$ LANGUAGE plpgsql;

--  DOCUMENTAÇÃO
--    Atualiza a coluna **games_played_current_season_flag** da tabela **norm_player_info**.
--    Marca com 'V' (veterano) todos os jogadores que tenham '≥ 35' anos na data de referência informada. Para os demais jogadores, o campo é definido como NULL.
--    Caso a data não seja definida, o valor default é a data atual.