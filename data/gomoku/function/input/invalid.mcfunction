# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tellraw @s {text:"[五子棋] 这个窗口已过期或当前操作不可用，请按Q重新打开面板。",color:"yellow"}
tag @a[tag=gm.actor] remove gm.actor
