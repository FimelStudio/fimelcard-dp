execute unless score @e[tag=dd.current,limit=1] dd_type matches 0 run return run function doudizhu:action/pass
# 超时领出按点数挑最小单张，同点数用牌号确定具体牌。
scoreboard players set @e[tag=dd.hand] dd_selected 0
scoreboard players set #clock_low dd_ctx 18
execute as @e[tag=dd.hand] run scoreboard players operation #clock_low dd_ctx < @s dd_rank
scoreboard players set #clock_card dd_ctx 55
execute as @e[tag=dd.hand] if score @s dd_rank = #clock_low dd_ctx run scoreboard players operation #clock_card dd_ctx < @s dd_card
execute as @e[tag=dd.hand] if score @s dd_card = #clock_card dd_ctx run scoreboard players set @s dd_selected 1
function doudizhu:action/play
