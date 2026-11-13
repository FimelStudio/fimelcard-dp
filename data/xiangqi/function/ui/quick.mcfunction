# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function xiangqi:input/context
execute unless entity @s[tag=xq.actor] run return 0
execute if score #ui_tool xq_ctx matches 1 if entity @e[tag=xq.current,scores={xq_state=1..2},limit=1] run return run function xiangqi:ui/resign
execute unless entity @e[tag=xq.current,scores={xq_state=1},limit=1] run return run function xiangqi:ui/open
execute unless score #ui_tool xq_ctx matches 2 unless score #ui_tool xq_ctx matches 6 run return run function xiangqi:ui/open
function xiangqi:ui/begin
execute if score #ui_tool xq_ctx matches 6 run function xiangqi:ui/undo_buttons
execute if score #ui_tool xq_ctx matches 2 run function xiangqi:ui/draw_buttons
function xiangqi:ui/show with storage xiangqi:ui
tag @a[tag=xq.actor] remove xq.actor
