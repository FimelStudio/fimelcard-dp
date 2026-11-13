execute unless score @s dc_gp = #guess_phase dc_ctx run function decrypto:guess/reset_draft
execute unless score @s dc_gr = @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_round run function decrypto:guess/reset_draft
scoreboard players set #guess_invalid dc_ctx 0
function decrypto:guess/render
