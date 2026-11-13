execute unless score @s ct_state matches 1 run return 0
function magical_athlete:visual/context
data modify storage magical_athlete:visual info set value {text:"胡闹运动会",color:"gold",extra:[]}
function magical_athlete:visual/info_round with entity @s data.magical_athlete
scoreboard players set #info_actor ma_ctx 0
execute if score @s ma_state matches 1 run scoreboard players operation #info_actor ma_ctx = @s ma_turn
execute if score @s ma_state matches 3 run scoreboard players operation #info_actor ma_ctx = @s ma_turn
execute if score @s ma_pending matches 1.. run scoreboard players operation #info_actor ma_ctx = @s ma_pending
execute if score @s ma_anim matches 1.. store result score #info_actor ma_ctx run data get entity @s data.ma_feedback.last_actor
execute if data entity @s data.magical_athlete.p1.name run function magical_athlete:visual/info_row {side:1}
execute if data entity @s data.magical_athlete.p2.name run function magical_athlete:visual/info_row {side:2}
execute if data entity @s data.magical_athlete.p3.name run function magical_athlete:visual/info_row {side:3}
execute if data entity @s data.magical_athlete.p4.name run function magical_athlete:visual/info_row {side:4}
execute if data entity @s data.magical_athlete.p5.name run function magical_athlete:visual/info_row {side:5}
execute if data entity @s data.magical_athlete.p6.name run function magical_athlete:visual/info_row {side:6}
function magical_athlete:visual/info_sync with storage magical_athlete:visual
