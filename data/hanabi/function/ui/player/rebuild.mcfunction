# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 当前执行者是玩家；自己的认知态手牌同步到物品栏，真牌只进入排除自己的左侧专属面板。
function hanabi:hand/sync
function hanabi:title/update_from_player
