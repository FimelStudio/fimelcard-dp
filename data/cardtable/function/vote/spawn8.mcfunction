function cardtable:vote/text8

# 八人桌点击区收至桌沿内侧，仅外沿露至文字平面，避开座椅。
# 北、东、南、西四面的结束游戏点击区
summon minecraft:interaction ~-1.40 ~0.5625 ~-1.765 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.50f,height:0.22f,response:1b}
summon minecraft:interaction ~1.765 ~0.5625 ~-1.40 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.50f,height:0.22f,response:1b}
summon minecraft:interaction ~1.40 ~0.5625 ~1.765 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.50f,height:0.22f,response:1b}
summon minecraft:interaction ~-1.765 ~0.5625 ~1.40 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.50f,height:0.22f,response:1b}
