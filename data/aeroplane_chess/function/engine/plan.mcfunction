# 纯计划器：#plane/#color 输入，唯一骰子读取控制器；不会修改真实棋面或骰值。
scoreboard players set #legal ac_ctx 0
scoreboard players set #pos ac_ctx 99
data modify storage aeroplane_chess:runtime plan set value {queue:[]}
execute as @e[tag=ac.board] if score @s ac_plane = #plane ac_ctx if score @s ac_color = #color ac_ctx run scoreboard players operation #pos ac_ctx = @s ac_pos
execute unless score #pos ac_ctx matches -1..56 run return 0
scoreboard players operation #dice ac_ctx = @s ac_roll
execute unless score #dice ac_ctx matches 1..6 run return 0
execute if score #pos ac_ctx matches -1 run return run function aeroplane_chess:engine/takeoff
scoreboard players operation #end ac_ctx = #pos ac_ctx
scoreboard players operation #end ac_ctx += #dice ac_ctx
execute if score @s ac_finish matches 1 if score #end ac_ctx matches 58.. run return 0
scoreboard players set #direction ac_ctx 1
scoreboard players set #usedjump ac_ctx 0
scoreboard players set #usedfly ac_ctx 0
function aeroplane_chess:engine/steps
data modify storage aeroplane_chess:runtime plan.queue[-1].land set value 1
function aeroplane_chess:engine/special
function aeroplane_chess:engine/special
scoreboard players set #legal ac_ctx 1
scoreboard players operation #dest ac_ctx = #pos ac_ctx
