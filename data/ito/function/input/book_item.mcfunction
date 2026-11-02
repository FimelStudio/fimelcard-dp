# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$clear @s *[minecraft:custom_data~{ito:{tool:1b,kind:1,slot:$(slot)}}]
$give @s minecraft:writable_book[minecraft:item_name="手牌$(slot) · 描述书（Q提交）",minecraft:custom_data={ito:{tool:1b,kind:1,table:$(table),round:$(round),slot:$(slot)}},minecraft:writable_book_content=$(content),minecraft:lore=[{text:"仅你可见：数字$(number)",color:"gold"},{text:"第一页写1–48字，完成后Q提交，不签名。",color:"yellow"}]]
