data modify storage splendor:direct pay set value [0,0,0,0,0,0]
scoreboard players set #quote_gold sp_ctx 0
execute store result score #quote_cost sp_ctx run data get storage splendor:direct card.cost[0]
execute store result score #quote_bonus sp_ctx run data get storage splendor:direct hand.bonus[0]
scoreboard players operation #quote_cost sp_ctx -= #quote_bonus sp_ctx
execute if score #quote_cost sp_ctx matches ..-1 run scoreboard players set #quote_cost sp_ctx 0
execute store result score #quote_token sp_ctx run data get storage splendor:direct hand.tokens[0]
scoreboard players operation #quote_pay sp_ctx = #quote_cost sp_ctx
scoreboard players operation #quote_pay sp_ctx < #quote_token sp_ctx
execute store result storage splendor:direct pay[0] int 1 run scoreboard players get #quote_pay sp_ctx
scoreboard players operation #quote_cost sp_ctx -= #quote_pay sp_ctx
scoreboard players operation #quote_gold sp_ctx += #quote_cost sp_ctx
execute store result score #quote_cost sp_ctx run data get storage splendor:direct card.cost[1]
execute store result score #quote_bonus sp_ctx run data get storage splendor:direct hand.bonus[1]
scoreboard players operation #quote_cost sp_ctx -= #quote_bonus sp_ctx
execute if score #quote_cost sp_ctx matches ..-1 run scoreboard players set #quote_cost sp_ctx 0
execute store result score #quote_token sp_ctx run data get storage splendor:direct hand.tokens[1]
scoreboard players operation #quote_pay sp_ctx = #quote_cost sp_ctx
scoreboard players operation #quote_pay sp_ctx < #quote_token sp_ctx
execute store result storage splendor:direct pay[1] int 1 run scoreboard players get #quote_pay sp_ctx
scoreboard players operation #quote_cost sp_ctx -= #quote_pay sp_ctx
scoreboard players operation #quote_gold sp_ctx += #quote_cost sp_ctx
execute store result score #quote_cost sp_ctx run data get storage splendor:direct card.cost[2]
execute store result score #quote_bonus sp_ctx run data get storage splendor:direct hand.bonus[2]
scoreboard players operation #quote_cost sp_ctx -= #quote_bonus sp_ctx
execute if score #quote_cost sp_ctx matches ..-1 run scoreboard players set #quote_cost sp_ctx 0
execute store result score #quote_token sp_ctx run data get storage splendor:direct hand.tokens[2]
scoreboard players operation #quote_pay sp_ctx = #quote_cost sp_ctx
scoreboard players operation #quote_pay sp_ctx < #quote_token sp_ctx
execute store result storage splendor:direct pay[2] int 1 run scoreboard players get #quote_pay sp_ctx
scoreboard players operation #quote_cost sp_ctx -= #quote_pay sp_ctx
scoreboard players operation #quote_gold sp_ctx += #quote_cost sp_ctx
execute store result score #quote_cost sp_ctx run data get storage splendor:direct card.cost[3]
execute store result score #quote_bonus sp_ctx run data get storage splendor:direct hand.bonus[3]
scoreboard players operation #quote_cost sp_ctx -= #quote_bonus sp_ctx
execute if score #quote_cost sp_ctx matches ..-1 run scoreboard players set #quote_cost sp_ctx 0
execute store result score #quote_token sp_ctx run data get storage splendor:direct hand.tokens[3]
scoreboard players operation #quote_pay sp_ctx = #quote_cost sp_ctx
scoreboard players operation #quote_pay sp_ctx < #quote_token sp_ctx
execute store result storage splendor:direct pay[3] int 1 run scoreboard players get #quote_pay sp_ctx
scoreboard players operation #quote_cost sp_ctx -= #quote_pay sp_ctx
scoreboard players operation #quote_gold sp_ctx += #quote_cost sp_ctx
execute store result score #quote_cost sp_ctx run data get storage splendor:direct card.cost[4]
execute store result score #quote_bonus sp_ctx run data get storage splendor:direct hand.bonus[4]
scoreboard players operation #quote_cost sp_ctx -= #quote_bonus sp_ctx
execute if score #quote_cost sp_ctx matches ..-1 run scoreboard players set #quote_cost sp_ctx 0
execute store result score #quote_token sp_ctx run data get storage splendor:direct hand.tokens[4]
scoreboard players operation #quote_pay sp_ctx = #quote_cost sp_ctx
scoreboard players operation #quote_pay sp_ctx < #quote_token sp_ctx
execute store result storage splendor:direct pay[4] int 1 run scoreboard players get #quote_pay sp_ctx
scoreboard players operation #quote_cost sp_ctx -= #quote_pay sp_ctx
scoreboard players operation #quote_gold sp_ctx += #quote_cost sp_ctx
execute store result storage splendor:direct pay[5] int 1 run scoreboard players get #quote_gold sp_ctx
execute store result score #quote_owned sp_ctx run data get storage splendor:direct hand.tokens[5]
