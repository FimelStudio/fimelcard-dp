execute if score #v_length go_ctx matches 1.. unless score #v_owner go_ctx matches 0 run function weiqi:visual/territory_strip
scoreboard players set #v_length go_ctx 0
scoreboard players set #v_owner go_ctx 0
