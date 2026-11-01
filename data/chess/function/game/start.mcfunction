function chess:game/init_table
execute unless score @s ct_joined matches 1..2 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[国际象棋] 国际象棋支持一至两名玩家，单人自动匹配人机。", "color": "red"}
execute unless score @s ct_joined matches 1..2 run return fail
function chess:system/context
scoreboard players set #online ch_ctx 0
scoreboard players set #blocked ch_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx run scoreboard players add #online ch_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}] run scoreboard players set #blocked ch_ctx 1
execute unless score #online ch_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[国际象棋] 入座的玩家都需要在线。", "color": "red"}
execute unless score #online ch_ctx = @s ct_joined run return fail
execute if score #blocked ch_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[国际象棋] 请先清空快捷栏最后一格（第9格）。", "color": "red"}
execute if score #blocked ch_ctx matches 1 run return fail
function chess:system/side_seats
scoreboard players set #white_ready ch_ctx 0
scoreboard players set #black_ready ch_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx run function chess:player/seat_side
execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx if score @s ch_weight matches 1 run scoreboard players add #white_ready ch_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx if score @s ch_weight matches -1 run scoreboard players add #black_ready ch_ctx 1
execute if score @s ch_first matches 1 run function chess:game/check_sides
execute if score @s ch_first matches 1 if score #side_ok ch_ctx matches 0 run function chess:game/seat_hint
execute if score @s ch_first matches 1 if score #side_ok ch_ctx matches 0 run return fail
execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx run function chess:player/init
function chess:system/context
function chess:game/assign_sides
execute store result score #seats_ok ch_ctx run function chess:game/reseat
execute unless score #seats_ok ch_ctx matches 1 run return run function chess:game/abort
function chess:ai/reset
data remove entity @s data.chess.ai_undo
function chess:settings/invalidate_table
data remove entity @s data.chess.review
scoreboard players set @s ch_state 1
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_timer 0
scoreboard players set @s ch_pulse 0
scoreboard players set @s ch_draw 0
scoreboard players add @s ch_epoch 1
function chess:engine/init_board
function chess:visual/setup
scoreboard players operation @s ch_wtime = @s ch_time
scoreboard players set #minute ch_ctx 1200
scoreboard players operation @s ch_wtime *= #minute ch_ctx
scoreboard players operation @s ch_btime = @s ch_wtime
execute as @a[tag=ch.audience] run function chess:input/give
scoreboard players set @s ct_start 1
function chess:clock/create
function chess:ui/refresh
function chess:sound/start
tellraw @a[tag=ch.audience] {"text": "[国际象棋] 白方先行。右键选子、落子；手持最后一格的对局菜单按 Q。", "color": "yellow"}
function chess:game/announce_sides
function chess:log {text:"对局开始"}
