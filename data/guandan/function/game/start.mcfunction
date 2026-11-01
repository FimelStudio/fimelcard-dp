scoreboard players set @s ct_start 0
execute if score @s ct_state matches 1 run return fail
execute unless score @s ct_joined matches 1..4 run return run function guandan:game/bad_count
execute unless score @s ct_capacity matches 4 unless score @s ct_capacity matches 8 run return fail
scoreboard players operation #table gd_ctx = @s ct_id
scoreboard players set #online gd_ctx 0
scoreboard players set #occupied gd_ctx 0
tag @a[tag=gd.start] remove gd.start
execute as @a[tag=ct.player] if score @s ct_id = #table gd_ctx run tag @s add gd.start
execute as @a[tag=gd.start] run scoreboard players add #online gd_ctx 1
execute unless score #online gd_ctx matches 1..4 run return run function guandan:game/bad_count
execute as @a[tag=gd.start] if items entity @s hotbar.0 * run scoreboard players set #occupied gd_ctx 1
execute as @a[tag=gd.start] if items entity @s hotbar.8 * run scoreboard players set #occupied gd_ctx 1
execute if score #occupied gd_ctx matches 1 run return run function guandan:game/bad_slots
function guandan:game/init_table
execute if score @s gd_pair matches 0 run function guandan:game/check_sides
execute if score @s gd_pair matches 0 unless score #sides_ok gd_ctx matches 1 run return run function guandan:game/bad_sides
function guandan:game/clear
tag @s add gd.controller
function guandan:system/context
execute if score @s gd_pair matches 1 run function guandan:game/random_sides
execute as @a[tag=gd.start] run function guandan:player/join
tag @a[tag=gd.start] remove gd.start
function guandan:system/context
scoreboard players set @s gd_humans 0
execute as @a[tag=gd.audience] run scoreboard players add @e[tag=gd.current,limit=1] gd_humans 1
function guandan:bot/fill
scoreboard players set @s gd_round 0
scoreboard players operation @s gd_team0 = @s gd_startlevel
scoreboard players operation @s gd_team1 = @s gd_startlevel
scoreboard players operation @s gd_level = @s gd_startlevel
scoreboard players set @s gd_playteam -1
scoreboard players set @s gd_tick 0
scoreboard players set @s gd_winner -1
scoreboard players set @s gd_matchwin -1
scoreboard players set @s ct_start 1
function guandan:round/begin
function guandan:log {text:"掼蛋开局：真人与测试人机共四人、108张牌、对家搭档"}
