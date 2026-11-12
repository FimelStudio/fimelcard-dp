$execute if items entity @s hotbar.8 *[minecraft:custom_data~{love_letter:{head:1b,table:$(table),owner:$(owner),epoch:$(epoch),target:0}}] run return 0
execute if items entity @s hotbar.8 * unless items entity @s hotbar.8 *[minecraft:custom_data~{love_letter:{tool:1b}}] run return 0
$item replace entity @s hotbar.8 with minecraft:purple_dye[minecraft:item_model="minecraft:barrier",minecraft:item_name={text:"取消选人 · Q 返回手牌",color:"yellow",italic:false},minecraft:custom_data={love_letter:{tool:1b,head:1b,table:$(table),owner:$(owner),epoch:$(epoch),target:0}}]
