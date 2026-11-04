execute if items entity @s hotbar.8 * unless items entity @s hotbar.8 *[minecraft:custom_data~{catan:{tool:1b}}] run return run title @s actionbar {text:"请腾空游戏操作物品需要的快捷栏位置",color:"yellow"}
$item replace entity @s hotbar.8 with minecraft:purple_dye[minecraft:custom_name={text:"更多操作（Q）",color:"light_purple",italic:false},minecraft:custom_data={catan:{tool:1b,table:$(table)}}]
