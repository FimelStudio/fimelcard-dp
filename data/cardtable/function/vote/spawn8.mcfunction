function cardtable:vote/text8

# 八人桌的点击区位于桌面外侧，避免方块挡住点击。
# 北、东、南、西四面的结束游戏点击区
summon minecraft:interaction ~-1.00 ~0.5625 ~-2.10 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~2.10 ~0.5625 ~-1.00 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~1.00 ~0.5625 ~2.10 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.80f,height:0.22f,response:1b}
summon minecraft:interaction ~-2.10 ~0.5625 ~1.00 {data:{cardtable:{new_vote:1b,end_vote:1b}},width:0.80f,height:0.22f,response:1b}
