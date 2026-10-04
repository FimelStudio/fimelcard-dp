# 不修改现有方块。站在4×4桌面的中心交界点执行。
execute unless entity @s[type=minecraft:player] run return fail
tag @s add ct.create_no_blocks
execute positioned ~ ~-1 ~ run function cardtable:admin/create8
tag @s remove ct.create_no_blocks
