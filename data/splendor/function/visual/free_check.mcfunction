scoreboard players set #vis_free sp_ctx 1
$execute store result score #vis_cost sp_ctx run data get storage splendor:cards cards[$(card)].cost[0]
execute store result score #vis_bonus sp_ctx run data get storage splendor:visual bonus[0]
execute if score #vis_cost sp_ctx > #vis_bonus sp_ctx run scoreboard players set #vis_free sp_ctx 0
$execute store result score #vis_cost sp_ctx run data get storage splendor:cards cards[$(card)].cost[1]
execute store result score #vis_bonus sp_ctx run data get storage splendor:visual bonus[1]
execute if score #vis_cost sp_ctx > #vis_bonus sp_ctx run scoreboard players set #vis_free sp_ctx 0
$execute store result score #vis_cost sp_ctx run data get storage splendor:cards cards[$(card)].cost[2]
execute store result score #vis_bonus sp_ctx run data get storage splendor:visual bonus[2]
execute if score #vis_cost sp_ctx > #vis_bonus sp_ctx run scoreboard players set #vis_free sp_ctx 0
$execute store result score #vis_cost sp_ctx run data get storage splendor:cards cards[$(card)].cost[3]
execute store result score #vis_bonus sp_ctx run data get storage splendor:visual bonus[3]
execute if score #vis_cost sp_ctx > #vis_bonus sp_ctx run scoreboard players set #vis_free sp_ctx 0
$execute store result score #vis_cost sp_ctx run data get storage splendor:cards cards[$(card)].cost[4]
execute store result score #vis_bonus sp_ctx run data get storage splendor:visual bonus[4]
execute if score #vis_cost sp_ctx > #vis_bonus sp_ctx run scoreboard players set #vis_free sp_ctx 0
execute unless score #vis_free sp_ctx matches 1 run return 0
$data modify storage splendor:visual pose set from storage splendor:layout $(layout).free_labels[$(slot)]
data modify storage splendor:visual kind set value 7
data modify storage splendor:visual text set value {text:"免费",color:"green",bold:true}
function splendor:visual/label_spawn
