# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
clear @s minecraft:purple_dye[minecraft:custom_data~{ito:{tool:1b,kind:0}}]
$give @s minecraft:purple_dye[minecraft:item_name="命悬一线 · Q查看手牌／描述",minecraft:custom_data={ito:{tool:1b,kind:0,table:$(table)}},minecraft:max_stack_size=1]
