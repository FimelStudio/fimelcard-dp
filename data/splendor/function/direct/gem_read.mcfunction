scoreboard players set #gem_stock sp_ctx 0
scoreboard players set #gem_owned sp_ctx 0
scoreboard players set #gem_pick sp_ctx 0
execute if score @s sp_target matches 0 store result score #gem_stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[0]
execute if score @s sp_target matches 0 store result score #gem_owned sp_ctx run data get storage splendor:direct hand.tokens[0]
execute if score @s sp_target matches 0 run scoreboard players operation #gem_pick sp_ctx = @s sp_pick0
execute if score @s sp_target matches 1 store result score #gem_stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[1]
execute if score @s sp_target matches 1 store result score #gem_owned sp_ctx run data get storage splendor:direct hand.tokens[1]
execute if score @s sp_target matches 1 run scoreboard players operation #gem_pick sp_ctx = @s sp_pick1
execute if score @s sp_target matches 2 store result score #gem_stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[2]
execute if score @s sp_target matches 2 store result score #gem_owned sp_ctx run data get storage splendor:direct hand.tokens[2]
execute if score @s sp_target matches 2 run scoreboard players operation #gem_pick sp_ctx = @s sp_pick2
execute if score @s sp_target matches 3 store result score #gem_stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[3]
execute if score @s sp_target matches 3 store result score #gem_owned sp_ctx run data get storage splendor:direct hand.tokens[3]
execute if score @s sp_target matches 3 run scoreboard players operation #gem_pick sp_ctx = @s sp_pick3
execute if score @s sp_target matches 4 store result score #gem_stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[4]
execute if score @s sp_target matches 4 store result score #gem_owned sp_ctx run data get storage splendor:direct hand.tokens[4]
execute if score @s sp_target matches 4 run scoreboard players operation #gem_pick sp_ctx = @s sp_pick4
execute if score @s sp_target matches 5 store result score #gem_stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[5]
execute if score @s sp_target matches 5 store result score #gem_owned sp_ctx run data get storage splendor:direct hand.tokens[5]
execute if score @s sp_target matches 5 run scoreboard players operation #gem_pick sp_ctx = @s sp_pick5
