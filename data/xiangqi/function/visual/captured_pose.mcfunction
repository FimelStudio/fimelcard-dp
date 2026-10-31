scoreboard players operation #vis_slot xq_ctx = @s xq_slot
scoreboard players operation #vis_owner xq_ctx = @s xq_owner
execute store result storage xiangqi:visual duration int 1 run scoreboard players get #vis_duration xq_ctx
execute if score #vis_owner xq_ctx matches 1 run scoreboard players operation #vis_edge xq_ctx = #vis_redge xq_ctx
execute if score #vis_owner xq_ctx matches -1 run scoreboard players operation #vis_edge xq_ctx = #vis_bedge xq_ctx
execute if score #vis_cap xq_ctx matches 4 run data modify storage xiangqi:visual scale set value 0.12
execute if score #vis_cap xq_ctx matches 4 run data modify storage xiangqi:visual lift set value 0.06
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 0 run data modify storage xiangqi:visual coord set value {x:1.265,z:-0.8925}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 0 run data modify storage xiangqi:visual coord set value {x:0.8925,z:1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 0 run data modify storage xiangqi:visual coord set value {x:-1.265,z:0.8925}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 0 run data modify storage xiangqi:visual coord set value {x:-0.8925,z:-1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 1 run data modify storage xiangqi:visual coord set value {x:1.265,z:-0.6375}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 1 run data modify storage xiangqi:visual coord set value {x:0.6375,z:1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 1 run data modify storage xiangqi:visual coord set value {x:-1.265,z:0.6375}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 1 run data modify storage xiangqi:visual coord set value {x:-0.6375,z:-1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 2 run data modify storage xiangqi:visual coord set value {x:1.265,z:-0.3825}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 2 run data modify storage xiangqi:visual coord set value {x:0.3825,z:1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 2 run data modify storage xiangqi:visual coord set value {x:-1.265,z:0.3825}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 2 run data modify storage xiangqi:visual coord set value {x:-0.3825,z:-1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 3 run data modify storage xiangqi:visual coord set value {x:1.265,z:-0.1275}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 3 run data modify storage xiangqi:visual coord set value {x:0.1275,z:1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 3 run data modify storage xiangqi:visual coord set value {x:-1.265,z:0.1275}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 3 run data modify storage xiangqi:visual coord set value {x:-0.1275,z:-1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 4 run data modify storage xiangqi:visual coord set value {x:1.265,z:0.1275}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 4 run data modify storage xiangqi:visual coord set value {x:-0.1275,z:1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 4 run data modify storage xiangqi:visual coord set value {x:-1.265,z:-0.1275}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 4 run data modify storage xiangqi:visual coord set value {x:0.1275,z:-1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 5 run data modify storage xiangqi:visual coord set value {x:1.265,z:0.3825}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 5 run data modify storage xiangqi:visual coord set value {x:-0.3825,z:1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 5 run data modify storage xiangqi:visual coord set value {x:-1.265,z:-0.3825}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 5 run data modify storage xiangqi:visual coord set value {x:0.3825,z:-1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 6 run data modify storage xiangqi:visual coord set value {x:1.265,z:0.6375}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 6 run data modify storage xiangqi:visual coord set value {x:-0.6375,z:1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 6 run data modify storage xiangqi:visual coord set value {x:-1.265,z:-0.6375}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 6 run data modify storage xiangqi:visual coord set value {x:0.6375,z:-1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 7 run data modify storage xiangqi:visual coord set value {x:1.265,z:0.8925}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 7 run data modify storage xiangqi:visual coord set value {x:-0.8925,z:1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 7 run data modify storage xiangqi:visual coord set value {x:-1.265,z:-0.8925}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 7 run data modify storage xiangqi:visual coord set value {x:0.8925,z:-1.265}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 8 run data modify storage xiangqi:visual coord set value {x:1.395,z:-0.8925}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 8 run data modify storage xiangqi:visual coord set value {x:0.8925,z:1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 8 run data modify storage xiangqi:visual coord set value {x:-1.395,z:0.8925}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 8 run data modify storage xiangqi:visual coord set value {x:-0.8925,z:-1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 9 run data modify storage xiangqi:visual coord set value {x:1.395,z:-0.6375}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 9 run data modify storage xiangqi:visual coord set value {x:0.6375,z:1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 9 run data modify storage xiangqi:visual coord set value {x:-1.395,z:0.6375}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 9 run data modify storage xiangqi:visual coord set value {x:-0.6375,z:-1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 10 run data modify storage xiangqi:visual coord set value {x:1.395,z:-0.3825}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 10 run data modify storage xiangqi:visual coord set value {x:0.3825,z:1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 10 run data modify storage xiangqi:visual coord set value {x:-1.395,z:0.3825}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 10 run data modify storage xiangqi:visual coord set value {x:-0.3825,z:-1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 11 run data modify storage xiangqi:visual coord set value {x:1.395,z:-0.1275}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 11 run data modify storage xiangqi:visual coord set value {x:0.1275,z:1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 11 run data modify storage xiangqi:visual coord set value {x:-1.395,z:0.1275}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 11 run data modify storage xiangqi:visual coord set value {x:-0.1275,z:-1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 12 run data modify storage xiangqi:visual coord set value {x:1.395,z:0.1275}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 12 run data modify storage xiangqi:visual coord set value {x:-0.1275,z:1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 12 run data modify storage xiangqi:visual coord set value {x:-1.395,z:-0.1275}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 12 run data modify storage xiangqi:visual coord set value {x:0.1275,z:-1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 13 run data modify storage xiangqi:visual coord set value {x:1.395,z:0.3825}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 13 run data modify storage xiangqi:visual coord set value {x:-0.3825,z:1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 13 run data modify storage xiangqi:visual coord set value {x:-1.395,z:-0.3825}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 13 run data modify storage xiangqi:visual coord set value {x:0.3825,z:-1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 14 run data modify storage xiangqi:visual coord set value {x:1.395,z:0.6375}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 14 run data modify storage xiangqi:visual coord set value {x:-0.6375,z:1.395}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 14 run data modify storage xiangqi:visual coord set value {x:-1.395,z:-0.6375}
execute if score #vis_cap xq_ctx matches 4 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 14 run data modify storage xiangqi:visual coord set value {x:0.6375,z:-1.395}
execute if score #vis_cap xq_ctx matches 8 run data modify storage xiangqi:visual scale set value 0.165
execute if score #vis_cap xq_ctx matches 8 run data modify storage xiangqi:visual lift set value 0.0825
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 0 run data modify storage xiangqi:visual coord set value {x:1.735,z:-1.225}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 0 run data modify storage xiangqi:visual coord set value {x:1.225,z:1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 0 run data modify storage xiangqi:visual coord set value {x:-1.735,z:1.225}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 0 run data modify storage xiangqi:visual coord set value {x:-1.225,z:-1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 1 run data modify storage xiangqi:visual coord set value {x:1.735,z:-0.875}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 1 run data modify storage xiangqi:visual coord set value {x:0.875,z:1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 1 run data modify storage xiangqi:visual coord set value {x:-1.735,z:0.875}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 1 run data modify storage xiangqi:visual coord set value {x:-0.875,z:-1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 2 run data modify storage xiangqi:visual coord set value {x:1.735,z:-0.525}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 2 run data modify storage xiangqi:visual coord set value {x:0.525,z:1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 2 run data modify storage xiangqi:visual coord set value {x:-1.735,z:0.525}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 2 run data modify storage xiangqi:visual coord set value {x:-0.525,z:-1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 3 run data modify storage xiangqi:visual coord set value {x:1.735,z:-0.175}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 3 run data modify storage xiangqi:visual coord set value {x:0.175,z:1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 3 run data modify storage xiangqi:visual coord set value {x:-1.735,z:0.175}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 3 run data modify storage xiangqi:visual coord set value {x:-0.175,z:-1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 4 run data modify storage xiangqi:visual coord set value {x:1.735,z:0.175}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 4 run data modify storage xiangqi:visual coord set value {x:-0.175,z:1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 4 run data modify storage xiangqi:visual coord set value {x:-1.735,z:-0.175}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 4 run data modify storage xiangqi:visual coord set value {x:0.175,z:-1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 5 run data modify storage xiangqi:visual coord set value {x:1.735,z:0.525}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 5 run data modify storage xiangqi:visual coord set value {x:-0.525,z:1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 5 run data modify storage xiangqi:visual coord set value {x:-1.735,z:-0.525}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 5 run data modify storage xiangqi:visual coord set value {x:0.525,z:-1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 6 run data modify storage xiangqi:visual coord set value {x:1.735,z:0.875}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 6 run data modify storage xiangqi:visual coord set value {x:-0.875,z:1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 6 run data modify storage xiangqi:visual coord set value {x:-1.735,z:-0.875}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 6 run data modify storage xiangqi:visual coord set value {x:0.875,z:-1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 7 run data modify storage xiangqi:visual coord set value {x:1.735,z:1.225}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 7 run data modify storage xiangqi:visual coord set value {x:-1.225,z:1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 7 run data modify storage xiangqi:visual coord set value {x:-1.735,z:-1.225}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 7 run data modify storage xiangqi:visual coord set value {x:1.225,z:-1.735}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 8 run data modify storage xiangqi:visual coord set value {x:1.905,z:-1.225}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 8 run data modify storage xiangqi:visual coord set value {x:1.225,z:1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 8 run data modify storage xiangqi:visual coord set value {x:-1.905,z:1.225}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 8 run data modify storage xiangqi:visual coord set value {x:-1.225,z:-1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 9 run data modify storage xiangqi:visual coord set value {x:1.905,z:-0.875}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 9 run data modify storage xiangqi:visual coord set value {x:0.875,z:1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 9 run data modify storage xiangqi:visual coord set value {x:-1.905,z:0.875}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 9 run data modify storage xiangqi:visual coord set value {x:-0.875,z:-1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 10 run data modify storage xiangqi:visual coord set value {x:1.905,z:-0.525}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 10 run data modify storage xiangqi:visual coord set value {x:0.525,z:1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 10 run data modify storage xiangqi:visual coord set value {x:-1.905,z:0.525}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 10 run data modify storage xiangqi:visual coord set value {x:-0.525,z:-1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 11 run data modify storage xiangqi:visual coord set value {x:1.905,z:-0.175}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 11 run data modify storage xiangqi:visual coord set value {x:0.175,z:1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 11 run data modify storage xiangqi:visual coord set value {x:-1.905,z:0.175}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 11 run data modify storage xiangqi:visual coord set value {x:-0.175,z:-1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 12 run data modify storage xiangqi:visual coord set value {x:1.905,z:0.175}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 12 run data modify storage xiangqi:visual coord set value {x:-0.175,z:1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 12 run data modify storage xiangqi:visual coord set value {x:-1.905,z:-0.175}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 12 run data modify storage xiangqi:visual coord set value {x:0.175,z:-1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 13 run data modify storage xiangqi:visual coord set value {x:1.905,z:0.525}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 13 run data modify storage xiangqi:visual coord set value {x:-0.525,z:1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 13 run data modify storage xiangqi:visual coord set value {x:-1.905,z:-0.525}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 13 run data modify storage xiangqi:visual coord set value {x:0.525,z:-1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 0 if score #vis_slot xq_ctx matches 14 run data modify storage xiangqi:visual coord set value {x:1.905,z:0.875}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 1 if score #vis_slot xq_ctx matches 14 run data modify storage xiangqi:visual coord set value {x:-0.875,z:1.905}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 2 if score #vis_slot xq_ctx matches 14 run data modify storage xiangqi:visual coord set value {x:-1.905,z:-0.875}
execute if score #vis_cap xq_ctx matches 8 if score #vis_edge xq_ctx matches 3 if score #vis_slot xq_ctx matches 14 run data modify storage xiangqi:visual coord set value {x:0.875,z:-1.905}
data modify storage xiangqi:visual x set from storage xiangqi:visual coord.x
data modify storage xiangqi:visual z set from storage xiangqi:visual coord.z
function xiangqi:visual/man_rotation
function xiangqi:visual/set_pose with storage xiangqi:visual
