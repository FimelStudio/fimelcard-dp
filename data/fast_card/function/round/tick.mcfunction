# 结算标题先出现，四个名次再每隔16刻逐行显示
scoreboard players add @s fc_timer 1
execute if score @s fc_timer matches 8 run function fast_card:ranking/animate_one
execute if score @s fc_timer matches 24 run function fast_card:ranking/animate_one
execute if score @s fc_timer matches 40 run function fast_card:ranking/animate_one
execute if score @s fc_timer matches 56 run function fast_card:ranking/animate_one

# 整段排行榜保留到第100刻，再衔接下一小局或最终结算
execute if score @s fc_timer matches 100.. run function fast_card:transition/cleanup
execute if score @s fc_timer matches 100.. run function fast_card:round/next_or_finish
