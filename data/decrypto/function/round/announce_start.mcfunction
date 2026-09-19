scoreboard players operation #ctx dc_ctx = @s dc_id
tag @a[tag=dc.round_audience] remove dc.round_audience
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run tag @s add dc.round_audience
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.round_audience] [{"text":"[谍报风云] 第 ","color":"aqua"},{"score":{"name":"@s","objective":"dc_round"},"color":"yellow"},{"text":" / ","color":"gray"},{"text":"5","color":"yellow"},{"text":" 回合开始","color":"gold"}]
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.round_audience] [{"text":"[谍报风云] 第 ","color":"aqua"},{"score":{"name":"@s","objective":"dc_round"},"color":"yellow"},{"text":" / ","color":"gray"},{"score":{"name":"@s","objective":"dc_round_limit"},"color":"yellow"},{"text":" 回合开始","color":"gold"}]
tag @a[tag=dc.round_audience] remove dc.round_audience
