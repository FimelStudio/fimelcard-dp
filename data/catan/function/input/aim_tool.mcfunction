# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$item replace entity @s hotbar.0 with minecraft:paper[minecraft:custom_name={text:"卡坦岛 · 瞄准建造",color:"gold",italic:false},minecraft:item_model="minecraft:spyglass",minecraft:custom_data={catan:{tool:1b,action:1,table:$(table)}},minecraft:lore=[{text:"按 Q 使用",color:"gray",italic:false}]]
