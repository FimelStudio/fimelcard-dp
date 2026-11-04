execute unless entity @e[tag=sp.current,limit=1] run return 0
execute store result storage splendor:direct side int 1 run scoreboard players get @s sp_side
function splendor:direct/inventory_read with storage splendor:direct
execute store result score #gem_count sp_ctx run data get storage splendor:direct hand.tokens[0]
execute store result storage splendor:direct count int 1 run scoreboard players get #gem_count sp_ctx
data modify storage splendor:direct item set value "diamond"
function splendor:direct/sync_gem with storage splendor:direct
execute store result score #gem_count sp_ctx run data get storage splendor:direct hand.tokens[1]
execute store result storage splendor:direct count int 1 run scoreboard players get #gem_count sp_ctx
data modify storage splendor:direct item set value "lapis_lazuli"
function splendor:direct/sync_gem with storage splendor:direct
execute store result score #gem_count sp_ctx run data get storage splendor:direct hand.tokens[2]
execute store result storage splendor:direct count int 1 run scoreboard players get #gem_count sp_ctx
data modify storage splendor:direct item set value "emerald"
function splendor:direct/sync_gem with storage splendor:direct
execute store result score #gem_count sp_ctx run data get storage splendor:direct hand.tokens[3]
execute store result storage splendor:direct count int 1 run scoreboard players get #gem_count sp_ctx
data modify storage splendor:direct item set value "redstone"
function splendor:direct/sync_gem with storage splendor:direct
execute store result score #gem_count sp_ctx run data get storage splendor:direct hand.tokens[4]
execute store result storage splendor:direct count int 1 run scoreboard players get #gem_count sp_ctx
data modify storage splendor:direct item set value "coal"
function splendor:direct/sync_gem with storage splendor:direct
execute store result score #gem_count sp_ctx run data get storage splendor:direct hand.tokens[5]
execute store result storage splendor:direct count int 1 run scoreboard players get #gem_count sp_ctx
data modify storage splendor:direct item set value "gold_ingot"
function splendor:direct/sync_gem with storage splendor:direct
