# 先从4个数字中抽第1位，再从剩余3个抽第2位，最后在剩余2个中选择第3位。
execute store result score #code1 dc_ctx run random value 1..4
execute store result score #code2 dc_ctx run random value 1..3
execute if score #code2 dc_ctx >= #code1 dc_ctx run scoreboard players add #code2 dc_ctx 1
execute store result score #bit dc_ctx run random value 0..1
execute if score #code1 dc_ctx matches 1 if score #code2 dc_ctx matches 2 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 3
execute if score #code1 dc_ctx matches 1 if score #code2 dc_ctx matches 2 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 4
execute if score #code1 dc_ctx matches 1 if score #code2 dc_ctx matches 3 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 2
execute if score #code1 dc_ctx matches 1 if score #code2 dc_ctx matches 3 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 4
execute if score #code1 dc_ctx matches 1 if score #code2 dc_ctx matches 4 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 2
execute if score #code1 dc_ctx matches 1 if score #code2 dc_ctx matches 4 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 3
execute if score #code1 dc_ctx matches 2 if score #code2 dc_ctx matches 1 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 3
execute if score #code1 dc_ctx matches 2 if score #code2 dc_ctx matches 1 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 4
execute if score #code1 dc_ctx matches 2 if score #code2 dc_ctx matches 3 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 1
execute if score #code1 dc_ctx matches 2 if score #code2 dc_ctx matches 3 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 4
execute if score #code1 dc_ctx matches 2 if score #code2 dc_ctx matches 4 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 1
execute if score #code1 dc_ctx matches 2 if score #code2 dc_ctx matches 4 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 3
execute if score #code1 dc_ctx matches 3 if score #code2 dc_ctx matches 1 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 2
execute if score #code1 dc_ctx matches 3 if score #code2 dc_ctx matches 1 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 4
execute if score #code1 dc_ctx matches 3 if score #code2 dc_ctx matches 2 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 1
execute if score #code1 dc_ctx matches 3 if score #code2 dc_ctx matches 2 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 4
execute if score #code1 dc_ctx matches 3 if score #code2 dc_ctx matches 4 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 1
execute if score #code1 dc_ctx matches 3 if score #code2 dc_ctx matches 4 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 2
execute if score #code1 dc_ctx matches 4 if score #code2 dc_ctx matches 1 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 2
execute if score #code1 dc_ctx matches 4 if score #code2 dc_ctx matches 1 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 3
execute if score #code1 dc_ctx matches 4 if score #code2 dc_ctx matches 2 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 1
execute if score #code1 dc_ctx matches 4 if score #code2 dc_ctx matches 2 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 3
execute if score #code1 dc_ctx matches 4 if score #code2 dc_ctx matches 3 if score #bit dc_ctx matches 0 run scoreboard players set #code3 dc_ctx 1
execute if score #code1 dc_ctx matches 4 if score #code2 dc_ctx matches 3 if score #bit dc_ctx matches 1 run scoreboard players set #code3 dc_ctx 2
