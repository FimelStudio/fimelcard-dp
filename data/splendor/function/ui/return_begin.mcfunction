# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s sp_pick0 0
scoreboard players set @s sp_pick1 0
scoreboard players set @s sp_pick2 0
scoreboard players set @s sp_pick3 0
scoreboard players set @s sp_pick4 0
scoreboard players set @s sp_pick5 0
scoreboard players set @s sp_panel 2
function splendor:ui/editor_show
