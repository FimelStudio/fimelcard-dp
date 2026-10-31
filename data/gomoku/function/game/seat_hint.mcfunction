execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 0 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[五子棋] 自行选边时，请坐黑方侧 3 号位或白方侧 1 号位；双人局须两侧各一人，也可改用随机黑白。", "color": "black"}
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[五子棋] 自行选边时，请坐黑方侧 4 号位或白方侧 2 号位；双人局须两侧各一人，也可改用随机黑白。", "color": "black"}
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 0 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[五子棋] 自行选边时，请坐黑方侧 5／6 号位或白方侧 1／2 号位；双人局须两侧各一人，也可改用随机黑白。", "color": "black"}
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[五子棋] 自行选边时，请坐黑方侧 7／8 号位或白方侧 3／4 号位；双人局须两侧各一人，也可改用随机黑白。", "color": "black"}
