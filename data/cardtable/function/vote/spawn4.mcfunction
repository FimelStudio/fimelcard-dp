function cardtable:vote/text

# 点击区Y比旧版提高0.0925格，并沿文字朝向轴向桌心移动0.39格
# 北、东、南、西四面的结束游戏点击区
summon minecraft:interaction ~-1.00 ~0.5625 ~-1.125 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~1.125 ~0.5625 ~-1.00 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~1.00 ~0.5625 ~1.125 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~-1.125 ~0.5625 ~1.00 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.80f,height:0.22f,response:1b}
