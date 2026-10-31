clear @s *[minecraft:custom_data~{avalon:{menu:1b}}]
item replace entity @s hotbar.8 with minecraft:purple_dye[minecraft:custom_data={avalon:{menu:1b}},minecraft:item_name={text:"阿瓦隆 · 身份与操作（按Q）",color:"light_purple"}] 1
function avalon:player/identity
