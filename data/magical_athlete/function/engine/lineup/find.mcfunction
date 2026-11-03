$execute store result score #len ma_ctx run data get storage magical_athlete:engine s.p$(actor).selected
execute if score #n ma_ctx matches 2 if score #len ma_ctx matches 2.. run return run function magical_athlete:engine/error {id:6}
execute if score #n ma_ctx matches 3.. if score #len ma_ctx matches 1.. run return run function magical_athlete:engine/error {id:6}
scoreboard players set #id ma_ctx -999
$execute if data storage magical_athlete:engine s.p$(actor).hand[0] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.p$(actor).hand[0]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/lineup/take {slot:0}
scoreboard players set #id ma_ctx -999
$execute if data storage magical_athlete:engine s.p$(actor).hand[1] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.p$(actor).hand[1]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/lineup/take {slot:1}
scoreboard players set #id ma_ctx -999
$execute if data storage magical_athlete:engine s.p$(actor).hand[2] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.p$(actor).hand[2]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/lineup/take {slot:2}
scoreboard players set #id ma_ctx -999
$execute if data storage magical_athlete:engine s.p$(actor).hand[3] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.p$(actor).hand[3]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/lineup/take {slot:3}
scoreboard players set #id ma_ctx -999
$execute if data storage magical_athlete:engine s.p$(actor).hand[4] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.p$(actor).hand[4]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/lineup/take {slot:4}
scoreboard players set #id ma_ctx -999
$execute if data storage magical_athlete:engine s.p$(actor).hand[5] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.p$(actor).hand[5]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/lineup/take {slot:5}
scoreboard players set #id ma_ctx -999
$execute if data storage magical_athlete:engine s.p$(actor).hand[6] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.p$(actor).hand[6]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/lineup/take {slot:6}
scoreboard players set #id ma_ctx -999
$execute if data storage magical_athlete:engine s.p$(actor).hand[7] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.p$(actor).hand[7]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/lineup/take {slot:7}
