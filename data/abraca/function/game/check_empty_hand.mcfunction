# 执行者为本桌控制器；只有当前施法者的手牌会参与“打空手牌”胜利判定。
scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #seat ab_ctx = @a[tag=ab.actor,limit=1] ab_seat
scoreboard players set #hand ab_ctx 0
execute as @e[type=minecraft:marker,tag=ab.hand] if score @s ab_id = #ctx ab_ctx if score @s ab_owner = #seat ab_ctx run scoreboard players add #hand ab_ctx 1
execute unless score #hand ab_ctx matches 0 run return 0
tag @a[tag=ab.actor,limit=1] remove ab.round_winner
tag @a[tag=ab.actor,limit=1] add ab.round_winner
tag @a[tag=ab.actor,limit=1] add ab.win_hand
function abraca:game/round_finish
