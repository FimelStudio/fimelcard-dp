scoreboard players set #winner ma_ctx 0
scoreboard players set #r1 ma_ctx 0
execute if score #players ma_ctx matches 1.. run execute store result score #r1 ma_ctx run random value 1..6
scoreboard players set #r2 ma_ctx 0
execute if score #players ma_ctx matches 2.. run execute store result score #r2 ma_ctx run random value 1..6
scoreboard players set #r3 ma_ctx 0
execute if score #players ma_ctx matches 3.. run execute store result score #r3 ma_ctx run random value 1..6
scoreboard players set #r4 ma_ctx 0
execute if score #players ma_ctx matches 4.. run execute store result score #r4 ma_ctx run random value 1..6
scoreboard players set #r5 ma_ctx 0
execute if score #players ma_ctx matches 5.. run execute store result score #r5 ma_ctx run random value 1..6
scoreboard players set #r6 ma_ctx 0
execute if score #players ma_ctx matches 6.. run execute store result score #r6 ma_ctx run random value 1..6
scoreboard players set #ties ma_ctx 0
execute if score #r1 ma_ctx matches 6 run scoreboard players add #ties ma_ctx 1
execute if score #r2 ma_ctx matches 6 run scoreboard players add #ties ma_ctx 1
execute if score #r3 ma_ctx matches 6 run scoreboard players add #ties ma_ctx 1
execute if score #r4 ma_ctx matches 6 run scoreboard players add #ties ma_ctx 1
execute if score #r5 ma_ctx matches 6 run scoreboard players add #ties ma_ctx 1
execute if score #r6 ma_ctx matches 6 run scoreboard players add #ties ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r1 ma_ctx matches 6 run scoreboard players set #winner ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r2 ma_ctx matches 6 run scoreboard players set #winner ma_ctx 2
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r3 ma_ctx matches 6 run scoreboard players set #winner ma_ctx 3
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r4 ma_ctx matches 6 run scoreboard players set #winner ma_ctx 4
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r5 ma_ctx matches 6 run scoreboard players set #winner ma_ctx 5
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r6 ma_ctx matches 6 run scoreboard players set #winner ma_ctx 6
scoreboard players set #ties ma_ctx 0
execute if score #r1 ma_ctx matches 5 run scoreboard players add #ties ma_ctx 1
execute if score #r2 ma_ctx matches 5 run scoreboard players add #ties ma_ctx 1
execute if score #r3 ma_ctx matches 5 run scoreboard players add #ties ma_ctx 1
execute if score #r4 ma_ctx matches 5 run scoreboard players add #ties ma_ctx 1
execute if score #r5 ma_ctx matches 5 run scoreboard players add #ties ma_ctx 1
execute if score #r6 ma_ctx matches 5 run scoreboard players add #ties ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r1 ma_ctx matches 5 run scoreboard players set #winner ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r2 ma_ctx matches 5 run scoreboard players set #winner ma_ctx 2
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r3 ma_ctx matches 5 run scoreboard players set #winner ma_ctx 3
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r4 ma_ctx matches 5 run scoreboard players set #winner ma_ctx 4
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r5 ma_ctx matches 5 run scoreboard players set #winner ma_ctx 5
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r6 ma_ctx matches 5 run scoreboard players set #winner ma_ctx 6
scoreboard players set #ties ma_ctx 0
execute if score #r1 ma_ctx matches 4 run scoreboard players add #ties ma_ctx 1
execute if score #r2 ma_ctx matches 4 run scoreboard players add #ties ma_ctx 1
execute if score #r3 ma_ctx matches 4 run scoreboard players add #ties ma_ctx 1
execute if score #r4 ma_ctx matches 4 run scoreboard players add #ties ma_ctx 1
execute if score #r5 ma_ctx matches 4 run scoreboard players add #ties ma_ctx 1
execute if score #r6 ma_ctx matches 4 run scoreboard players add #ties ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r1 ma_ctx matches 4 run scoreboard players set #winner ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r2 ma_ctx matches 4 run scoreboard players set #winner ma_ctx 2
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r3 ma_ctx matches 4 run scoreboard players set #winner ma_ctx 3
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r4 ma_ctx matches 4 run scoreboard players set #winner ma_ctx 4
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r5 ma_ctx matches 4 run scoreboard players set #winner ma_ctx 5
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r6 ma_ctx matches 4 run scoreboard players set #winner ma_ctx 6
scoreboard players set #ties ma_ctx 0
execute if score #r1 ma_ctx matches 3 run scoreboard players add #ties ma_ctx 1
execute if score #r2 ma_ctx matches 3 run scoreboard players add #ties ma_ctx 1
execute if score #r3 ma_ctx matches 3 run scoreboard players add #ties ma_ctx 1
execute if score #r4 ma_ctx matches 3 run scoreboard players add #ties ma_ctx 1
execute if score #r5 ma_ctx matches 3 run scoreboard players add #ties ma_ctx 1
execute if score #r6 ma_ctx matches 3 run scoreboard players add #ties ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r1 ma_ctx matches 3 run scoreboard players set #winner ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r2 ma_ctx matches 3 run scoreboard players set #winner ma_ctx 2
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r3 ma_ctx matches 3 run scoreboard players set #winner ma_ctx 3
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r4 ma_ctx matches 3 run scoreboard players set #winner ma_ctx 4
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r5 ma_ctx matches 3 run scoreboard players set #winner ma_ctx 5
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r6 ma_ctx matches 3 run scoreboard players set #winner ma_ctx 6
scoreboard players set #ties ma_ctx 0
execute if score #r1 ma_ctx matches 2 run scoreboard players add #ties ma_ctx 1
execute if score #r2 ma_ctx matches 2 run scoreboard players add #ties ma_ctx 1
execute if score #r3 ma_ctx matches 2 run scoreboard players add #ties ma_ctx 1
execute if score #r4 ma_ctx matches 2 run scoreboard players add #ties ma_ctx 1
execute if score #r5 ma_ctx matches 2 run scoreboard players add #ties ma_ctx 1
execute if score #r6 ma_ctx matches 2 run scoreboard players add #ties ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r1 ma_ctx matches 2 run scoreboard players set #winner ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r2 ma_ctx matches 2 run scoreboard players set #winner ma_ctx 2
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r3 ma_ctx matches 2 run scoreboard players set #winner ma_ctx 3
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r4 ma_ctx matches 2 run scoreboard players set #winner ma_ctx 4
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r5 ma_ctx matches 2 run scoreboard players set #winner ma_ctx 5
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r6 ma_ctx matches 2 run scoreboard players set #winner ma_ctx 6
scoreboard players set #ties ma_ctx 0
execute if score #r1 ma_ctx matches 1 run scoreboard players add #ties ma_ctx 1
execute if score #r2 ma_ctx matches 1 run scoreboard players add #ties ma_ctx 1
execute if score #r3 ma_ctx matches 1 run scoreboard players add #ties ma_ctx 1
execute if score #r4 ma_ctx matches 1 run scoreboard players add #ties ma_ctx 1
execute if score #r5 ma_ctx matches 1 run scoreboard players add #ties ma_ctx 1
execute if score #r6 ma_ctx matches 1 run scoreboard players add #ties ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r1 ma_ctx matches 1 run scoreboard players set #winner ma_ctx 1
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r2 ma_ctx matches 1 run scoreboard players set #winner ma_ctx 2
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r3 ma_ctx matches 1 run scoreboard players set #winner ma_ctx 3
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r4 ma_ctx matches 1 run scoreboard players set #winner ma_ctx 4
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r5 ma_ctx matches 1 run scoreboard players set #winner ma_ctx 5
execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r6 ma_ctx matches 1 run scoreboard players set #winner ma_ctx 6
execute if score #winner ma_ctx matches 0 run function magical_athlete:engine/rolloff
