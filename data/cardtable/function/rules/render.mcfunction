# 规则按钮属于牌桌通用常驻界面，不属于大厅菜单或结束投票界面
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @e[tag=ct.rules] if score @s ct_id = #ctx_id ct_ctx run kill @s

execute unless score @s ct_capacity matches 8 run function cardtable:rules/spawn4
execute if score @s ct_capacity matches 8 run function cardtable:rules/spawn8

execute as @e[nbt={data:{cardtable:{new_rules:1b}}},distance=..4] run tag @s add ct.new_rules
tag @e[tag=ct.new_rules,distance=..4] add ct.rules
tag @e[tag=ct.new_rules,distance=..4] add ct.part
scoreboard players operation @e[tag=ct.new_rules,distance=..4] ct_id = @s ct_id
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{game_rules:1b}}},distance=..4] run scoreboard players set @s ct_kind 31
execute as @e[tag=ct.new_rules,distance=..4] run data remove entity @s data.cardtable
tag @e[tag=ct.new_rules,distance=..4] remove ct.new_rules

# 独立记录规则布局版本，补做重载时尚未加载的桌子，不重建座位或游戏。
data merge entity @s {data:{cardtable:{rules_version:4}}}
