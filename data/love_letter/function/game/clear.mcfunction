function love_letter:system/context
scoreboard players set @s ll_state 0
scoreboard players set @s ll_phase 0
scoreboard players set @s ll_timer 0
scoreboard players set @s ll_clock 0
scoreboard players set @s ll_anim 0
function love_letter:visual/clear
function cardtable:animation/deal/clear
execute as @a[tag=ll.player] if score @s ll_table = #table ll_ctx run function love_letter:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{love_letter:{tool:1b}}] run function love_letter:player/kill_drop
execute as @e[type=minecraft:firework_rocket,tag=ll.firework] if score @s ct_id = #table ll_ctx run kill @s
kill @e[tag=ll.board]
data remove entity @s data.love_letter
data remove entity @s data.ll_private
data remove entity @s data.ll_buffer
tag @s remove ll.controller
tag @s remove ll.current
