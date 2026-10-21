# 只统计本桌另外两家的在手牌；不改变 dd.current 或手牌选择。
scoreboard players set #counter_17 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=17,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_17 dd_ctx 1
scoreboard players set #counter_16 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=16,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_16 dd_ctx 1
scoreboard players set #counter_15 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=15,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_15 dd_ctx 1
scoreboard players set #counter_14 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=14,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_14 dd_ctx 1
scoreboard players set #counter_13 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=13,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_13 dd_ctx 1
scoreboard players set #counter_12 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=12,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_12 dd_ctx 1
scoreboard players set #counter_11 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=11,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_11 dd_ctx 1
scoreboard players set #counter_10 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=10,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_10 dd_ctx 1
scoreboard players set #counter_9 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=9,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_9 dd_ctx 1
scoreboard players set #counter_8 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=8,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_8 dd_ctx 1
scoreboard players set #counter_7 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=7,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_7 dd_ctx 1
scoreboard players set #counter_6 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=6,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_6 dd_ctx 1
scoreboard players set #counter_5 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=5,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_5 dd_ctx 1
scoreboard players set #counter_4 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=4,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_4 dd_ctx 1
scoreboard players set #counter_3 dd_ctx 0
execute as @e[tag=dd.card,scores={dd_rank=3,dd_owner=1..8}] if score @s dd_id = #hud_table dd_ctx unless score @s dd_owner = #hud_viewer dd_ctx run scoreboard players add #counter_3 dd_ctx 1
