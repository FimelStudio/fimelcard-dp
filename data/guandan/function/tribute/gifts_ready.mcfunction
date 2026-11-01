scoreboard players operation #head gd_ctx = @e[tag=gd.board,scores={gd_prevrank=1},limit=1] gd_seat
scoreboard players operation #headorder gd_ctx = @e[tag=gd.board,scores={gd_prevrank=1},limit=1] gd_order
scoreboard players operation #second gd_ctx = @e[tag=gd.board,scores={gd_prevrank=2},limit=1] gd_seat
execute as @e[tag=gd.board,scores={gd_tribute=2}] run function guandan:tribute/gift_strength
scoreboard players set #high_gift gd_ctx -1
execute as @e[tag=gd.board,scores={gd_tribute=2}] run scoreboard players operation #high_gift gd_ctx > @s gd_strength
scoreboard players set #lead gd_ctx -1
execute as @e[tag=gd.board,scores={gd_tribute=2}] if score @s gd_strength = #high_gift gd_ctx run scoreboard players operation #lead gd_ctx = @s gd_seat
# 同大时，上游的顺时针邻座进贡给上游；此处方位0..3按顺时针排列。
scoreboard players operation #clockwise gd_ctx = #headorder gd_ctx
scoreboard players add #clockwise gd_ctx 1
scoreboard players operation #clockwise gd_ctx %= #four gd_ctx
execute as @e[tag=gd.board,scores={gd_tribute=2}] if score @s gd_strength = #high_gift gd_ctx if score @s gd_order = #clockwise gd_ctx run scoreboard players operation #lead gd_ctx = @s gd_seat
scoreboard players operation @s gd_first = #lead gd_ctx
execute as @e[tag=gd.board,scores={gd_tribute=2}] run function guandan:tribute/assign_peer
data modify entity @s data.guandan.exchange set value []
execute as @e[tag=gd.board,scores={gd_tribute=2}] run function guandan:tribute/give_gift
function guandan:deck/recount
scoreboard players set @s gd_phase 2
function guandan:clock/reset
function guandan:visual/tribute
function guandan:sound/tribute
tellraw @a[tag=gd.audience] {text:"[掼蛋] 请接贡者选择一张点数不超过10的牌还回；若全手牌均大于10，须还最小牌。",color:"gold"}
