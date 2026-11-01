function weiqi:game/config
execute unless score @s ct_joined matches 1..2 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[围棋] 支持一至两名玩家，单人由基础人机陪练。", "color": "red"}
execute unless score @s ct_joined matches 1..2 run return fail
function weiqi:system/context
scoreboard players set #online go_ctx 0
scoreboard players set #blocked go_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx run scoreboard players add #online go_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{weiqi:{tool:1b}}] run scoreboard players set #blocked go_ctx 1
execute unless score #online go_ctx = @s ct_joined run return fail
execute if score #blocked go_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[围棋] 请先清空快捷栏最后一格。", "color": "red"}
execute if score #blocked go_ctx matches 1 run return fail
function weiqi:system/side_seats
scoreboard players set #black_ready go_ctx 0
scoreboard players set #white_ready go_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx run function weiqi:player/seat_side
execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx if score @s go_weight matches 1 run scoreboard players add #black_ready go_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx if score @s go_weight matches -1 run scoreboard players add #white_ready go_ctx 1
function weiqi:game/check_sides
execute if score @s go_first matches 1 if score #side_ok go_ctx matches 0 run function weiqi:game/seat_hint
execute if score @s go_first matches 1 if score #side_ok go_ctx matches 0 run return fail
execute as @a[tag=go.player] if score @s go_table = #table go_ctx run function weiqi:player/clear_state
execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx run function weiqi:player/init
function weiqi:system/context
function weiqi:system/side_seats
execute as @a[tag=go.audience] run function weiqi:player/seat_side
function weiqi:game/assign_sides
function weiqi:game/reseat
execute unless score #seats_ok go_ctx matches 1 run function weiqi:game/start_failed
execute unless score #seats_ok go_ctx matches 1 run return fail
function weiqi:settings/invalidate_table
data remove entity @s data.weiqi.review
data remove entity @s data.weiqi.finalresult
data remove entity @s data.weiqi.result
function weiqi:system/create_board
scoreboard players operation @s go_btime = @s go_time
scoreboard players operation @s go_btime *= #minute go_ctx
scoreboard players operation @s go_wtime = @s go_btime
function weiqi:engine/init_board
scoreboard players set @s go_state 1
scoreboard players set @s go_sel -1
scoreboard players set @s go_timer 0
scoreboard players set @s go_result 0
scoreboard players set @s go_reason 0
scoreboard players set @s go_pulse 0
scoreboard players set @s go_undo 0
scoreboard players set @s go_bconfirm 0
scoreboard players set @s go_wconfirm 0
scoreboard players set @s go_autoplay 0
scoreboard players add @s go_epoch 1
function weiqi:ai/reset
function weiqi:game/capture_names
function weiqi:visual/setup
execute as @a[tag=go.audience] run function weiqi:input/give
scoreboard players set @s ct_start 1
function weiqi:clock/create
function weiqi:ui/refresh
function weiqi:sound/start
tellraw @a[tag=go.audience] {"text": "[围棋] 黑方先行。右键交点落子，最后一格按 Q 打开对局菜单。双方连续停一手后确认死活并计分。", "color": "yellow"}
function weiqi:game/announce_sides
function weiqi:log {text:"围棋开始"}
