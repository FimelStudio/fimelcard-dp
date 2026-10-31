function chess:input/context
execute unless entity @s[tag=ch.actor] run return 0
execute if score #ui_tool ch_ctx matches 1 if entity @e[tag=ch.current,scores={ch_state=1..3},limit=1] run return run function chess:ui/resign
execute if entity @e[tag=ch.current,scores={ch_state=3},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run return run function chess:ui/promotion
execute unless entity @e[tag=ch.current,scores={ch_state=1},limit=1] run return run function chess:ui/open
execute unless score #ui_tool ch_ctx matches 2 unless score #ui_tool ch_ctx matches 6 run return run function chess:ui/open
function chess:ui/begin
execute if score #ui_tool ch_ctx matches 6 run function chess:ui/undo_buttons
execute if score #ui_tool ch_ctx matches 2 run function chess:ui/draw_buttons
function chess:ui/show with storage chess:ui
tag @a[tag=ch.actor] remove ch.actor
