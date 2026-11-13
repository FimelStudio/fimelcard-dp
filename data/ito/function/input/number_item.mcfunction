# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$clear @s minecraft:paper[minecraft:custom_data~{ito:{tool:1b,kind:2,slot:$(slot)}}]
$give @s minecraft:paper[minecraft:item_model="card:ito/$(number)",minecraft:item_name="数字 $(number) · 手牌$(slot)（Q出牌）",minecraft:custom_data={ito:{tool:1b,kind:2,table:$(table),owner:$(owner),round:$(round),epoch:$(epoch),slot:$(slot)}},minecraft:max_stack_size=1,minecraft:lore=[{text:"所有描述提交后，讨论好顺序再按Q出牌。",color:"yellow"}]]
