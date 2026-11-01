execute unless entity @e[tag=ll.current,scores={ll_state=2,ll_phase=1,ll_anim=0},limit=1] run return run function love_letter:input/invalid
execute unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run return run function love_letter:input/invalid
execute unless entity @e[tag=ll.me,scores={ll_alive=1},limit=1] run return run function love_letter:input/invalid
scoreboard players operation #ui_slot ll_ctx = #ui_action ll_ctx
scoreboard players remove #ui_slot ll_ctx 10
execute if score @s ll_pick = #ui_slot ll_ctx run return run function love_letter:input/deselect
scoreboard players operation @s ll_pick = #ui_slot ll_ctx
function love_letter:ui/open
