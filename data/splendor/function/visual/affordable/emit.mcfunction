execute store result score #aff_width sp_ctx run data get entity @s width 100000
scoreboard players set #aff_three sp_ctx 3
scoreboard players set #aff_eight sp_ctx 8
scoreboard players set #aff_two sp_ctx 2
scoreboard players operation #aff_x sp_ctx = #aff_width sp_ctx
scoreboard players operation #aff_x sp_ctx *= #aff_three sp_ctx
scoreboard players operation #aff_x sp_ctx /= #aff_eight sp_ctx
scoreboard players add #aff_x sp_ctx 2500
scoreboard players operation #aff_z sp_ctx = #aff_width sp_ctx
scoreboard players operation #aff_z sp_ctx /= #aff_two sp_ctx
scoreboard players add #aff_z sp_ctx 2500
execute store result storage splendor:affordable corners.x double 0.00001 run scoreboard players get #aff_x sp_ctx
execute store result storage splendor:affordable corners.z double 0.00001 run scoreboard players get #aff_z sp_ctx
function splendor:visual/affordable/emit_at with storage splendor:affordable corners
