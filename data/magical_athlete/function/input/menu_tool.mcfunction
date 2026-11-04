execute if items entity @s hotbar.7 * unless items entity @s hotbar.7 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run return run function magical_athlete:direct/space_notice
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$item replace entity @s hotbar.7 with minecraft:paper[minecraft:custom_name={text:"胡闹运动会 · 骰子",color:"gold",italic:false},minecraft:item_model="card:aeroplane_chess/dice",minecraft:custom_data={magical_athlete:{tool:1b,table:$(table)}}]
