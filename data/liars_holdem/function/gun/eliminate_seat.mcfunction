# 先在控制器上永久关闭该座位，再清理仍在线的目标玩家
execute if score @s lh_gun_seat matches 1 run scoreboard players set @s lh_a1 0
execute if score @s lh_gun_seat matches 2 run scoreboard players set @s lh_a2 0
execute if score @s lh_gun_seat matches 3 run scoreboard players set @s lh_a3 0
execute if score @s lh_gun_seat matches 4 run scoreboard players set @s lh_a4 0
execute if score @s lh_gun_seat matches 5 run scoreboard players set @s lh_a5 0
execute if score @s lh_gun_seat matches 6 run scoreboard players set @s lh_a6 0
execute if score @s lh_gun_seat matches 7 run scoreboard players set @s lh_a7 0
execute if score @s lh_gun_seat matches 8 run scoreboard players set @s lh_a8 0
scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players operation #gun_seat lh_ctx = @s lh_gun_seat
execute as @e[type=minecraft:marker,tag=lh.hand_card] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #gun_seat lh_ctx run kill @s
execute as @a[tag=lh.gun_target,limit=1] run function liars_holdem:player/eliminate
function cardtable:table/recount_players
function liars_holdem:hud/update
