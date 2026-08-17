# 找到尚未显示玩家中的最高分
scoreboard players add @s fc_rank 1
scoreboard players set #best fc_ctx -2147483648
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @a[tag=fc.player,tag=!fc.ranked] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score > #best fc_ctx run scoreboard players operation #best fc_ctx = @s fc_score

# 同分时按座位号稳定排序
tag @a[tag=fc.rank_pick] remove fc.rank_pick
execute as @a[tag=fc.player,tag=!fc.ranked,scores={fc_seat=1}] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score = #best fc_ctx run tag @s add fc.rank_pick
execute unless entity @a[tag=fc.rank_pick,limit=1] as @a[tag=fc.player,tag=!fc.ranked,scores={fc_seat=2}] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score = #best fc_ctx run tag @s add fc.rank_pick
execute unless entity @a[tag=fc.rank_pick,limit=1] as @a[tag=fc.player,tag=!fc.ranked,scores={fc_seat=3}] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score = #best fc_ctx run tag @s add fc.rank_pick
execute unless entity @a[tag=fc.rank_pick,limit=1] as @a[tag=fc.player,tag=!fc.ranked,scores={fc_seat=4}] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score = #best fc_ctx run tag @s add fc.rank_pick
execute unless entity @a[tag=fc.rank_pick,limit=1] run return fail

# 将数字转成宏参数；玩家通过固定座位号识别中央排行
execute store result storage fast_card:transition line.rank int 1 run scoreboard players get @s fc_rank
execute store result storage fast_card:transition line.seat int 1 run scoreboard players get @a[tag=fc.rank_pick,limit=1] fc_seat
execute store result storage fast_card:transition line.score int 1 run scoreboard players get @a[tag=fc.rank_pick,limit=1] fc_score
execute store result storage fast_card:transition line.delta int 1 run scoreboard players get @a[tag=fc.rank_pick,limit=1] fc_delta

# 四行从上到下依次排列在牌桌中央
execute if score @s fc_rank matches 1 positioned ~ ~1.62 ~ run function fast_card:transition/ranking_line
execute if score @s fc_rank matches 2 positioned ~ ~1.39 ~ run function fast_card:transition/ranking_line
execute if score @s fc_rank matches 3 positioned ~ ~1.16 ~ run function fast_card:transition/ranking_line
execute if score @s fc_rank matches 4 positioned ~ ~0.93 ~ run function fast_card:transition/ranking_line

tag @a[tag=fc.rank_pick,limit=1] add fc.ranked
tag @a[tag=fc.rank_pick] remove fc.rank_pick
