execute unless entity @s[tag=sp.player,tag=ct.player] run return 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute unless score @s sp_table = @s ct_id run return 0
execute unless score @s sp_side matches 1..4 run return 0
scoreboard players operation #inv_table sp_ctx = @s sp_table
data remove storage splendor:inventory state
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=1}] if score @s ct_id = #inv_table sp_ctx run data modify storage splendor:inventory state set from entity @s data.splendor
execute unless data storage splendor:inventory state.p1 run return 0
execute store result storage splendor:inventory ctx.table int 1 run scoreboard players get @s sp_table
execute store result storage splendor:inventory ctx.owner int 1 run scoreboard players get @s sp_side
data modify storage splendor:inventory ctx.epoch set from storage splendor:inventory state.epoch
function splendor:inventory/read with storage splendor:inventory ctx
