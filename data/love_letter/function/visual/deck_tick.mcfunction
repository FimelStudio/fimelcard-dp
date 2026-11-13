# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s ct_state matches 1 run return 0
execute unless score @s ll_state matches 1..4 run return 0
scoreboard players operation #vis_table ll_ctx = @s ct_id
scoreboard players set #deck_label_found ll_ctx 0
execute as @e[tag=ll.deck_count] if score @s ct_id = #vis_table ll_ctx run scoreboard players set #deck_label_found ll_ctx 1
execute if score #deck_label_found ll_ctx matches 0 positioned ~ ~1.26 ~ summon minecraft:text_display run function love_letter:visual/deck_init
data modify storage love_letter:visual deck_count set value {count:0}
execute store result storage love_letter:visual deck_count.count int 1 run data get entity @s data.love_letter.deck
execute as @e[tag=ll.deck_count] if score @s ct_id = #vis_table ll_ctx run function love_letter:visual/deck_text with storage love_letter:visual deck_count
