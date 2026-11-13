execute unless score #phase ma_ctx matches 2 run return run function magical_athlete:engine/error {id:5}
execute unless score #target ma_ctx matches 0..35 run return run function magical_athlete:engine/error {id:8}
scoreboard players set #found ma_ctx 0
function magical_athlete:engine/lineup/find with storage magical_athlete:engine request
execute unless score #found ma_ctx matches 1 run return run function magical_athlete:engine/error {id:8}
scoreboard players set #ready ma_ctx 0
execute if score #n ma_ctx matches 1.. run execute store result score #len ma_ctx run data get storage magical_athlete:engine s.p1.selected
execute if score #n ma_ctx matches 2 if score #n ma_ctx matches 1.. if score #len ma_ctx matches 2 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 1.. if score #len ma_ctx matches 1 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 2.. run execute store result score #len ma_ctx run data get storage magical_athlete:engine s.p2.selected
execute if score #n ma_ctx matches 2 if score #n ma_ctx matches 2.. if score #len ma_ctx matches 2 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 2.. if score #len ma_ctx matches 1 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 3.. run execute store result score #len ma_ctx run data get storage magical_athlete:engine s.p3.selected
execute if score #n ma_ctx matches 2 if score #n ma_ctx matches 3.. if score #len ma_ctx matches 2 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 3.. if score #len ma_ctx matches 1 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 4.. run execute store result score #len ma_ctx run data get storage magical_athlete:engine s.p4.selected
execute if score #n ma_ctx matches 2 if score #n ma_ctx matches 4.. if score #len ma_ctx matches 2 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 4.. if score #len ma_ctx matches 1 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 5.. run execute store result score #len ma_ctx run data get storage magical_athlete:engine s.p5.selected
execute if score #n ma_ctx matches 2 if score #n ma_ctx matches 5.. if score #len ma_ctx matches 2 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 5.. if score #len ma_ctx matches 1 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 6.. run execute store result score #len ma_ctx run data get storage magical_athlete:engine s.p6.selected
execute if score #n ma_ctx matches 2 if score #n ma_ctx matches 6.. if score #len ma_ctx matches 2 run scoreboard players add #ready ma_ctx 1
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 6.. if score #len ma_ctx matches 1 run scoreboard players add #ready ma_ctx 1
execute if score #ready ma_ctx = #n ma_ctx run function magical_athlete:engine/lineup/reveal
scoreboard players set #ok ma_ctx 1
