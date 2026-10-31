# Executed as and at this table controller. Rebuild from persisted mission results.
scoreboard players operation #map_table av_ctx = @s av_id
execute as @e[type=minecraft:item_display,tag=av.map] if score @s av_id = #map_table av_ctx run kill @s
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
