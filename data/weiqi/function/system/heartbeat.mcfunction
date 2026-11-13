# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s go_pulse 0
function weiqi:system/context
execute if score @s ct_state matches 1 run function weiqi:game/player_left
execute if score @s ct_state matches 1 run function weiqi:clock/update
# 大厅离桌后的复盘物品不可继续操作；常规离座路径也会清理。
execute as @a[tag=go.player] unless entity @s[tag=ct.player] run function weiqi:player/clear_state
