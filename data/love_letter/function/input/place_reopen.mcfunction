# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute store result score #reopen_have ll_ctx run clear @s minecraft:purple_dye[minecraft:custom_data~{love_letter:{reopen:1b,table:$(table)}}] 0
execute if score #reopen_have ll_ctx matches 1.. run return 0
clear @s minecraft:purple_dye[minecraft:custom_data~{love_letter:{reopen:1b}}]
$give @s minecraft:purple_dye[minecraft:item_name={text:"恢复对话框 · 按Q使用",color:"light_purple",italic:false},minecraft:custom_data={love_letter:{tool:1b,reopen:1b,action:9,table:$(table)}},minecraft:max_stack_size=1]
