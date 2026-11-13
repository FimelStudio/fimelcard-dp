scoreboard players add #cards gd_ctx 1
execute unless score @s gd_type matches 0..53 run scoreboard players add #bad gd_ctx 1
function guandan:cards/normalize
execute if score @s gd_wild matches 1 run scoreboard players add #wild gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 2 run scoreboard players add #r2 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 3 run scoreboard players add #r3 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 4 run scoreboard players add #r4 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 5 run scoreboard players add #r5 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 6 run scoreboard players add #r6 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 7 run scoreboard players add #r7 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 8 run scoreboard players add #r8 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 9 run scoreboard players add #r9 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 10 run scoreboard players add #r10 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 11 run scoreboard players add #r11 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 12 run scoreboard players add #r12 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 13 run scoreboard players add #r13 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 14 run scoreboard players add #r14 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 15 run scoreboard players add #r15 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_point matches 16 run scoreboard players add #r16 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_suit matches 0 run scoreboard players add #s0 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_suit matches 1 run scoreboard players add #s1 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_suit matches 2 run scoreboard players add #s2 gd_ctx 1
execute if score @s gd_wild matches 0 if score @s gd_suit matches 3 run scoreboard players add #s3 gd_ctx 1
