# Executed as and at this table controller. Rebuild from persisted mission results.
scoreboard players operation #map_table av_ctx = @s av_id
execute as @e[type=minecraft:item_display,tag=av.map] if score @s av_id = #map_table av_ctx run kill @s
execute as @e[type=minecraft:text_display,tag=av.map] if score @s av_id = #map_table av_ctx run kill @s
data modify storage avalon:map model set value "route"
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
data remove storage avalon:map result
data modify storage avalon:map result set from entity @s data.avalon.results[0]
execute if data storage avalon:map result{color:"green"} run data modify storage avalon:map model set value "success_1"
execute if data storage avalon:map result{color:"green"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
execute if data storage avalon:map result{color:"red"} run data modify storage avalon:map model set value "failure_1"
execute if data storage avalon:map result{color:"red"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
data remove storage avalon:map result
data modify storage avalon:map result set from entity @s data.avalon.results[1]
execute if data storage avalon:map result{color:"green"} run data modify storage avalon:map model set value "success_2"
execute if data storage avalon:map result{color:"green"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
execute if data storage avalon:map result{color:"red"} run data modify storage avalon:map model set value "failure_2"
execute if data storage avalon:map result{color:"red"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
data remove storage avalon:map result
data modify storage avalon:map result set from entity @s data.avalon.results[2]
execute if data storage avalon:map result{color:"green"} run data modify storage avalon:map model set value "success_3"
execute if data storage avalon:map result{color:"green"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
execute if data storage avalon:map result{color:"red"} run data modify storage avalon:map model set value "failure_3"
execute if data storage avalon:map result{color:"red"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
data remove storage avalon:map result
data modify storage avalon:map result set from entity @s data.avalon.results[3]
execute if data storage avalon:map result{color:"green"} run data modify storage avalon:map model set value "success_4"
execute if data storage avalon:map result{color:"green"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
execute if data storage avalon:map result{color:"red"} run data modify storage avalon:map model set value "failure_4"
execute if data storage avalon:map result{color:"red"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
data remove storage avalon:map result
data modify storage avalon:map result set from entity @s data.avalon.results[4]
execute if data storage avalon:map result{color:"green"} run data modify storage avalon:map model set value "success_5"
execute if data storage avalon:map result{color:"green"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map
execute if data storage avalon:map result{color:"red"} run data modify storage avalon:map model set value "failure_5"
execute if data storage avalon:map result{color:"red"} positioned ~ ~1.035 ~ summon minecraft:item_display run function avalon:map/display with storage avalon:map

# X/Z 按路线贴图中各任务印章的中心换算，Y 高于棋盘表面。
function avalon:map/requirements
function avalon:map/mission_label {round:1,index:0,x:"-1.040",z:"0.882"}
function avalon:map/mission_label {round:2,index:1,x:"-0.224",z:"0.857"}
function avalon:map/mission_label {round:3,index:2,x:"0.819",z:"0.092"}
function avalon:map/mission_label {round:4,index:3,x:"-0.130",z:"-0.528"}
function avalon:map/mission_label {round:5,index:4,x:"-0.933",z:"-0.648"}
