data modify entity @s data.splendor.visual_active.motion set value []
data modify storage splendor:visual frame set value {"x":0.0,"y":0.3392,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 168
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 5832
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.5408,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 624
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 5376
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.6848,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 1296
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 4704
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.7712,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 2112
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 3888
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.8,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 3000
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 3000
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.7712,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 3888
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 2112
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.6848,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 4704
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 1296
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.5408,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 5376
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 624
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.3392,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 5832
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 168
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
data modify storage splendor:visual frame set value {"x":0.0,"y":0.08,"z":0.0,"scale":0.3}
execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000
execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000
scoreboard players set #vis_mul sp_ctx 6000
execute if data storage splendor:visual event{code:4} run scoreboard players set #vis_mul sp_ctx 0
scoreboard players set #vis_div sp_ctx 10000
scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx
scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx
scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx
execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx
execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx
data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame
