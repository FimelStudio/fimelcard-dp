scoreboard players set #found ma_ctx 0
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[0] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[0]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:0}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[1] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[1]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:1}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[2] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[2]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:2}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[3] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[3]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:3}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[4] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[4]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:4}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[5] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[5]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:5}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[6] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[6]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:6}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[7] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[7]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:7}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[8] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[8]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:8}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[9] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[9]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:9}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[10] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[10]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:10}
scoreboard players set #id ma_ctx -999
execute if data storage magical_athlete:engine s.pool[11] run execute store result score #id ma_ctx run data get storage magical_athlete:engine s.pool[11]
execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run function magical_athlete:engine/draft/take {slot:11}
