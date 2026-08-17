scoreboard players add @s lh_timer 1

# 牌盒缩小结束后才生成公共牌；先在桌心重叠一刻，再用10刻插值横向展开
execute if score @s lh_timer matches 10 run function cardtable:animation/deal/box/clear
execute if score @s lh_timer matches 10 run function liars_holdem:community/create_all
execute if score @s lh_timer matches 11 run function liars_holdem:community/spread
execute if score @s lh_timer matches 22.. run function liars_holdem:deal/complete
