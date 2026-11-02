# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$item replace entity @s hotbar.8 with minecraft:paper[minecraft:custom_name={text:"璀璨宝石 · 市场",color:"gold",italic:false},minecraft:item_model="card:splendor/bag",minecraft:custom_data={splendor:{tool:1b,table:$(table)}},minecraft:lore=[{text:"Q 打开市场与预约牌",color:"gray",italic:false}]]
