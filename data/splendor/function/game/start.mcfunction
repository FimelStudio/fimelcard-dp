function splendor:settings/defaults
function splendor:system/context
execute unless score @s ct_joined matches 2..4 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[璀璨宝石] 需要2～4名真人玩家。",color:"red"}
execute unless score @s ct_joined matches 2..4 run return fail
scoreboard players set #online sp_ctx 0
scoreboard players set #blocked sp_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx run scoreboard players add #online sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.0 * unless items entity @s hotbar.0 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.0 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.1 * unless items entity @s hotbar.1 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.1 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.2 * unless items entity @s hotbar.2 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.2 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.3 * unless items entity @s hotbar.3 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.3 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.4 * unless items entity @s hotbar.4 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.4 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.5 * unless items entity @s hotbar.5 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.5 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.6 * unless items entity @s hotbar.6 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.6 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.7 * unless items entity @s hotbar.7 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.7 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 *[minecraft:custom_data~{splendor:{asset:1b}}] unless items entity @s hotbar.8 *[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute unless score #online sp_ctx = @s ct_joined run return fail
execute if score #blocked sp_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[璀璨宝石] 请先腾空快捷栏，前六格显示宝石，后三格显示预定牌。",color:"red"}
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
tellraw @a[tag=sp.audience] {text:"[璀璨宝石] 右键桌面选择、再次右键确认，左键取消。宝石不足时第三次右键可预定；牌堆右键两次可盲预定。手持自己的预定牌按两次Q购买。",color:"gold"}
function splendor:log {text:"璀璨宝石开始"}
