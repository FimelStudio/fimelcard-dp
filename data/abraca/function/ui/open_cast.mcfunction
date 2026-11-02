# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function abraca:input/give_tools
tellraw @s [{text:'[出包魔法师] ',color:'dark_purple'},{text:'第1～8格：按Q施法，牌会返还；第9格黑色染料：按Q结束回合。',color:'gray'}]
