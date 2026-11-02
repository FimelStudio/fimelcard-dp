# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return 0
execute if score #ui_tool gm_ctx matches 1 if entity @e[tag=gm.current,scores={gm_state=1..2},limit=1] run return run function gomoku:ui/resign
execute unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return run function gomoku:ui/open
execute unless score #ui_tool gm_ctx matches 2 unless score #ui_tool gm_ctx matches 6 run return run function gomoku:ui/open
function gomoku:ui/begin
execute if score #ui_tool gm_ctx matches 6 run function gomoku:ui/undo_buttons
execute if score #ui_tool gm_ctx matches 2 run function gomoku:ui/draw_buttons
function gomoku:ui/show with storage gomoku:ui
tag @a[tag=gm.actor] remove gm.actor
