# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s sp_panel matches 1..3 run return run function splendor:ui/open
scoreboard players operation #index sp_ctx = #code sp_ctx
scoreboard players remove #index sp_ctx 200
scoreboard players set #two sp_ctx 2
scoreboard players operation #delta sp_ctx = #index sp_ctx
scoreboard players operation #delta sp_ctx %= #two sp_ctx
scoreboard players operation #index sp_ctx /= #two sp_ctx
execute if score #index sp_ctx matches 0 if score #delta sp_ctx matches 0 if score @s sp_pick0 matches 1.. run scoreboard players remove @s sp_pick0 1
execute if score #index sp_ctx matches 0 if score #delta sp_ctx matches 1 if score @s sp_pick0 matches ..9 run scoreboard players add @s sp_pick0 1
execute if score #index sp_ctx matches 1 if score #delta sp_ctx matches 0 if score @s sp_pick1 matches 1.. run scoreboard players remove @s sp_pick1 1
execute if score #index sp_ctx matches 1 if score #delta sp_ctx matches 1 if score @s sp_pick1 matches ..9 run scoreboard players add @s sp_pick1 1
execute if score #index sp_ctx matches 2 if score #delta sp_ctx matches 0 if score @s sp_pick2 matches 1.. run scoreboard players remove @s sp_pick2 1
execute if score #index sp_ctx matches 2 if score #delta sp_ctx matches 1 if score @s sp_pick2 matches ..9 run scoreboard players add @s sp_pick2 1
execute if score #index sp_ctx matches 3 if score #delta sp_ctx matches 0 if score @s sp_pick3 matches 1.. run scoreboard players remove @s sp_pick3 1
execute if score #index sp_ctx matches 3 if score #delta sp_ctx matches 1 if score @s sp_pick3 matches ..9 run scoreboard players add @s sp_pick3 1
execute if score #index sp_ctx matches 4 if score #delta sp_ctx matches 0 if score @s sp_pick4 matches 1.. run scoreboard players remove @s sp_pick4 1
execute if score #index sp_ctx matches 4 if score #delta sp_ctx matches 1 if score @s sp_pick4 matches ..9 run scoreboard players add @s sp_pick4 1
execute if score #index sp_ctx matches 5 if score #delta sp_ctx matches 0 if score @s sp_pick5 matches 1.. run scoreboard players remove @s sp_pick5 1
execute if score #index sp_ctx matches 5 if score #delta sp_ctx matches 1 if score @s sp_pick5 matches ..9 run scoreboard players add @s sp_pick5 1
function splendor:ui/editor_show
