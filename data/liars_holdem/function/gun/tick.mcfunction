scoreboard players add @s lh_timer 1
# 最短1秒演出也会在中点响一次；更长演出每隔1秒继续提示，且不与最终判定同刻重叠
execute if score @s lh_timer < @s lh_limit if score @s lh_timer matches 10 run function liars_holdem:sound/gun_tick
execute if score @s lh_timer < @s lh_limit if score @s lh_timer matches 30 run function liars_holdem:sound/gun_tick
execute if score @s lh_timer < @s lh_limit if score @s lh_timer matches 50 run function liars_holdem:sound/gun_tick
execute if score @s lh_timer < @s lh_limit if score @s lh_timer matches 70 run function liars_holdem:sound/gun_tick
execute if score @s lh_timer < @s lh_limit if score @s lh_timer matches 90 run function liars_holdem:sound/gun_tick
execute if score @s lh_timer >= @s lh_limit run function liars_holdem:gun/resolve
