# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function love_letter:system/context
execute unless score @s ll_state matches 2 run return run function love_letter:targeting/clear
execute unless score @s ll_phase matches 1 run return run function love_letter:targeting/clear
execute unless score @s ll_anim matches 0 run return run function love_letter:targeting/clear
scoreboard players operation #actor ll_ctx = @s ll_turn
scoreboard players set #unavailable ll_ctx 0
execute as @a[tag=ll.audience,scores={ll_hintwait=1..}] if score @s ll_seat = #actor ll_ctx run scoreboard players remove @s ll_hintwait 1
execute if score @s ll_aimttl matches 1.. run scoreboard players remove @s ll_aimttl 1
execute unless score @s ll_target_mode matches 1 run function love_letter:targeting/resolve
execute if score @s ll_target_mode matches 1 run scoreboard players set #aim ll_ctx 0
execute if score @s ll_target_mode matches 1 if score @s ll_select_epoch = @s ll_epoch as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run function love_letter:targeting/head_preview
execute if score @s ll_target_mode matches 1 unless score @s ll_select_epoch = @s ll_epoch as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run function love_letter:targeting/held
execute unless score @e[tag=ll.current,limit=1] ll_target_mode matches 1 as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run function love_letter:targeting/held
function love_letter:targeting/highlight
