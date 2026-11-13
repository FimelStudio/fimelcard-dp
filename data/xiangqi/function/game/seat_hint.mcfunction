execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 0 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[中国象棋] 自行选边时，请坐红方侧 3 号位或黑方侧 1 号位；双人局须两侧各一人，也可改用随机红黑。", "color": "red"}
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[中国象棋] 自行选边时，请坐红方侧 4 号位或黑方侧 2 号位；双人局须两侧各一人，也可改用随机红黑。", "color": "red"}
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 0 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[中国象棋] 自行选边时，请坐红方侧 5／6 号位或黑方侧 1／2 号位；双人局须两侧各一人，也可改用随机红黑。", "color": "red"}
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[中国象棋] 自行选边时，请坐红方侧 7／8 号位或黑方侧 3／4 号位；双人局须两侧各一人，也可改用随机红黑。", "color": "red"}
