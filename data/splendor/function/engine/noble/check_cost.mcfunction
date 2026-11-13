$execute store result score #need sp_ctx run data get storage splendor:cards nobles[$(id)].cost[0]
execute if score #bonus0 sp_ctx < #need sp_ctx run return 0
$execute store result score #need sp_ctx run data get storage splendor:cards nobles[$(id)].cost[1]
execute if score #bonus1 sp_ctx < #need sp_ctx run return 0
$execute store result score #need sp_ctx run data get storage splendor:cards nobles[$(id)].cost[2]
execute if score #bonus2 sp_ctx < #need sp_ctx run return 0
$execute store result score #need sp_ctx run data get storage splendor:cards nobles[$(id)].cost[3]
execute if score #bonus3 sp_ctx < #need sp_ctx run return 0
$execute store result score #need sp_ctx run data get storage splendor:cards nobles[$(id)].cost[4]
execute if score #bonus4 sp_ctx < #need sp_ctx run return 0
$data modify storage splendor:engine state.eligible append value $(slot)
