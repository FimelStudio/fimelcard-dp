scoreboard players set #pick_total sp_ctx 0
scoreboard players set #pick_available sp_ctx 0
scoreboard players operation #pick_total sp_ctx += @s sp_pick0
execute store result score #stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[0]
execute if score #stock sp_ctx matches 1.. run scoreboard players add #pick_available sp_ctx 1
scoreboard players operation #pick_total sp_ctx += @s sp_pick1
execute store result score #stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[1]
execute if score #stock sp_ctx matches 1.. run scoreboard players add #pick_available sp_ctx 1
scoreboard players operation #pick_total sp_ctx += @s sp_pick2
execute store result score #stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[2]
execute if score #stock sp_ctx matches 1.. run scoreboard players add #pick_available sp_ctx 1
scoreboard players operation #pick_total sp_ctx += @s sp_pick3
execute store result score #stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[3]
execute if score #stock sp_ctx matches 1.. run scoreboard players add #pick_available sp_ctx 1
scoreboard players operation #pick_total sp_ctx += @s sp_pick4
execute store result score #stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[4]
execute if score #stock sp_ctx matches 1.. run scoreboard players add #pick_available sp_ctx 1
scoreboard players operation #pick_total sp_ctx += @s sp_pick5
execute if score #pick_available sp_ctx matches 4.. run scoreboard players set #pick_available sp_ctx 3
