
$data modify storage fimel_sklibs:animator temp.input set value $(config)

# 计分板参数
scoreboard players set @s fcs_an_vy 0
execute store result score @s fcs_an_vx run data get storage fimel_sklibs:animator temp.input.v 1000
execute store result score @s fcs_an_g run data get storage fimel_sklibs:animator temp.input.g 1000
execute store result score @s fcs_an_t run data get storage fimel_sklibs:animator temp.input.t 1

# 结束时运行的命令
function fimel_sklibs:animator/new/physical/_0 with entity @s

# 标签
tag @s add fimel.skanimator.phy

# summon armor_stand ~ ~ ~ {NoGravity:1b,Tags:["qwr"]}
# data modify entity @e[tag=qwr,limit=1] Rotation set from entity @s Rotation
# execute as @e[tag=qwr,limit=1] at @s run function fimel_sklibs:animator/new/physical {config:{v:1,g:0.05,t:20,cmds:["kill @s"]}}


# execute summon armor_stand run function fimel_sklibs:animator/new/physical {config:{v:0.5,g:-0.1,t:20,cmds:[""],tick:["particle end_rod ~ ~ ~"]}}
