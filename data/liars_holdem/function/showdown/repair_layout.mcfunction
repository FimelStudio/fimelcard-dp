# 以八人桌控制器执行。只修正旧展示坐标，不重放摊牌或修改计时、名次。
scoreboard players operation #layout_table lh_ctx = @s lh_id
data modify storage liars_holdem:showdown center.x set from entity @s Pos[0]
data modify storage liars_holdem:showdown center.z set from entity @s Pos[2]
execute store result score #layout_center_x lh_ctx run data get entity @s Pos[0] 1
data modify storage liars_holdem:showdown center.rank_rise set value "0"
execute if score @s lh_show_count matches 5 run data modify storage liars_holdem:showdown center.rank_rise set value "0.55"
execute if score @s lh_show_count matches 6 run data modify storage liars_holdem:showdown center.rank_rise set value "1.10"
execute if score @s lh_show_count matches 7 run data modify storage liars_holdem:showdown center.rank_rise set value "1.65"
execute if score @s lh_show_count matches 8 run data modify storage liars_holdem:showdown center.rank_rise set value "2.20"
execute as @e[type=minecraft:text_display,tag=lh.showdown_display,tag=!lh.showdown_single] if score @s lh_id = #layout_table lh_ctx at @s run function liars_holdem:showdown/repair_line with storage liars_holdem:showdown center
function liars_holdem:showdown/repair_ranking_height
