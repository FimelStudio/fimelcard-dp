data modify storage fimel_anim_text:runtime operation.drop.rotation.rotation.1 set from storage fimel_anim_text:runtime operation.drop.input.direction.rotation[1]

# 随机yrot

execute store result score #operation.drop.rotation.base fca_store run data get storage fimel_anim_text:runtime operation.drop.input.direction.rotation[0] 1000

execute store result score #operation.drop.rotation.1 fca_store run data get storage fimel_anim_text:runtime operation.drop.input.direction.y_rotation.max 1000

scoreboard players operation #operation.drop.rotation.1 fca_store += #operation.drop.rotation.base fca_store

execute store result score #operation.drop.rotation.2 fca_store run data get storage fimel_anim_text:runtime operation.drop.input.direction.y_rotation.min 1000

scoreboard players operation #operation.drop.rotation.2 fca_store += #operation.drop.rotation.base fca_store

scoreboard players operation #operation.drop.rotation.1 fca_store -= #operation.drop.rotation.2 fca_store

# * 1

execute store result storage fimel_math_light:runtime calculation.multiply.input.1 double 0.001 run scoreboard players get #operation.drop.rotation.1 fca_store

# * 100

execute store result storage fimel_math_light:runtime calculation.multiply.input.2 double 0.1 run random value 0..1000

function fimel_math_light:calculation/multiply

# * 10

execute store result score #operation.drop.rotation.random fca_store run data get storage fimel_math_light:runtime calculation.multiply.output 10

scoreboard players operation #operation.drop.rotation.random fca_store += #operation.drop.rotation.2 fca_store

# 存储数据

execute store result storage fimel_anim_text:runtime operation.drop.rotation.rotation.0 float 0.001 run scoreboard players get #operation.drop.rotation.random fca_store

data modify storage fimel_anim_text:runtime operation.drop.rotation.output set value [0,0]

#

data modify storage fimel_anim_text:runtime operation.drop.rotation.output[0] set from storage fimel_anim_text:runtime operation.drop.rotation.rotation.0

data modify storage fimel_anim_text:runtime operation.drop.rotation.output[1] set from storage fimel_anim_text:runtime operation.drop.rotation.rotation.1


#tellraw @a [{score:{name:"#operation.drop.rotation.1",objective:"fca_store"}},"||",{score:{name:"#operation.drop.rotation.2",objective:"fca_store"}},"||",{score:{name:"#operation.drop.rotation.random",objective:"fca_store"}}]