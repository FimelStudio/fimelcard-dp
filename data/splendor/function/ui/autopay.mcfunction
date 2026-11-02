# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #gold sp_ctx 0
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[0]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[0]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d0 int 1 run scoreboard players get #cost sp_ctx
execute store result score #held sp_ctx run data get storage splendor:ui hand.tokens[0]
scoreboard players operation @s sp_pick0 = #cost sp_ctx
execute if score #cost sp_ctx > #held sp_ctx run scoreboard players operation @s sp_pick0 = #held sp_ctx
scoreboard players operation #cost sp_ctx -= @s sp_pick0
scoreboard players operation #gold sp_ctx += #cost sp_ctx
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[1]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[1]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d1 int 1 run scoreboard players get #cost sp_ctx
execute store result score #held sp_ctx run data get storage splendor:ui hand.tokens[1]
scoreboard players operation @s sp_pick1 = #cost sp_ctx
execute if score #cost sp_ctx > #held sp_ctx run scoreboard players operation @s sp_pick1 = #held sp_ctx
scoreboard players operation #cost sp_ctx -= @s sp_pick1
scoreboard players operation #gold sp_ctx += #cost sp_ctx
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[2]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[2]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d2 int 1 run scoreboard players get #cost sp_ctx
execute store result score #held sp_ctx run data get storage splendor:ui hand.tokens[2]
scoreboard players operation @s sp_pick2 = #cost sp_ctx
execute if score #cost sp_ctx > #held sp_ctx run scoreboard players operation @s sp_pick2 = #held sp_ctx
scoreboard players operation #cost sp_ctx -= @s sp_pick2
scoreboard players operation #gold sp_ctx += #cost sp_ctx
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[3]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[3]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d3 int 1 run scoreboard players get #cost sp_ctx
execute store result score #held sp_ctx run data get storage splendor:ui hand.tokens[3]
scoreboard players operation @s sp_pick3 = #cost sp_ctx
execute if score #cost sp_ctx > #held sp_ctx run scoreboard players operation @s sp_pick3 = #held sp_ctx
scoreboard players operation #cost sp_ctx -= @s sp_pick3
scoreboard players operation #gold sp_ctx += #cost sp_ctx
execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[4]
execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[4]
scoreboard players operation #cost sp_ctx -= #bonus sp_ctx
execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0
execute store result storage splendor:ui card.d4 int 1 run scoreboard players get #cost sp_ctx
execute store result score #held sp_ctx run data get storage splendor:ui hand.tokens[4]
scoreboard players operation @s sp_pick4 = #cost sp_ctx
execute if score #cost sp_ctx > #held sp_ctx run scoreboard players operation @s sp_pick4 = #held sp_ctx
scoreboard players operation #cost sp_ctx -= @s sp_pick4
scoreboard players operation #gold sp_ctx += #cost sp_ctx
scoreboard players operation @s sp_pick5 = #gold sp_ctx
