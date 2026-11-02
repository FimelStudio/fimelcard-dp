function catan:settings/defaults
function catan:system/context
execute unless score @s ca_epoch matches 1.. run scoreboard players set @s ca_epoch 1
execute unless score @s ct_joined matches 3..4 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[卡坦岛] 需要 3–4 名真人玩家。", "color": "red"}
execute unless score @s ct_joined matches 3..4 run return fail
scoreboard players set #online ca_ctx 0
scoreboard players set #blocked ca_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx run scoreboard players add #online ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.0 * unless items entity @s hotbar.0 minecraft:paper[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute unless score #online ca_ctx = @s ct_joined run return fail
execute if score #blocked ca_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[卡坦岛] 请先清空快捷栏第 1 格和最后一格。", "color": "red"}
execute if score #blocked ca_ctx matches 1 run return fail
execute as @a[tag=ca.player] if score @s ca_table = #table ca_ctx run function catan:player/clear_state
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx run function catan:player/init
function catan:system/context
scoreboard players set @a[tag=ca.audience] ca_side 0
scoreboard players operation #players ca_ctx = @s ct_joined
scoreboard players operation #layout ca_ctx = @s ca_layout
scoreboard players operation #saved_epoch ca_ctx = @s ca_epoch
function catan:engine/init
scoreboard players operation @s ca_epoch = #saved_epoch ca_ctx
scoreboard players add @s ca_epoch 1
execute store result entity @s data.catan.epoch int 1 run scoreboard players get @s ca_epoch
function catan:game/assign
function catan:settings/invalidate_table
scoreboard players set @s ca_anim 0
scoreboard players set @s ca_finish 0
scoreboard players set @s ca_offline 0
function catan:game/sync
function catan:visual/refresh
function catan:input/create_surface
execute as @a[tag=ca.audience] run function catan:input/give
function catan:sound/start
scoreboard players set @s ct_start 1
tellraw @a[tag=ca.audience] {"text": "[卡坦岛] 按顺序放置村庄和道路；第二轮逆序。第 1 格按 Q 瞄准，最后一格按 Q 打开菜单。", "color": "yellow"}
function cardtable:log {text:"卡坦岛开始"}
