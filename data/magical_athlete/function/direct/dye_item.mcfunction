execute if items entity @s hotbar.8 * unless items entity @s hotbar.8 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run return run function magical_athlete:direct/space_notice
$item replace entity @s hotbar.8 with minecraft:purple_dye[minecraft:custom_name={text:"更多操作（Q）",color:"light_purple",italic:false},minecraft:custom_data={magical_athlete:{tool:1b,table:$(table)}}]
