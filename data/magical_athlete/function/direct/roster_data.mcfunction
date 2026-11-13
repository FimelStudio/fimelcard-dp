$data modify storage magical_athlete:direct roster set from storage magical_athlete:characters chars[$(id)]
data modify storage magical_athlete:direct roster.state set value "已使用"
$execute if data storage magical_athlete:ui hand{hand:[$(id)]} run data modify storage magical_athlete:direct roster.state set value "未使用"
$execute if data storage magical_athlete:ui hand{selected:[$(id)]} run data modify storage magical_athlete:direct roster.state set value "本场已提交"
execute store result storage magical_athlete:direct roster.table int 1 run scoreboard players get @s ma_table
execute store result storage magical_athlete:direct roster.epoch int 1 run scoreboard players get @e[tag=ma.current,limit=1] ma_epoch
scoreboard players add @s ma_expected 1
scoreboard players set #roster_slot ma_ctx -1
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.0 * run scoreboard players set #roster_slot ma_ctx 0
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.1 * run scoreboard players set #roster_slot ma_ctx 1
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.2 * run scoreboard players set #roster_slot ma_ctx 2
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.3 * run scoreboard players set #roster_slot ma_ctx 3
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.4 * run scoreboard players set #roster_slot ma_ctx 4
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.5 * run scoreboard players set #roster_slot ma_ctx 5
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.6 * run scoreboard players set #roster_slot ma_ctx 6
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.7 * run scoreboard players set #roster_slot ma_ctx 7
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.8 * run scoreboard players set #roster_slot ma_ctx 8
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.9 * run scoreboard players set #roster_slot ma_ctx 9
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.10 * run scoreboard players set #roster_slot ma_ctx 10
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.11 * run scoreboard players set #roster_slot ma_ctx 11
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.12 * run scoreboard players set #roster_slot ma_ctx 12
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.13 * run scoreboard players set #roster_slot ma_ctx 13
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.14 * run scoreboard players set #roster_slot ma_ctx 14
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.15 * run scoreboard players set #roster_slot ma_ctx 15
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.16 * run scoreboard players set #roster_slot ma_ctx 16
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.17 * run scoreboard players set #roster_slot ma_ctx 17
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.18 * run scoreboard players set #roster_slot ma_ctx 18
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.19 * run scoreboard players set #roster_slot ma_ctx 19
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.20 * run scoreboard players set #roster_slot ma_ctx 20
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.21 * run scoreboard players set #roster_slot ma_ctx 21
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.22 * run scoreboard players set #roster_slot ma_ctx 22
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.23 * run scoreboard players set #roster_slot ma_ctx 23
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.24 * run scoreboard players set #roster_slot ma_ctx 24
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.25 * run scoreboard players set #roster_slot ma_ctx 25
execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.26 * run scoreboard players set #roster_slot ma_ctx 26
execute if score #roster_slot ma_ctx matches -1 run return run function magical_athlete:direct/space_notice
execute store result storage magical_athlete:direct roster.slot int 1 run scoreboard players get #roster_slot ma_ctx
function magical_athlete:direct/roster_item with storage magical_athlete:direct roster
