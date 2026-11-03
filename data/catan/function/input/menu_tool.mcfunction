execute if items entity @s hotbar.7 * unless items entity @s hotbar.7 *[minecraft:custom_data~{catan:{tool:1b}}] run return run title @s actionbar {text:"请腾空游戏操作物品需要的快捷栏位置",color:"yellow"}
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$item replace entity @s hotbar.7 with minecraft:paper[minecraft:custom_name={text:"卡坦岛 · 骰子",color:"gold",italic:false},minecraft:item_model="card:aeroplane_chess/dice",minecraft:custom_data={catan:{tool:1b,action:0,table:$(table)}},minecraft:lore=[{text:"按 Q 掷骰",color:"gray",italic:false}]]
