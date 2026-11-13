# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 提示操作物按Q后消耗，并进入现有的目标与提示内容Dialog
scoreboard players set @s hb_drop_hint 0
tag @e[tag=hb.dropped_owned] remove hb.dropped_owned
scoreboard players set #drop_found hb_ctx 0
execute store result storage hanabi:input table int 1 run scoreboard players get @s hb_id
function hanabi:input/find_hint_drop with storage hanabi:input
execute unless entity @e[tag=hb.dropped_owned,limit=1] run return 0
kill @e[tag=hb.dropped_owned,limit=1]
execute unless entity @s[tag=hb.turn] run return 0

scoreboard players set @s hb_action 300
function hanabi:action/handle
