$execute unless items entity @s hotbar.0 * run return run item replace entity @s hotbar.0 with minecraft:purple_dye[minecraft:item_model="card:uno/back",minecraft:item_name="UNO 手牌（按Q打开）",minecraft:custom_data={uno:{tool:1b,table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:purple_dye[minecraft:item_model="card:uno/back",minecraft:item_name="UNO 手牌（按Q打开）",minecraft:custom_data={uno:{tool:1b,table:$(table)}},minecraft:max_stack_size=1]
tellraw @s {text:"[UNO] 快捷栏第1格有其他物品，操作物已放入背包；挪空后按Q可归位。",color:"yellow"}
