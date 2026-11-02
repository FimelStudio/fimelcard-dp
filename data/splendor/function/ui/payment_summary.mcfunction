# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[0]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[0]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d0 int 1 run scoreboard players get #cost sp_ctx
data modify storage splendor:ui card.c0 set from storage splendor:ui card.cost[0]
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[1]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[1]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d1 int 1 run scoreboard players get #cost sp_ctx
data modify storage splendor:ui card.c1 set from storage splendor:ui card.cost[1]
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[2]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[2]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d2 int 1 run scoreboard players get #cost sp_ctx
data modify storage splendor:ui card.c2 set from storage splendor:ui card.cost[2]
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[3]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[3]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d3 int 1 run scoreboard players get #cost sp_ctx
data modify storage splendor:ui card.c3 set from storage splendor:ui card.cost[3]
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[4]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[4]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d4 int 1 run scoreboard players get #cost sp_ctx
data modify storage splendor:ui card.c4 set from storage splendor:ui card.cost[4]
function splendor:ui/payment_text with storage splendor:ui card
