# 只读本桌 gd.selected，列举所有合法解释；上手比较不影响候选生成。
function guandan:cards/constants
function guandan:cards/context
data modify entity @s data.guandan.options set value []
scoreboard players set #options gd_ctx 0
scoreboard players set #cards gd_ctx 0
scoreboard players set #wild gd_ctx 0
scoreboard players set #bad gd_ctx 0
scoreboard players set #nonwild gd_ctx 0
scoreboard players set #r2 gd_ctx 0
scoreboard players set #r3 gd_ctx 0
scoreboard players set #r4 gd_ctx 0
scoreboard players set #r5 gd_ctx 0
scoreboard players set #r6 gd_ctx 0
scoreboard players set #r7 gd_ctx 0
scoreboard players set #r8 gd_ctx 0
scoreboard players set #r9 gd_ctx 0
scoreboard players set #r10 gd_ctx 0
scoreboard players set #r11 gd_ctx 0
scoreboard players set #r12 gd_ctx 0
scoreboard players set #r13 gd_ctx 0
scoreboard players set #r14 gd_ctx 0
scoreboard players set #r15 gd_ctx 0
scoreboard players set #r16 gd_ctx 0
scoreboard players set #s0 gd_ctx 0
scoreboard players set #s1 gd_ctx 0
scoreboard players set #s2 gd_ctx 0
scoreboard players set #s3 gd_ctx 0
execute as @e[tag=gd.cards,tag=gd.selected] run function guandan:cards/count
execute if score #bad gd_ctx matches 1.. run return 0
execute unless score #cards gd_ctx matches 1..10 run return 0
execute unless score #wild gd_ctx matches 0..2 run return 0
scoreboard players operation #nonwild gd_ctx = #cards gd_ctx
scoreboard players operation #nonwild gd_ctx -= #wild gd_ctx
execute if score #cards gd_ctx matches 1 run function guandan:cards/single
execute if score #cards gd_ctx matches 2..3 run function guandan:cards/same
execute if score #cards gd_ctx matches 4..10 run function guandan:cards/bomb
execute if score #cards gd_ctx matches 5 run function guandan:cards/full_house
execute if score #cards gd_ctx matches 5..6 run function guandan:cards/sequences
execute if score #cards gd_ctx matches 4 if score #r15 gd_ctx matches 2 if score #r16 gd_ctx matches 2 run function guandan:cards/four_jokers
