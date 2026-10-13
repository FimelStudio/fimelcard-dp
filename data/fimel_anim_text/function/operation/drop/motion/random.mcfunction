# 随机motion

execute store result score #operation.drop.motion.1 fca_store run data get storage fimel_anim_text:runtime operation.drop.input.motion.max 10000

execute store result score #operation.drop.motion.2 fca_store run data get storage fimel_anim_text:runtime operation.drop.input.motion.min 10000

scoreboard players operation #operation.drop.motion.1 fca_store -= #operation.drop.motion.2 fca_store

# * 1

execute store result storage fimel_math_light:runtime calculation.multiply.input.1 double 0.0001 run scoreboard players get #operation.drop.motion.1 fca_store

# * 100

execute store result storage fimel_math_light:runtime calculation.multiply.input.2 double 0.1 run random value 0..1000

function fimel_math_light:calculation/multiply

# * 100

execute store result score #operation.drop.motion.random fca_store run data get storage fimel_math_light:runtime calculation.multiply.output 100

scoreboard players operation #operation.drop.motion.random fca_store += #operation.drop.motion.2 fca_store

# 存储数据

execute store result storage fimel_anim_text:runtime operation.drop.motion.output float 0.0001 run scoreboard players get #operation.drop.motion.random fca_store

# 生成标记

execute rotated as @s run function fimel_anim_text:operation/drop/motion/random/init with storage fimel_anim_text:runtime operation.drop.motion

kill @s