$data modify storage aeroplane_chess:visual frame_data set from storage aeroplane_chess:layout r$(roll)[$(frame)]
data modify storage aeroplane_chess:visual frame_data.scale set from storage aeroplane_chess:visual die_scale
# 高度用score只处理局部小数，不读取世界坐标，保持大坐标可用。
execute store result score #vis_y ac_ctx run data get storage aeroplane_chess:visual die_y 1000000
execute store result score #vis_lift ac_ctx run data get storage aeroplane_chess:visual frame_data.lift 1000000
scoreboard players operation #vis_y ac_ctx += #vis_lift ac_ctx
execute store result storage aeroplane_chess:visual frame_data.y double 0.000001 run scoreboard players get #vis_y ac_ctx
execute as @e[tag=ac.die] if score @s ct_id = #vis_table ac_ctx run function aeroplane_chess:visual/die_pose with storage aeroplane_chess:visual frame_data
