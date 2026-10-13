
# $say $(storage)
# return 0
scoreboard players reset @s fcs_fw_trigger

function fimel_skform:get
data modify storage fimel_sklibs:firework temp.storage set from storage fimel_skform:runtime temp.get

data modify storage fimel_sklibs:firework temp.storage.twinkle set from storage fimel_sklibs:firework temp.storage.effect[0]
data modify storage fimel_sklibs:firework temp.storage.trail set from storage fimel_sklibs:firework temp.storage.effect[1]
data modify storage fimel_sklibs:firework temp.storage.tnt set from storage fimel_sklibs:firework temp.storage.effect[2]

data modify storage fimel_sklibs:firework temp.st.tnt set from storage fimel_sklibs:firework temp.storage.tnt
execute if data storage fimel_sklibs:firework temp.st{tnt:0} run data modify storage fimel_sklibs:firework temp.storage.tnt set value "function fimel_sklibs:skfirework/pass"
execute if data storage fimel_sklibs:firework temp.st{tnt:1} run data modify storage fimel_sklibs:firework temp.storage.tnt set value "summon tnt ~ ~ ~ {fuse:0}"

data modify storage fimel_sklibs:firework temp.st.trail_color set from storage fimel_sklibs:firework temp.storage.trail_color
execute if data storage fimel_sklibs:firework temp.st{trail_color:0} run data modify storage fimel_sklibs:firework temp.storage.trail_color set value "end_rod"
execute if data storage fimel_sklibs:firework temp.st{trail_color:1} run data modify storage fimel_sklibs:firework temp.storage.trail_color set value "flame"
execute if data storage fimel_sklibs:firework temp.st{trail_color:2} run data modify storage fimel_sklibs:firework temp.storage.trail_color set value "dragon_breath"

execute store result score fimel.skfirework.v fcs_lib run data get storage fimel_sklibs:firework temp.storage.v 1
data modify storage fimel_sklibs:firework temp.storage.v set value 0.0d
execute store result storage fimel_sklibs:firework temp.storage.v double 0.001 run scoreboard players get fimel.skfirework.v fcs_lib

execute store result score fimel.skfirework.g fcs_lib run data get storage fimel_sklibs:firework temp.storage.g 1
data modify storage fimel_sklibs:firework temp.storage.g set value 0.0d
execute store result storage fimel_sklibs:firework temp.storage.g double 0.001 run scoreboard players get fimel.skfirework.g fcs_lib

function fimel_sklibs:skfirework/ui/give/from_ui1/_give with storage fimel_sklibs:firework temp.storage

