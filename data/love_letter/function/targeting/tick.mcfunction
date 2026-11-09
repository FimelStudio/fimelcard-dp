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
function love_letter:targeting/scan
scoreboard players set #preview ll_ctx 0
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] if score @s ll_seat = #aim ll_ctx run scoreboard players set #preview ll_ctx 1
execute unless score #preview ll_ctx matches 1 run scoreboard players set #aim ll_ctx 0
execute as @a[tag=ll.audience,tag=ll.aim_preview] unless score @s ll_seat = #aim ll_ctx run effect clear @s minecraft:glowing
execute as @a[tag=ll.audience,tag=ll.aim_preview] unless score @s ll_seat = #aim ll_ctx run tag @s remove ll.aim_preview
execute if score #aim ll_ctx matches 1..8 as @a[tag=ll.audience] if score @s ll_seat = #aim ll_ctx run tag @s add ll.aim_preview
execute as @a[tag=ll.audience,tag=ll.aim_preview] run effect give @s minecraft:glowing 1 0 true
