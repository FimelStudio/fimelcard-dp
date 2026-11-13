function xiangqi:game/init_table
execute unless score @s ct_joined matches 1..2 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[中国象棋] 中国象棋支持一至两名玩家，单人自动匹配人机。", "color": "red"}
execute unless score @s ct_joined matches 1..2 run return fail
function xiangqi:system/context
scoreboard players set #online xq_ctx 0
scoreboard players set #blocked xq_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx run scoreboard players add #online xq_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}] run scoreboard players set #blocked xq_ctx 1
execute unless score #online xq_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[中国象棋] 入座的玩家都需要在线。", "color": "red"}
execute unless score #online xq_ctx = @s ct_joined run return fail
execute if score #blocked xq_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {"text": "[中国象棋] 请先清空快捷栏最后一格（第9格）。", "color": "red"}
execute if score #blocked xq_ctx matches 1 run return fail
function xiangqi:system/side_seats
scoreboard players set #red_ready xq_ctx 0
scoreboard players set #black_ready xq_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx run function xiangqi:player/seat_side
execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx if score @s xq_weight matches 1 run scoreboard players add #red_ready xq_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx if score @s xq_weight matches -1 run scoreboard players add #black_ready xq_ctx 1
execute if score @s xq_first matches 1 run function xiangqi:game/check_sides
execute if score @s xq_first matches 1 if score #side_ok xq_ctx matches 0 run function xiangqi:game/seat_hint
execute if score @s xq_first matches 1 if score #side_ok xq_ctx matches 0 run return fail
execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx run function xiangqi:player/init
function xiangqi:system/context
function xiangqi:game/assign_sides
execute store result score #seats_ok xq_ctx run function xiangqi:game/reseat
execute unless score #seats_ok xq_ctx matches 1 run return run function xiangqi:game/abort
function xiangqi:ai/reset
data remove entity @s data.xiangqi.ai_undo
function xiangqi:settings/invalidate_table
data remove entity @s data.xiangqi.review
scoreboard players set @s xq_state 1
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_timer 0
scoreboard players set @s xq_pulse 0
scoreboard players set @s xq_draw 0
scoreboard players add @s xq_epoch 1
function xiangqi:engine/init_board
function xiangqi:visual/setup
scoreboard players operation @s xq_rtime = @s xq_time
scoreboard players set #minute xq_ctx 1200
scoreboard players operation @s xq_rtime *= #minute xq_ctx
scoreboard players operation @s xq_btime = @s xq_rtime
execute as @a[tag=xq.audience] run function xiangqi:input/give
scoreboard players set @s ct_start 1
function xiangqi:clock/create
function xiangqi:ui/refresh
function xiangqi:sound/start
tellraw @a[tag=xq.audience] {"text": "[中国象棋] 红方先行。右键选子、落子；手持最后一格的对局菜单按 Q。", "color": "yellow"}
function xiangqi:game/announce_sides
function xiangqi:log {text:"对局开始"}
