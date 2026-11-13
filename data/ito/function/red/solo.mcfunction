# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function ito:red/validate
execute unless score #red_valid it_ctx matches 1 run return 0
execute unless score @s it_win_epoch = @e[tag=it.current,limit=1] it_epoch run return 0
scoreboard players set @s it_done 1
scoreboard players set @s it_sum 0
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx run function ito:game/reveal
execute as @e[tag=it.current,limit=1] at @s run function ito:red/check
