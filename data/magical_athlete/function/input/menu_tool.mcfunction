# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if items entity @s hotbar.7 * unless items entity @s hotbar.7 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run return run function magical_athlete:direct/space_notice
$item replace entity @s hotbar.7 with minecraft:paper[minecraft:item_model="card:magical_athlete/dice",minecraft:custom_name={text:"投骰〔Q〕",color:"gold",italic:false},minecraft:custom_data={magical_athlete:{tool:1b,dice:1b,table:$(table)}}]
