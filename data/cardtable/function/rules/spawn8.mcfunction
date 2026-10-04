function cardtable:rules/text8

# 点击区随文字沿桌边内移；径向外沿为2.015格，与文字贴合，并避开座椅交互区。
summon minecraft:interaction ~1.25 ~0.5625 ~-1.765 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.50f,height:0.22f,response:1b}
summon minecraft:interaction ~1.765 ~0.5625 ~1.25 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.50f,height:0.22f,response:1b}
summon minecraft:interaction ~-1.25 ~0.5625 ~1.765 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.50f,height:0.22f,response:1b}
summon minecraft:interaction ~-1.765 ~0.5625 ~-1.25 {data:{cardtable:{new_rules:1b,game_rules:1b}},width:0.50f,height:0.22f,response:1b}
