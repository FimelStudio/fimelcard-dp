# 控制器位置执行；只在排名已经公布且尚未回收时修复。
execute unless score @s lh_state matches 14..15 run return 0
execute unless score @s lh_show_phase matches 1 run return 0
scoreboard players operation #rank_table lh_ctx = @s lh_id
tag @e[tag=lh.rank_layout_candidate] remove lh.rank_layout_candidate
tag @e[tag=lh.rank_layout_target] remove lh.rank_layout_target
execute as @e[type=minecraft:text_display,tag=lh.showdown_display] if score @s lh_id = #rank_table lh_ctx run tag @s add lh.rank_layout_candidate
execute as @e[tag=lh.rank_layout_candidate,tag=lh.ranking_display] run tag @s add lh.rank_layout_target
# 旧版本没有排名标签；其排名固定在全部手牌上方，因此本桌最远的行是旧排名。
execute unless entity @e[tag=lh.rank_layout_target] run tag @e[tag=lh.rank_layout_candidate,sort=furthest,limit=1] add lh.rank_layout_target
tag @e[tag=lh.rank_layout_target] add lh.ranking_display
execute as @e[tag=lh.rank_layout_target] run tp @s ~ ~1.05 ~
execute as @e[tag=lh.rank_layout_target] run data modify entity @s transformation.translation set value [0f,0f,0f]
tag @e[tag=lh.rank_layout_candidate] remove lh.rank_layout_candidate
tag @e[tag=lh.rank_layout_target] remove lh.rank_layout_target
