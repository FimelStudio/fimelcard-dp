# 候选实体已由调用者按物品组件过滤，并按距离从近到远执行；只认第一件
# 牌桌之间至少相距9格，而玩家自己Q出的物品在1格内，因此无需依赖版本易变的物品实体NBT路径
execute if score #drop_found lh_ctx matches 1 run return 0
tag @s add lh.dropped_owned
scoreboard players set #drop_found lh_ctx 1
