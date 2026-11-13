scoreboard players set @s gd_auto 0
execute unless score @s gd_lastkind matches 1..10 run return 0
scoreboard players operation #actor gd_ctx = @s gd_turn
function guandan:cards/context
scoreboard players set #probe_hint gd_ctx 0
function guandan:autopass/probe
execute if score #probe_available gd_ctx matches 1 run return 0
scoreboard players set @s gd_auto 100
execute as @a[tag=gd.audience] if score @s gd_seat = #actor gd_ctx run tellraw @s {text:"[掼蛋] 没有能压过上一手的牌，5秒后自动不出。",color:"yellow"}
