# 经典牌型：单、对、三、三带、顺子、连对、飞机、四带、炸弹、王炸。
scoreboard players set #type dd_ctx 0
scoreboard players set #high dd_ctx 0
scoreboard players set #n dd_ctx 0
scoreboard players set #r3 dd_ctx 0
scoreboard players set #r4 dd_ctx 0
scoreboard players set #r5 dd_ctx 0
scoreboard players set #r6 dd_ctx 0
scoreboard players set #r7 dd_ctx 0
scoreboard players set #r8 dd_ctx 0
scoreboard players set #r9 dd_ctx 0
scoreboard players set #r10 dd_ctx 0
scoreboard players set #r11 dd_ctx 0
scoreboard players set #r12 dd_ctx 0
scoreboard players set #r13 dd_ctx 0
scoreboard players set #r14 dd_ctx 0
scoreboard players set #r15 dd_ctx 0
scoreboard players set #r16 dd_ctx 0
scoreboard players set #r17 dd_ctx 0
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=3}] run scoreboard players add #r3 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=4}] run scoreboard players add #r4 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=5}] run scoreboard players add #r5 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=6}] run scoreboard players add #r6 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=7}] run scoreboard players add #r7 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=8}] run scoreboard players add #r8 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=9}] run scoreboard players add #r9 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=10}] run scoreboard players add #r10 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=11}] run scoreboard players add #r11 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=12}] run scoreboard players add #r12 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=13}] run scoreboard players add #r13 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=14}] run scoreboard players add #r14 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=15}] run scoreboard players add #r15 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=16}] run scoreboard players add #r16 dd_ctx 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_rank=17}] run scoreboard players add #r17 dd_ctx 1
scoreboard players operation #n dd_ctx += #r3 dd_ctx
scoreboard players operation #n dd_ctx += #r4 dd_ctx
scoreboard players operation #n dd_ctx += #r5 dd_ctx
scoreboard players operation #n dd_ctx += #r6 dd_ctx
scoreboard players operation #n dd_ctx += #r7 dd_ctx
scoreboard players operation #n dd_ctx += #r8 dd_ctx
scoreboard players operation #n dd_ctx += #r9 dd_ctx
scoreboard players operation #n dd_ctx += #r10 dd_ctx
scoreboard players operation #n dd_ctx += #r11 dd_ctx
scoreboard players operation #n dd_ctx += #r12 dd_ctx
scoreboard players operation #n dd_ctx += #r13 dd_ctx
scoreboard players operation #n dd_ctx += #r14 dd_ctx
scoreboard players operation #n dd_ctx += #r15 dd_ctx
scoreboard players operation #n dd_ctx += #r16 dd_ctx
scoreboard players operation #n dd_ctx += #r17 dd_ctx
execute if score #n dd_ctx matches 1 if score #r3 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:3}
execute if score #n dd_ctx matches 2 if score #r3 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:3}
execute if score #n dd_ctx matches 3 if score #r3 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:3}
execute if score #n dd_ctx matches 4 if score #r3 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:3}
execute if score #n dd_ctx matches 4 if score #r3 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:3}
execute if score #n dd_ctx matches 1 if score #r4 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:4}
execute if score #n dd_ctx matches 2 if score #r4 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:4}
execute if score #n dd_ctx matches 3 if score #r4 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:4}
execute if score #n dd_ctx matches 4 if score #r4 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:4}
execute if score #n dd_ctx matches 4 if score #r4 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:4}
execute if score #n dd_ctx matches 1 if score #r5 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:5}
execute if score #n dd_ctx matches 2 if score #r5 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:5}
execute if score #n dd_ctx matches 3 if score #r5 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:5}
execute if score #n dd_ctx matches 4 if score #r5 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:5}
execute if score #n dd_ctx matches 4 if score #r5 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:5}
execute if score #n dd_ctx matches 1 if score #r6 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:6}
execute if score #n dd_ctx matches 2 if score #r6 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:6}
execute if score #n dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:6}
execute if score #n dd_ctx matches 4 if score #r6 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:6}
execute if score #n dd_ctx matches 4 if score #r6 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:6}
execute if score #n dd_ctx matches 1 if score #r7 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:7}
execute if score #n dd_ctx matches 2 if score #r7 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:7}
execute if score #n dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:7}
execute if score #n dd_ctx matches 4 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:7}
execute if score #n dd_ctx matches 4 if score #r7 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:7}
execute if score #n dd_ctx matches 1 if score #r8 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:8}
execute if score #n dd_ctx matches 2 if score #r8 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:8}
execute if score #n dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:8}
execute if score #n dd_ctx matches 4 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:8}
execute if score #n dd_ctx matches 4 if score #r8 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:8}
execute if score #n dd_ctx matches 1 if score #r9 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:9}
execute if score #n dd_ctx matches 2 if score #r9 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:9}
execute if score #n dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:9}
execute if score #n dd_ctx matches 4 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:9}
execute if score #n dd_ctx matches 4 if score #r9 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:9}
execute if score #n dd_ctx matches 1 if score #r10 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:10}
execute if score #n dd_ctx matches 2 if score #r10 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:10}
execute if score #n dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:10}
execute if score #n dd_ctx matches 4 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:10}
execute if score #n dd_ctx matches 4 if score #r10 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:10}
execute if score #n dd_ctx matches 1 if score #r11 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:11}
execute if score #n dd_ctx matches 2 if score #r11 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:11}
execute if score #n dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:11}
execute if score #n dd_ctx matches 4 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:11}
execute if score #n dd_ctx matches 4 if score #r11 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:11}
execute if score #n dd_ctx matches 1 if score #r12 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:12}
execute if score #n dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:12}
execute if score #n dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:12}
execute if score #n dd_ctx matches 4 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:12}
execute if score #n dd_ctx matches 4 if score #r12 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:12}
execute if score #n dd_ctx matches 1 if score #r13 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:13}
execute if score #n dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:13}
execute if score #n dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:13}
execute if score #n dd_ctx matches 4 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:13}
execute if score #n dd_ctx matches 4 if score #r13 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:13}
execute if score #n dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:14}
execute if score #n dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:14}
execute if score #n dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:14}
execute if score #n dd_ctx matches 4 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:14}
execute if score #n dd_ctx matches 4 if score #r14 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:14}
execute if score #n dd_ctx matches 1 if score #r15 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:15}
execute if score #n dd_ctx matches 2 if score #r15 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:15}
execute if score #n dd_ctx matches 3 if score #r15 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:15}
execute if score #n dd_ctx matches 4 if score #r15 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:15}
execute if score #n dd_ctx matches 4 if score #r15 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:15}
execute if score #n dd_ctx matches 1 if score #r16 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:16}
execute if score #n dd_ctx matches 2 if score #r16 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:16}
execute if score #n dd_ctx matches 3 if score #r16 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:16}
execute if score #n dd_ctx matches 4 if score #r16 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:16}
execute if score #n dd_ctx matches 4 if score #r16 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:16}
execute if score #n dd_ctx matches 1 if score #r17 dd_ctx matches 1 run function doudizhu:rules/accept {type:1,high:17}
execute if score #n dd_ctx matches 2 if score #r17 dd_ctx matches 2 run function doudizhu:rules/accept {type:2,high:17}
execute if score #n dd_ctx matches 3 if score #r17 dd_ctx matches 3 run function doudizhu:rules/accept {type:3,high:17}
execute if score #n dd_ctx matches 4 if score #r17 dd_ctx matches 3 run function doudizhu:rules/accept {type:4,high:17}
execute if score #n dd_ctx matches 4 if score #r17 dd_ctx matches 4 run function doudizhu:rules/accept {type:13,high:17}
execute if score #n dd_ctx matches 2 if score #r16 dd_ctx matches 1 if score #r17 dd_ctx matches 1 run function doudizhu:rules/accept {type:14,high:17}
scoreboard players set #pairs dd_ctx 0
execute if score #r3 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r4 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r5 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r6 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r7 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r8 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r9 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r10 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r11 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r12 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r13 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r14 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r15 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r16 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #r17 dd_ctx matches 2 run scoreboard players add #pairs dd_ctx 1
execute if score #n dd_ctx matches 5 if score #r3 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:3}
execute if score #n dd_ctx matches 6 if score #r3 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:3}
execute if score #n dd_ctx matches 8 if score #r3 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:3}
execute if score #n dd_ctx matches 5 if score #r4 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:4}
execute if score #n dd_ctx matches 6 if score #r4 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:4}
execute if score #n dd_ctx matches 8 if score #r4 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:4}
execute if score #n dd_ctx matches 5 if score #r5 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:5}
execute if score #n dd_ctx matches 6 if score #r5 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:5}
execute if score #n dd_ctx matches 8 if score #r5 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:5}
execute if score #n dd_ctx matches 5 if score #r6 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:6}
execute if score #n dd_ctx matches 6 if score #r6 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:6}
execute if score #n dd_ctx matches 8 if score #r6 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:6}
execute if score #n dd_ctx matches 5 if score #r7 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:7}
execute if score #n dd_ctx matches 6 if score #r7 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:7}
execute if score #n dd_ctx matches 8 if score #r7 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:7}
execute if score #n dd_ctx matches 5 if score #r8 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:8}
execute if score #n dd_ctx matches 6 if score #r8 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:8}
execute if score #n dd_ctx matches 8 if score #r8 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:8}
execute if score #n dd_ctx matches 5 if score #r9 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:9}
execute if score #n dd_ctx matches 6 if score #r9 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:9}
execute if score #n dd_ctx matches 8 if score #r9 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:9}
execute if score #n dd_ctx matches 5 if score #r10 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:10}
execute if score #n dd_ctx matches 6 if score #r10 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:10}
execute if score #n dd_ctx matches 8 if score #r10 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:10}
execute if score #n dd_ctx matches 5 if score #r11 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:11}
execute if score #n dd_ctx matches 6 if score #r11 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:11}
execute if score #n dd_ctx matches 8 if score #r11 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:11}
execute if score #n dd_ctx matches 5 if score #r12 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:12}
execute if score #n dd_ctx matches 6 if score #r12 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:12}
execute if score #n dd_ctx matches 8 if score #r12 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:12}
execute if score #n dd_ctx matches 5 if score #r13 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:13}
execute if score #n dd_ctx matches 6 if score #r13 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:13}
execute if score #n dd_ctx matches 8 if score #r13 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:13}
execute if score #n dd_ctx matches 5 if score #r14 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:14}
execute if score #n dd_ctx matches 6 if score #r14 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:14}
execute if score #n dd_ctx matches 8 if score #r14 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:14}
execute if score #n dd_ctx matches 5 if score #r15 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:15}
execute if score #n dd_ctx matches 6 if score #r15 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:15}
execute if score #n dd_ctx matches 8 if score #r15 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:15}
execute if score #n dd_ctx matches 5 if score #r16 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:16}
execute if score #n dd_ctx matches 6 if score #r16 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:16}
execute if score #n dd_ctx matches 8 if score #r16 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:16}
execute if score #n dd_ctx matches 5 if score #r17 dd_ctx matches 3 if score #pairs dd_ctx matches 1 run function doudizhu:rules/accept {type:5,high:17}
execute if score #n dd_ctx matches 6 if score #r17 dd_ctx matches 4 run function doudizhu:rules/accept {type:11,high:17}
execute if score #n dd_ctx matches 8 if score #r17 dd_ctx matches 4 if score #pairs dd_ctx matches 2 run function doudizhu:rules/accept {type:12,high:17}
execute if score #n dd_ctx matches 5 if score #r3 dd_ctx matches 1 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:7}
execute if score #n dd_ctx matches 5 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:8}
execute if score #n dd_ctx matches 5 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:9}
execute if score #n dd_ctx matches 5 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:10}
execute if score #n dd_ctx matches 5 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:11}
execute if score #n dd_ctx matches 5 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:12}
execute if score #n dd_ctx matches 5 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:13}
execute if score #n dd_ctx matches 5 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:14}
execute if score #n dd_ctx matches 6 if score #r3 dd_ctx matches 1 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:8}
execute if score #n dd_ctx matches 6 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:9}
execute if score #n dd_ctx matches 6 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:10}
execute if score #n dd_ctx matches 6 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:11}
execute if score #n dd_ctx matches 6 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:12}
execute if score #n dd_ctx matches 6 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:13}
execute if score #n dd_ctx matches 6 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:14}
execute if score #n dd_ctx matches 7 if score #r3 dd_ctx matches 1 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:9}
execute if score #n dd_ctx matches 7 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:10}
execute if score #n dd_ctx matches 7 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:11}
execute if score #n dd_ctx matches 7 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:12}
execute if score #n dd_ctx matches 7 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:13}
execute if score #n dd_ctx matches 7 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:14}
execute if score #n dd_ctx matches 8 if score #r3 dd_ctx matches 1 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:10}
execute if score #n dd_ctx matches 8 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:11}
execute if score #n dd_ctx matches 8 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:12}
execute if score #n dd_ctx matches 8 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:13}
execute if score #n dd_ctx matches 8 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:14}
execute if score #n dd_ctx matches 9 if score #r3 dd_ctx matches 1 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:11}
execute if score #n dd_ctx matches 9 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:12}
execute if score #n dd_ctx matches 9 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:13}
execute if score #n dd_ctx matches 9 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:14}
execute if score #n dd_ctx matches 10 if score #r3 dd_ctx matches 1 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:12}
execute if score #n dd_ctx matches 10 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:13}
execute if score #n dd_ctx matches 10 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:14}
execute if score #n dd_ctx matches 11 if score #r3 dd_ctx matches 1 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:13}
execute if score #n dd_ctx matches 11 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:14}
execute if score #n dd_ctx matches 12 if score #r3 dd_ctx matches 1 if score #r4 dd_ctx matches 1 if score #r5 dd_ctx matches 1 if score #r6 dd_ctx matches 1 if score #r7 dd_ctx matches 1 if score #r8 dd_ctx matches 1 if score #r9 dd_ctx matches 1 if score #r10 dd_ctx matches 1 if score #r11 dd_ctx matches 1 if score #r12 dd_ctx matches 1 if score #r13 dd_ctx matches 1 if score #r14 dd_ctx matches 1 run function doudizhu:rules/accept {type:6,high:14}
execute if score #n dd_ctx matches 6 if score #r3 dd_ctx matches 2 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:5}
execute if score #n dd_ctx matches 6 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:6}
execute if score #n dd_ctx matches 6 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:7}
execute if score #n dd_ctx matches 6 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:8}
execute if score #n dd_ctx matches 6 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:9}
execute if score #n dd_ctx matches 6 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:10}
execute if score #n dd_ctx matches 6 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:11}
execute if score #n dd_ctx matches 6 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:12}
execute if score #n dd_ctx matches 6 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:13}
execute if score #n dd_ctx matches 6 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:14}
execute if score #n dd_ctx matches 8 if score #r3 dd_ctx matches 2 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:6}
execute if score #n dd_ctx matches 8 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:7}
execute if score #n dd_ctx matches 8 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:8}
execute if score #n dd_ctx matches 8 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:9}
execute if score #n dd_ctx matches 8 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:10}
execute if score #n dd_ctx matches 8 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:11}
execute if score #n dd_ctx matches 8 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:12}
execute if score #n dd_ctx matches 8 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:13}
execute if score #n dd_ctx matches 8 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:14}
execute if score #n dd_ctx matches 10 if score #r3 dd_ctx matches 2 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:7}
execute if score #n dd_ctx matches 10 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:8}
execute if score #n dd_ctx matches 10 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:9}
execute if score #n dd_ctx matches 10 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:10}
execute if score #n dd_ctx matches 10 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:11}
execute if score #n dd_ctx matches 10 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:12}
execute if score #n dd_ctx matches 10 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:13}
execute if score #n dd_ctx matches 10 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:14}
execute if score #n dd_ctx matches 12 if score #r3 dd_ctx matches 2 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:8}
execute if score #n dd_ctx matches 12 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:9}
execute if score #n dd_ctx matches 12 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:10}
execute if score #n dd_ctx matches 12 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:11}
execute if score #n dd_ctx matches 12 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:12}
execute if score #n dd_ctx matches 12 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:13}
execute if score #n dd_ctx matches 12 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:14}
execute if score #n dd_ctx matches 14 if score #r3 dd_ctx matches 2 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:9}
execute if score #n dd_ctx matches 14 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:10}
execute if score #n dd_ctx matches 14 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:11}
execute if score #n dd_ctx matches 14 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:12}
execute if score #n dd_ctx matches 14 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:13}
execute if score #n dd_ctx matches 14 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:14}
execute if score #n dd_ctx matches 16 if score #r3 dd_ctx matches 2 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:10}
execute if score #n dd_ctx matches 16 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:11}
execute if score #n dd_ctx matches 16 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:12}
execute if score #n dd_ctx matches 16 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:13}
execute if score #n dd_ctx matches 16 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:14}
execute if score #n dd_ctx matches 18 if score #r3 dd_ctx matches 2 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:11}
execute if score #n dd_ctx matches 18 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:12}
execute if score #n dd_ctx matches 18 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:13}
execute if score #n dd_ctx matches 18 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:14}
execute if score #n dd_ctx matches 20 if score #r3 dd_ctx matches 2 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:12}
execute if score #n dd_ctx matches 20 if score #r4 dd_ctx matches 2 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:13}
execute if score #n dd_ctx matches 20 if score #r5 dd_ctx matches 2 if score #r6 dd_ctx matches 2 if score #r7 dd_ctx matches 2 if score #r8 dd_ctx matches 2 if score #r9 dd_ctx matches 2 if score #r10 dd_ctx matches 2 if score #r11 dd_ctx matches 2 if score #r12 dd_ctx matches 2 if score #r13 dd_ctx matches 2 if score #r14 dd_ctx matches 2 run function doudizhu:rules/accept {type:7,high:14}
execute if score #n dd_ctx matches 6 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:4}
execute if score #n dd_ctx matches 8 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:3,end:4,high:4}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:4}
execute if score #n dd_ctx matches 6 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:5}
execute if score #n dd_ctx matches 8 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:4,end:5,high:5}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:5}
execute if score #n dd_ctx matches 6 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:6}
execute if score #n dd_ctx matches 8 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:5,end:6,high:6}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:6}
execute if score #n dd_ctx matches 6 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:7}
execute if score #n dd_ctx matches 8 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:6,end:7,high:7}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:7}
execute if score #n dd_ctx matches 6 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:8}
execute if score #n dd_ctx matches 8 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:7,end:8,high:8}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:8}
execute if score #n dd_ctx matches 6 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:9}
execute if score #n dd_ctx matches 8 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:8,end:9,high:9}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:9}
execute if score #n dd_ctx matches 6 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:10}
execute if score #n dd_ctx matches 8 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:9,end:10,high:10}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:10}
execute if score #n dd_ctx matches 6 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:11}
execute if score #n dd_ctx matches 8 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:10,end:11,high:11}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:11}
execute if score #n dd_ctx matches 6 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:12}
execute if score #n dd_ctx matches 8 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:11,end:12,high:12}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:12}
execute if score #n dd_ctx matches 6 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:13}
execute if score #n dd_ctx matches 8 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:12,end:13,high:13}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:13}
execute if score #n dd_ctx matches 6 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:14}
execute if score #n dd_ctx matches 8 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:13,end:14,high:14}
execute if score #n dd_ctx matches 10 if score #pairs dd_ctx matches 2 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:14}
execute if score #n dd_ctx matches 9 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:5}
execute if score #n dd_ctx matches 12 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:3,end:5,high:5}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:5}
execute if score #n dd_ctx matches 9 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:6}
execute if score #n dd_ctx matches 12 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:4,end:6,high:6}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:6}
execute if score #n dd_ctx matches 9 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:7}
execute if score #n dd_ctx matches 12 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:5,end:7,high:7}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:7}
execute if score #n dd_ctx matches 9 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:8}
execute if score #n dd_ctx matches 12 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:6,end:8,high:8}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:8}
execute if score #n dd_ctx matches 9 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:9}
execute if score #n dd_ctx matches 12 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:7,end:9,high:9}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:9}
execute if score #n dd_ctx matches 9 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:10}
execute if score #n dd_ctx matches 12 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:8,end:10,high:10}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:10}
execute if score #n dd_ctx matches 9 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:11}
execute if score #n dd_ctx matches 12 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:9,end:11,high:11}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:11}
execute if score #n dd_ctx matches 9 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:12}
execute if score #n dd_ctx matches 12 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:10,end:12,high:12}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:12}
execute if score #n dd_ctx matches 9 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:13}
execute if score #n dd_ctx matches 12 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:11,end:13,high:13}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:13}
execute if score #n dd_ctx matches 9 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:14}
execute if score #n dd_ctx matches 12 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:12,end:14,high:14}
execute if score #n dd_ctx matches 15 if score #pairs dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:14}
execute if score #n dd_ctx matches 12 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:6}
execute if score #n dd_ctx matches 16 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:3,end:6,high:6}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:6}
execute if score #n dd_ctx matches 12 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:7}
execute if score #n dd_ctx matches 16 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:4,end:7,high:7}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:7}
execute if score #n dd_ctx matches 12 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:8}
execute if score #n dd_ctx matches 16 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:5,end:8,high:8}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:8}
execute if score #n dd_ctx matches 12 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:9}
execute if score #n dd_ctx matches 16 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:6,end:9,high:9}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:9}
execute if score #n dd_ctx matches 12 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:10}
execute if score #n dd_ctx matches 16 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:7,end:10,high:10}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:10}
execute if score #n dd_ctx matches 12 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:11}
execute if score #n dd_ctx matches 16 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:8,end:11,high:11}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:11}
execute if score #n dd_ctx matches 12 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:12}
execute if score #n dd_ctx matches 16 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:9,end:12,high:12}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:12}
execute if score #n dd_ctx matches 12 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:13}
execute if score #n dd_ctx matches 16 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:10,end:13,high:13}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:13}
execute if score #n dd_ctx matches 12 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:14}
execute if score #n dd_ctx matches 16 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:11,end:14,high:14}
execute if score #n dd_ctx matches 20 if score #pairs dd_ctx matches 4 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:14}
execute if score #n dd_ctx matches 15 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:7}
execute if score #n dd_ctx matches 20 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:3,end:7,high:7}
execute if score #n dd_ctx matches 25 if score #pairs dd_ctx matches 5 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:7}
execute if score #n dd_ctx matches 15 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:8}
execute if score #n dd_ctx matches 20 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:4,end:8,high:8}
execute if score #n dd_ctx matches 25 if score #pairs dd_ctx matches 5 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:8}
execute if score #n dd_ctx matches 15 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:9}
execute if score #n dd_ctx matches 20 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:5,end:9,high:9}
execute if score #n dd_ctx matches 25 if score #pairs dd_ctx matches 5 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:9}
execute if score #n dd_ctx matches 15 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:10}
execute if score #n dd_ctx matches 20 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:6,end:10,high:10}
execute if score #n dd_ctx matches 25 if score #pairs dd_ctx matches 5 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:10}
execute if score #n dd_ctx matches 15 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:11}
execute if score #n dd_ctx matches 20 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:7,end:11,high:11}
execute if score #n dd_ctx matches 25 if score #pairs dd_ctx matches 5 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:11}
execute if score #n dd_ctx matches 15 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:12}
execute if score #n dd_ctx matches 20 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:8,end:12,high:12}
execute if score #n dd_ctx matches 25 if score #pairs dd_ctx matches 5 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:12}
execute if score #n dd_ctx matches 15 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:13}
execute if score #n dd_ctx matches 20 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:9,end:13,high:13}
execute if score #n dd_ctx matches 25 if score #pairs dd_ctx matches 5 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:13}
execute if score #n dd_ctx matches 15 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:14}
execute if score #n dd_ctx matches 20 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:10,end:14,high:14}
execute if score #n dd_ctx matches 25 if score #pairs dd_ctx matches 5 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:14}
execute if score #n dd_ctx matches 18 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:8}
execute if score #n dd_ctx matches 24 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:3,end:8,high:8}
execute if score #n dd_ctx matches 30 if score #pairs dd_ctx matches 6 if score #r3 dd_ctx matches 3 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:8}
execute if score #n dd_ctx matches 18 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:9}
execute if score #n dd_ctx matches 24 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:4,end:9,high:9}
execute if score #n dd_ctx matches 30 if score #pairs dd_ctx matches 6 if score #r4 dd_ctx matches 3 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:9}
execute if score #n dd_ctx matches 18 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:10}
execute if score #n dd_ctx matches 24 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:5,end:10,high:10}
execute if score #n dd_ctx matches 30 if score #pairs dd_ctx matches 6 if score #r5 dd_ctx matches 3 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:10}
execute if score #n dd_ctx matches 18 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:11}
execute if score #n dd_ctx matches 24 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:6,end:11,high:11}
execute if score #n dd_ctx matches 30 if score #pairs dd_ctx matches 6 if score #r6 dd_ctx matches 3 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:11}
execute if score #n dd_ctx matches 18 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:12}
execute if score #n dd_ctx matches 24 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:7,end:12,high:12}
execute if score #n dd_ctx matches 30 if score #pairs dd_ctx matches 6 if score #r7 dd_ctx matches 3 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:12}
execute if score #n dd_ctx matches 18 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:13}
execute if score #n dd_ctx matches 24 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:8,end:13,high:13}
execute if score #n dd_ctx matches 30 if score #pairs dd_ctx matches 6 if score #r8 dd_ctx matches 3 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:13}
execute if score #n dd_ctx matches 18 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:8,high:14}
execute if score #n dd_ctx matches 24 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/plane_single {start:9,end:14,high:14}
execute if score #n dd_ctx matches 30 if score #pairs dd_ctx matches 6 if score #r9 dd_ctx matches 3 if score #r10 dd_ctx matches 3 if score #r11 dd_ctx matches 3 if score #r12 dd_ctx matches 3 if score #r13 dd_ctx matches 3 if score #r14 dd_ctx matches 3 run function doudizhu:rules/accept {type:10,high:14}
