# 找到尚未上榜玩家中的最高分
scoreboard players add @s fc_rank 1
scoreboard players set #best fc_ctx -2147483648
execute as @a[tag=fc.player,tag=!fc.ranked] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score > #best fc_ctx run scoreboard players operation #best fc_ctx = @s fc_score

# 同分时依次选择座位1至4，保证输出稳定
tag @a[tag=fc.rank_pick] remove fc.rank_pick
execute as @a[tag=fc.player,tag=!fc.ranked,scores={fc_seat=1}] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score = #best fc_ctx run tag @s add fc.rank_pick
execute unless entity @a[tag=fc.rank_pick,limit=1] as @a[tag=fc.player,tag=!fc.ranked,scores={fc_seat=2}] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score = #best fc_ctx run tag @s add fc.rank_pick
execute unless entity @a[tag=fc.rank_pick,limit=1] as @a[tag=fc.player,tag=!fc.ranked,scores={fc_seat=3}] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score = #best fc_ctx run tag @s add fc.rank_pick
execute unless entity @a[tag=fc.rank_pick,limit=1] as @a[tag=fc.player,tag=!fc.ranked,scores={fc_seat=4}] if score @s fc_id = #ctx_id fc_ctx if score @s fc_score = #best fc_ctx run tag @s add fc.rank_pick

# 向本桌四人输出本名次
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'第 ',color:'yellow'},{score:{name:'@e[type=minecraft:marker,tag=fc.controller,sort=nearest,limit=1]',objective:'fc_rank'},color:'yellow'},{text:' 名：',color:'yellow'},{selector:'@a[tag=fc.rank_pick,limit=1]',color:'white'},{text:'　',color:'gray'},{score:{name:'@a[tag=fc.rank_pick,limit=1]',objective:'fc_score'},color:'gold'},{text:' 分',color:'gold'}]
tag @a[tag=fc.rank_pick,limit=1] add fc.ranked
tag @a[tag=fc.rank_pick] remove fc.rank_pick
