function splendor:settings/defaults
function splendor:system/context
execute unless score @s ct_joined matches 2..4 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[璀璨宝石] 需要2～4名真人玩家。",color:"red"}
execute unless score @s ct_joined matches 2..4 run return fail
scoreboard players set #online sp_ctx 0
scoreboard players set #blocked sp_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx run scoreboard players add #online sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute unless score #online sp_ctx = @s ct_joined run return fail
execute if score #blocked sp_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[璀璨宝石] 请先腾空快捷栏最后一格。",color:"red"}
execute if score #blocked sp_ctx matches 1 run return fail
execute as @a[tag=sp.player] if score @s sp_table = #table sp_ctx run function splendor:player/clear_state
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx run function splendor:player/init
function splendor:system/context
scoreboard players operation #players sp_ctx = @s ct_joined
function splendor:engine/init
scoreboard players operation #players sp_ctx = @s ct_joined
scoreboard players set @a[tag=sp.audience] sp_side 0
function splendor:game/assign
function splendor:settings/invalidate_table
scoreboard players set @s sp_finish 0
scoreboard players set @s sp_anim 0
function splendor:game/sync
function splendor:visual/refresh
execute as @a[tag=sp.audience] run function splendor:input/give
function splendor:sound/start
scoreboard players set @s ct_start 1
tellraw @a[tag=sp.audience] {text:"[璀璨宝石] 开始交易！快捷栏最后一格按Q打开宝石市场与预约牌。",color:"gold"}
function splendor:log {text:"璀璨宝石开始"}
