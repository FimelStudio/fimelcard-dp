function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
$execute unless score @s ll_table matches $(table) run return run function love_letter:targeting/stale
$execute unless score @s ll_seat matches $(owner) run return run function love_letter:targeting/stale
$execute unless score @e[tag=ll.current,limit=1] ll_epoch matches $(epoch) run return run function love_letter:targeting/stale
execute unless entity @e[tag=ll.current,scores={ll_state=2,ll_phase=1,ll_anim=0,ll_target_mode=1},limit=1] run return run function love_letter:targeting/stale
execute unless score @e[tag=ll.current,limit=1] ll_select_epoch = @e[tag=ll.current,limit=1] ll_epoch run return run function love_letter:targeting/stale
execute unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run return run function love_letter:targeting/stale
execute unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_select_actor run return run function love_letter:targeting/stale
$execute if score @s ll_seat matches $(owner) if score #actor ll_ctx matches $(owner) run scoreboard players set #head_target ll_ctx $(target)
execute if score #head_target ll_ctx matches 0 run return run function love_letter:targeting/cancel
scoreboard players operation #slot ll_ctx = @e[tag=ll.current,limit=1] ll_select_slot
scoreboard players operation @e[tag=ll.current,limit=1] ll_exact = #head_target ll_ctx
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/play
scoreboard players set @e[tag=ll.current,limit=1] ll_exact 0
execute if score #ok ll_ctx matches 1 run return run function love_letter:targeting/cancel
scoreboard players set @s ll_hintwait 40
title @s actionbar {text:"此目标不可选：已出局、受侍女保护，或此牌不能对自己使用。",color:"yellow"}
function love_letter:input/give
