function magical_athlete:settings/defaults
function magical_athlete:system/context
execute unless score @s ct_joined matches 2..6 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[胡闹运动会] 需要2～6名真人玩家。",color:"red"}
execute unless score @s ct_joined matches 2..6 run return fail
scoreboard players set #online ma_ctx 0
scoreboard players set #blocked ma_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx run scoreboard players add #online ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.7 * unless items entity @s hotbar.7 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.0 * unless items entity @s hotbar.0 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.1 * unless items entity @s hotbar.1 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.2 * unless items entity @s hotbar.2 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.3 * unless items entity @s hotbar.3 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.4 * unless items entity @s hotbar.4 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.5 * unless items entity @s hotbar.5 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.6 * unless items entity @s hotbar.6 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute unless score #online ma_ctx = @s ct_joined run return fail
execute if score #blocked ma_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[胡闹运动会] 请先腾空快捷栏。",color:"red"}
execute if score #blocked ma_ctx matches 1 run return fail
execute as @a[tag=ma.player] if score @s ma_table = #table ma_ctx run function magical_athlete:player/clear_state
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx run function magical_athlete:player/init
function magical_athlete:system/context
scoreboard players operation #players ma_ctx = @s ct_joined
function magical_athlete:engine/init
scoreboard players set @a[tag=ma.audience] ma_side 0
function magical_athlete:game/assign
function magical_athlete:settings/invalidate_table
scoreboard players set @s ma_finish 0
scoreboard players set @s ma_anim 0
scoreboard players set @s ma_pulse 0
function magical_athlete:game/sync
function magical_athlete:visual/refresh
execute as @a[tag=ma.audience] run function magical_athlete:input/give
function magical_athlete:sound/start
function magical_athlete:sound/race_start
scoreboard players set @s ct_start 1
tellraw @a[tag=ma.audience] {text:"[胡闹运动会] 开始四场积分赛！快捷栏最后一格按Q打开比赛菜单。",color:"gold"}
function magical_athlete:ui/refresh
