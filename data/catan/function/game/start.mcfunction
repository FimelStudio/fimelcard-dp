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
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.7 * unless items entity @s hotbar.7 *[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 *[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.0 * unless items entity @s hotbar.0 *[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.1 * unless items entity @s hotbar.1 *[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.2 * unless items entity @s hotbar.2 *[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.6 * unless items entity @s hotbar.6 *[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.7 * unless items entity @s hotbar.7 *[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 *[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1
execute unless score #online ca_ctx = @s ct_joined run return fail
execute if score #blocked ca_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[卡坦岛] 请先清空快捷栏。", "color": "red"}
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
tellraw @a[tag=ca.audience] {"text": "[卡坦岛] 先顺序、再逆序免费放村庄＋相邻道路；第二个村庄领取起始资源。", "color": "yellow"}
tellraw @a[tag=ca.audience] {"text": "[卡坦岛] 第1格 Q 瞄准交点／边，第9格 Q 打开菜单；看屏幕下方提示，菜单内可随时查看「新手入门」。", "color": "aqua"}
function catan:game/hud
function cardtable:log {text:"卡坦岛开始"}
