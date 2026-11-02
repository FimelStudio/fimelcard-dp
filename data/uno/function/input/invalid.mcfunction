# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tellraw @s {text:"[UNO] 窗口已过期，请使用当前回合的操作入口。",color:"yellow"}
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
scoreboard players set @s un_colorpick -1
tag @a[tag=un.actor] remove un.actor
