scoreboard players set #actor gd_ctx -1
execute if score @s gd_phase matches 1 run scoreboard players operation #actor gd_ctx = @e[tag=gd.board,scores={gd_tribute=1},limit=1] gd_seat
execute if score @s gd_phase matches 2 run scoreboard players operation #actor gd_ctx = @e[tag=gd.board,scores={gd_return=1},limit=1] gd_seat
execute unless score #actor gd_ctx matches 1..8 run return 0
tag @e[tag=gd.auto] remove gd.auto
scoreboard players set #max gd_ctx -1
scoreboard players set #min gd_ctx 99
scoreboard players set #small gd_ctx 0
execute as @e[tag=gd.cards,scores={gd_wild=0}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #max gd_ctx > @s gd_strength
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #min gd_ctx < @s gd_strength
execute as @e[tag=gd.cards,scores={gd_point=2..10}] if score @s gd_owner = #actor gd_ctx run scoreboard players set #small gd_ctx 1
execute if score @s gd_phase matches 1 as @e[tag=gd.cards,scores={gd_wild=0}] if score @s gd_owner = #actor gd_ctx if score @s gd_strength = #max gd_ctx run tag @s add gd.auto
execute if score @s gd_phase matches 2 if score #small gd_ctx matches 0 as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_strength = #min gd_ctx run tag @s add gd.auto
# 还牌优先点数<=10；低点级牌虽强，仍属于合法还牌。
execute if score @s gd_phase matches 2 as @e[tag=gd.cards,scores={gd_point=2..10}] if score @s gd_owner = #actor gd_ctx run tag @s add gd.auto
scoreboard players operation #card gd_ctx = @e[tag=gd.auto,limit=1] gd_id
function guandan:tribute/submit
function guandan:clock/reset
tag @e[tag=gd.auto] remove gd.auto
