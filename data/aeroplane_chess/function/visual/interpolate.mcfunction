execute store result score #vis_total ac_ctx run data get storage aeroplane_chess:visual movement.total
execute store result score #vis_remaining ac_ctx run data get storage aeroplane_chess:visual movement.remaining
scoreboard players operation #vis_t ac_ctx = #vis_total ac_ctx
scoreboard players operation #vis_t ac_ctx -= #vis_remaining ac_ctx
scoreboard players set #vis_1000 ac_ctx 1000
scoreboard players operation #vis_t ac_ctx *= #vis_1000 ac_ctx
scoreboard players operation #vis_t ac_ctx /= #vis_total ac_ctx
execute store result score #vis_from ac_ctx run data get storage aeroplane_chess:visual movement.from.x 100000
execute store result score #vis_to ac_ctx run data get storage aeroplane_chess:visual movement.to.x 100000
scoreboard players operation #vis_to ac_ctx -= #vis_from ac_ctx
scoreboard players operation #vis_to ac_ctx *= #vis_t ac_ctx
scoreboard players operation #vis_to ac_ctx /= #vis_1000 ac_ctx
scoreboard players operation #vis_to ac_ctx += #vis_from ac_ctx
execute store result storage aeroplane_chess:visual x double 0.00001 run scoreboard players get #vis_to ac_ctx
execute store result score #vis_from ac_ctx run data get storage aeroplane_chess:visual movement.from.z 100000
execute store result score #vis_to ac_ctx run data get storage aeroplane_chess:visual movement.to.z 100000
scoreboard players operation #vis_to ac_ctx -= #vis_from ac_ctx
scoreboard players operation #vis_to ac_ctx *= #vis_t ac_ctx
scoreboard players operation #vis_to ac_ctx /= #vis_1000 ac_ctx
scoreboard players operation #vis_to ac_ctx += #vis_from ac_ctx
execute store result storage aeroplane_chess:visual z double 0.00001 run scoreboard players get #vis_to ac_ctx

# 抛物线4t(1-t)，普通步低跳，跳格/起飞/飞越逐级加高。
scoreboard players set #vis_lift ac_ctx 1000
scoreboard players operation #vis_lift ac_ctx -= #vis_t ac_ctx
scoreboard players operation #vis_lift ac_ctx *= #vis_t ac_ctx
scoreboard players set #vis_height ac_ctx 1
execute if data storage aeroplane_chess:visual movement{kind:1} run scoreboard players set #vis_height ac_ctx 4
execute if data storage aeroplane_chess:visual movement{kind:2} run scoreboard players set #vis_height ac_ctx 3
execute if data storage aeroplane_chess:visual movement{kind:3} run scoreboard players set #vis_height ac_ctx 7
scoreboard players operation #vis_lift ac_ctx *= #vis_height ac_ctx
execute store result score #vis_y ac_ctx run data get storage aeroplane_chess:visual plane_y 10000000
scoreboard players operation #vis_y ac_ctx += #vis_lift ac_ctx
execute store result storage aeroplane_chess:visual plane_y double 0.0000001 run scoreboard players get #vis_y ac_ctx
data modify storage aeroplane_chess:visual py set from storage aeroplane_chess:visual movement.to.qy
data modify storage aeroplane_chess:visual pw set from storage aeroplane_chess:visual movement.to.qw
data modify storage aeroplane_chess:visual color set from storage aeroplane_chess:visual movement.color
data modify storage aeroplane_chess:visual plane set from storage aeroplane_chess:visual movement.plane
data modify storage aeroplane_chess:visual duration set value 1
function aeroplane_chess:visual/moving_entity with storage aeroplane_chess:visual
