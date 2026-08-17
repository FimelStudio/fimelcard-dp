# 规则按钮属于牌桌通用常驻界面，不属于大厅菜单或结束投票界面
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @e[tag=ct.rules] if score @s ct_id = #ctx_id ct_ctx run kill @s

function cardtable:rules/text

# 点击区比文字更靠近桌心0.39格，尽量贴合文字且不遮挡相邻按钮
summon minecraft:interaction ~1.00 ~0.5625 ~-1.125 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~1.125 ~0.5625 ~1.00 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~-1.00 ~0.5625 ~1.125 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~-1.125 ~0.5625 ~-1.00 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.80f,height:0.22f,response:1b}

execute as @e[nbt={data:{cardtable:{new_rules:1b}}},distance=..3] run tag @s add ct.new_rules
tag @e[tag=ct.new_rules,distance=..3] add ct.rules
tag @e[tag=ct.new_rules,distance=..3] add ct.part
scoreboard players operation @e[tag=ct.new_rules,distance=..3] ct_id = @s ct_id
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{game_rules:1b}}},distance=..3] run scoreboard players set @s ct_kind 31
execute as @e[tag=ct.new_rules,distance=..3] run data remove entity @s data.cardtable
tag @e[tag=ct.new_rules,distance=..3] remove ct.new_rules
