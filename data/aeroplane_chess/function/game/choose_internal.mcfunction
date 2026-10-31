execute unless score @s ac_state matches 3 run return 0
execute unless score #plane ac_ctx matches 0..3 run return 0
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players operation @s ac_selected = #plane ac_ctx
function aeroplane_chess:engine/plan
execute unless score #legal ac_ctx matches 1 run return run function aeroplane_chess:sound/illegal
data modify entity @s data.aeroplane_chess.queue set from storage aeroplane_chess:runtime plan.queue
scoreboard players set @s ac_state 4
scoreboard players add @s ac_epoch 1
function aeroplane_chess:log {text:"选机合法，提交持久移动队列"}
scoreboard players set @e[tag=ac.board] ac_legal 0
function aeroplane_chess:visual/select
function aeroplane_chess:game/segment_begin
function aeroplane_chess:ui/refresh
