function cardtable:rules/text

# 点击区比文字更靠近桌心0.39格，尽量贴合文字且不遮挡相邻按钮
summon minecraft:interaction ~1.00 ~0.5625 ~-1.125 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~1.125 ~0.5625 ~1.00 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~-1.00 ~0.5625 ~1.125 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~-1.125 ~0.5625 ~-1.00 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.80f,height:0.22f,response:1b}
