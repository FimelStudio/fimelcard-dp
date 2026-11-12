function doudizhu:log {text:"开始检查斗地主开局条件"}
function doudizhu:game/init_table
execute unless function doudizhu:game/validate_mode run return fail
scoreboard players operation #ctx dd_ctx = @s ct_id
scoreboard players set #online dd_ctx 0
scoreboard players set #blocked dd_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx run scoreboard players add #online dd_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx if items entity @s hotbar.8 * run scoreboard players set #blocked dd_ctx 1
execute unless score #online dd_ctx = @s ct_joined run return fail
execute if score #blocked dd_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"请所有玩家腾空快捷栏第9格，用于打开手牌。",color:"red"}
execute if score #blocked dd_ctx matches 1 run return fail
execute if score @s dd_mode matches 1 unless function doudizhu:team/validate_fixed run return fail
scoreboard players set @s dd_lane 0
scoreboard players set @s dd_team_one 0
scoreboard players set @s dd_team_two 0
execute if score @s dd_mode matches 1 run data modify entity @s data.dd_team_points set value 1b
scoreboard players set @s dd_round 1
scoreboard players operation @s dd_limit = @s dd_max
tag @s add dd.controller
scoreboard players operation @s dd_id = @s ct_id
# 沿用已有记分项。dd_humans 记录分桌的总席位数（含人机）。
scoreboard players set @s dd_humans 3
execute if score @s dd_mode matches 1 run scoreboard players set @s dd_humans 4
execute if score @s dd_mode matches 2 run scoreboard players set @s dd_humans 8
scoreboard players operation @s dd_bidmode = @s dd_classic_bid
execute if score @s dd_mode matches 1..2 run scoreboard players set @s dd_bidmode 0
scoreboard players reset @s dd_bidbye
scoreboard players set @s dd_out 0
scoreboard players set @s dd_bot_timer 0
data remove entity @s data.dd_collect
data modify entity @s data.doudizhu set value {}
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx run function doudizhu:player/init
scoreboard players operation #fill_missing dd_ctx = @s dd_humans
scoreboard players operation #fill_missing dd_ctx -= @s ct_joined
execute if score #fill_missing dd_ctx matches 1.. if score @s dd_mode matches 1 run function doudizhu:team/fill_fixed
execute if score #fill_missing dd_ctx matches 1.. unless score @s dd_mode matches 1 run function doudizhu:bot/fill
execute if score @s dd_mode matches 2 run return run function doudizhu:duplicate/start
execute if score @s dd_mode matches 1 run function doudizhu:team/assign
scoreboard players set @s ct_start 1
function doudizhu:deal/start
