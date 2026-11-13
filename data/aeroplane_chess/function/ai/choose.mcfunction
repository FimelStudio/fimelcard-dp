scoreboard players set #best ac_ctx -9999
scoreboard players set #bestplane ac_ctx -1
scoreboard players operation #color ac_ctx = @s ac_turn
function aeroplane_chess:ai/candidate {plane:0}
function aeroplane_chess:ai/candidate {plane:1}
function aeroplane_chess:ai/candidate {plane:2}
function aeroplane_chess:ai/candidate {plane:3}
execute unless score #bestplane ac_ctx matches 0..3 run return run function aeroplane_chess:game/no_moves
scoreboard players operation #plane ac_ctx = #bestplane ac_ctx
function aeroplane_chess:game/choose_internal
