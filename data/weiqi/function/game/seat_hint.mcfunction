execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 0 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[围棋] 按座位分边：黑方 3 号、白方 1 号；双人请两侧各坐一人，或选择随机分边。", "color": "red"}
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[围棋] 按座位分边：黑方 4 号、白方 2 号；双人请两侧各坐一人，或选择随机分边。", "color": "red"}
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 0 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[围棋] 按座位分边：黑方 5／6 号、白方 1／2 号；双人请两侧各坐一人，或选择随机分边。", "color": "red"}
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[围棋] 按座位分边：黑方 7／8 号、白方 3／4 号；双人请两侧各坐一人，或选择随机分边。", "color": "red"}
