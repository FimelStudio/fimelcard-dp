function splendor:engine/stats
scoreboard players add #epoch sp_ctx 1
execute store result storage splendor:engine state.epoch int 1 run scoreboard players get #epoch sp_ctx
data modify entity @s data.splendor set from storage splendor:engine state
scoreboard players set #error sp_ctx 0
scoreboard players set #ok sp_ctx 1
