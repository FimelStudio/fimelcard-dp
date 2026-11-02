# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tellraw @s {text:"[围棋] 窗口已过期或此时不能操作，请按Q重新打开对局菜单。",color:"yellow"}
tag @a[tag=go.actor] remove go.actor
