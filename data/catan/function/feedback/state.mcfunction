$execute if score @s ca_state matches 1 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 放置初始村庄：手持村庄，瞄准交点后右键两次","color":"yellow"}]
$execute if score @s ca_state matches 1 as @a[tag=ca.audience,scores={ca_side=$(turn)}] run function catan:feedback/subtitle {"text":{"text":"轮到你了 · 放置初始村庄","color":"aqua"}}
$execute if score @s ca_state matches 2 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 放置初始道路：手持道路，瞄准刚建村庄相邻的边","color":"yellow"}]
$execute if score @s ca_state matches 2 as @a[tag=ca.audience,scores={ca_side=$(turn)}] run function catan:feedback/subtitle {"text":{"text":"轮到你了 · 放置初始道路","color":"aqua"}}
$execute if score @s ca_state matches 3 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 开始回合：手持骰子按Q投骰，或使用旧发展卡","color":"yellow"}]
$execute if score @s ca_state matches 3 as @a[tag=ca.audience,scores={ca_side=$(turn)}] run function catan:feedback/subtitle {"text":{"text":"轮到你了 · 投骰或使用旧发展卡","color":"aqua"}}
$execute if score @s ca_state matches 4 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 自由行动：建造、交易或使用发展卡；第4格Q一次购牌，第7格Q一次结束回合","color":"yellow"}]
$execute if score @s ca_state matches 4 as @a[tag=ca.audience,scores={ca_side=$(turn)}] run function catan:feedback/subtitle {"text":{"text":"轮到你了 · 建造、交易或结束回合","color":"aqua"}}
$execute if score @s ca_state matches 5 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 掷出7：资源超过7张的玩家必须弃掉一半（向下取整）","color":"yellow"}]
$execute if score @s ca_state matches 6 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 移动强盗：瞄准另一个地块，右键两次确认","color":"yellow"}]
$execute if score @s ca_state matches 6 as @a[tag=ca.audience,scores={ca_side=$(turn)}] run function catan:feedback/subtitle {"text":{"text":"轮到你了 · 移动强盗","color":"aqua"}}
$execute if score @s ca_state matches 7 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 偷取资源：瞄准亮起的相邻对手，按Q或右键一次","color":"yellow"}]
$execute if score @s ca_state matches 7 as @a[tag=ca.audience,scores={ca_side=$(turn)}] run function catan:feedback/subtitle {"text":{"text":"轮到你了 · 选择偷取对象","color":"aqua"}}
$execute if score @s ca_state matches 8 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 免费修路：手持道路选择位置，最多两条","color":"yellow"}]
$execute if score @s ca_state matches 8 as @a[tag=ca.audience,scores={ca_side=$(turn)}] run function catan:feedback/subtitle {"text":{"text":"轮到你了 · 免费修建道路","color":"aqua"}}
$execute if score @s ca_state matches 11 run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(turn).name","entity":"@s","interpret":true},{"text":" · 本局结束","color":"yellow"}]
execute if score @s ca_state matches 5 as @a[tag=ca.audience] run function catan:feedback/discard_prompt
execute as @a[tag=ca.audience] run function catan:hud/build
