function gomoku:game/init_table
execute unless score @s ct_joined matches 1..2 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[五子棋] 五子棋支持一至两名玩家，单人自动匹配人机。", "color": "black"}
execute unless score @s ct_joined matches 1..2 run return fail
function gomoku:system/context
scoreboard players set #online gm_ctx 0
scoreboard players set #blocked gm_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx run scoreboard players add #online gm_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}] run scoreboard players set #blocked gm_ctx 1
execute unless score #online gm_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[五子棋] 入座的玩家都需要在线。", "color": "black"}
execute unless score #online gm_ctx = @s ct_joined run return fail
execute if score #blocked gm_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[五子棋] 请先清空快捷栏最后一格（第9格）。", "color": "black"}
execute if score #blocked gm_ctx matches 1 run return fail
function gomoku:system/side_seats
scoreboard players set #black_ready gm_ctx 0
scoreboard players set #white_ready gm_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx run function gomoku:player/seat_side
execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx if score @s gm_weight matches 1 run scoreboard players add #black_ready gm_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx if score @s gm_weight matches -1 run scoreboard players add #white_ready gm_ctx 1
execute if score @s gm_first matches 1 run function gomoku:game/check_sides
execute if score @s gm_first matches 1 if score #side_ok gm_ctx matches 0 run function gomoku:game/seat_hint
execute if score @s gm_first matches 1 if score #side_ok gm_ctx matches 0 run return fail
execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx run function gomoku:player/init
function gomoku:system/context
function gomoku:game/assign_sides
function gomoku:game/reseat
function gomoku:ai/reset
data remove entity @s data.gomoku.ai_undo
function gomoku:settings/invalidate_table
data remove entity @s data.gomoku.review
scoreboard players set @s gm_state 1
scoreboard players set @s gm_sel -1
scoreboard players set @s gm_animundo 0
scoreboard players set @s gm_timer 0
scoreboard players set @s gm_pulse 0
scoreboard players set @s gm_draw 0
scoreboard players add @s gm_epoch 1
function gomoku:engine/init_board
function gomoku:visual/setup
scoreboard players operation @s gm_btime = @s gm_time
scoreboard players set #minute gm_ctx 1200
scoreboard players operation @s gm_btime *= #minute gm_ctx
scoreboard players operation @s gm_wtime = @s gm_btime
execute as @a[tag=gm.audience] run function gomoku:input/give
scoreboard players set @s ct_start 1
function gomoku:clock/create
function gomoku:ui/refresh
function gomoku:sound/start
tellraw @a[tag=gm.audience] {"text": "[五子棋] 黑方先行。右键交点落子，手持最后一格的对局菜单按 Q。", "color": "yellow"}
function gomoku:game/announce_sides
function gomoku:log {text:"对局开始"}
