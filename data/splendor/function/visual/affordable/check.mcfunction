scoreboard players set #aff_ok sp_ctx 0
scoreboard players set #aff_card sp_ctx -1
execute store result score #aff_card sp_ctx run data get storage splendor:affordable card_id
execute unless score #aff_card sp_ctx matches 0..89 run return 0
function splendor:visual/affordable/read_cost with storage splendor:affordable
scoreboard players set #aff_gold sp_ctx 0
execute store result score #aff_cost sp_ctx run data get storage splendor:affordable cost[0]
execute store result score #aff_bonus sp_ctx run data get storage splendor:affordable player.bonus[0]
execute store result score #aff_tokens sp_ctx run data get storage splendor:affordable player.tokens[0]
scoreboard players operation #aff_cost sp_ctx -= #aff_bonus sp_ctx
scoreboard players operation #aff_cost sp_ctx -= #aff_tokens sp_ctx
execute if score #aff_cost sp_ctx matches 1.. run scoreboard players operation #aff_gold sp_ctx += #aff_cost sp_ctx
execute store result score #aff_cost sp_ctx run data get storage splendor:affordable cost[1]
execute store result score #aff_bonus sp_ctx run data get storage splendor:affordable player.bonus[1]
execute store result score #aff_tokens sp_ctx run data get storage splendor:affordable player.tokens[1]
scoreboard players operation #aff_cost sp_ctx -= #aff_bonus sp_ctx
scoreboard players operation #aff_cost sp_ctx -= #aff_tokens sp_ctx
execute if score #aff_cost sp_ctx matches 1.. run scoreboard players operation #aff_gold sp_ctx += #aff_cost sp_ctx
execute store result score #aff_cost sp_ctx run data get storage splendor:affordable cost[2]
execute store result score #aff_bonus sp_ctx run data get storage splendor:affordable player.bonus[2]
execute store result score #aff_tokens sp_ctx run data get storage splendor:affordable player.tokens[2]
scoreboard players operation #aff_cost sp_ctx -= #aff_bonus sp_ctx
scoreboard players operation #aff_cost sp_ctx -= #aff_tokens sp_ctx
execute if score #aff_cost sp_ctx matches 1.. run scoreboard players operation #aff_gold sp_ctx += #aff_cost sp_ctx
execute store result score #aff_cost sp_ctx run data get storage splendor:affordable cost[3]
execute store result score #aff_bonus sp_ctx run data get storage splendor:affordable player.bonus[3]
execute store result score #aff_tokens sp_ctx run data get storage splendor:affordable player.tokens[3]
scoreboard players operation #aff_cost sp_ctx -= #aff_bonus sp_ctx
scoreboard players operation #aff_cost sp_ctx -= #aff_tokens sp_ctx
execute if score #aff_cost sp_ctx matches 1.. run scoreboard players operation #aff_gold sp_ctx += #aff_cost sp_ctx
execute store result score #aff_cost sp_ctx run data get storage splendor:affordable cost[4]
execute store result score #aff_bonus sp_ctx run data get storage splendor:affordable player.bonus[4]
execute store result score #aff_tokens sp_ctx run data get storage splendor:affordable player.tokens[4]
scoreboard players operation #aff_cost sp_ctx -= #aff_bonus sp_ctx
scoreboard players operation #aff_cost sp_ctx -= #aff_tokens sp_ctx
execute if score #aff_cost sp_ctx matches 1.. run scoreboard players operation #aff_gold sp_ctx += #aff_cost sp_ctx
execute store result score #aff_owned_gold sp_ctx run data get storage splendor:affordable player.tokens[5]
execute if score #aff_gold sp_ctx <= #aff_owned_gold sp_ctx run scoreboard players set #aff_ok sp_ctx 1
