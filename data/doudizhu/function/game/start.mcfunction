function doudizhu:log {text:"开始检查斗地主开局条件"}
execute unless score @s ct_joined matches 1..4 unless score @s ct_joined matches 8 run tellraw @a[tag=ct.start_actor,limit=1] {text:"斗地主支持1至4人，或八座桌坐满8人。",color:"red"}
execute unless score @s ct_joined matches 1..4 unless score @s ct_joined matches 8 run return fail
execute if score @s ct_joined matches 8 unless score @s ct_capacity matches 8 run return fail
scoreboard players operation #ctx dd_ctx = @s ct_id
scoreboard players set #online dd_ctx 0
scoreboard players set #blocked dd_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx run scoreboard players add #online dd_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx if items entity @s hotbar.8 * run scoreboard players set #blocked dd_ctx 1
execute unless score #online dd_ctx = @s ct_joined run return fail
execute if score #blocked dd_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"请所有玩家腾空快捷栏第9格，用于打开手牌。",color:"red"}
execute if score #blocked dd_ctx matches 1 run return fail
function doudizhu:game/init_table
execute if score @s ct_joined matches 4 unless function doudizhu:team/validate_fixed run return fail
scoreboard players set @s dd_lane 0
scoreboard players set @s dd_team_one 0
scoreboard players set @s dd_team_two 0
scoreboard players set @s dd_round 1
scoreboard players operation @s dd_limit = @s dd_max
tag @s add dd.controller
scoreboard players operation @s dd_id = @s ct_id
scoreboard players operation @s dd_humans = @s ct_joined
scoreboard players operation @s dd_bidmode = @s dd_classic_bid
execute if score @s dd_humans matches 4 run scoreboard players set @s dd_bidmode 0
scoreboard players reset @s dd_bidbye
scoreboard players set @s dd_out 0
scoreboard players set @s dd_bot_timer 0
data remove entity @s data.dd_collect
data modify entity @s data.doudizhu set value {}
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx run function doudizhu:player/init
execute if score @s dd_humans matches 8 run return run function doudizhu:duplicate/start
execute if score @s dd_humans matches 4 run function doudizhu:team/assign
execute unless score @s dd_humans matches 4 run function doudizhu:bot/fill
scoreboard players set @s ct_start 1
function doudizhu:deal/start
