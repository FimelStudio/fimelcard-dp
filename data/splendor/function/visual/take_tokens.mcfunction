execute store result score #vis_count sp_ctx run data get storage splendor:visual event.take[0]
execute if score #vis_count sp_ctx matches 1.. run data modify storage splendor:visual model set value "token/diamond"
execute store result score #vis_count sp_ctx run data get storage splendor:visual event.take[1]
execute if score #vis_count sp_ctx matches 1.. run data modify storage splendor:visual model set value "token/sapphire"
execute store result score #vis_count sp_ctx run data get storage splendor:visual event.take[2]
execute if score #vis_count sp_ctx matches 1.. run data modify storage splendor:visual model set value "token/emerald"
execute store result score #vis_count sp_ctx run data get storage splendor:visual event.take[3]
execute if score #vis_count sp_ctx matches 1.. run data modify storage splendor:visual model set value "token/ruby"
execute store result score #vis_count sp_ctx run data get storage splendor:visual event.take[4]
execute if score #vis_count sp_ctx matches 1.. run data modify storage splendor:visual model set value "token/onyx"
execute store result score #vis_count sp_ctx run data get storage splendor:visual event.take[5]
execute if score #vis_count sp_ctx matches 1.. run data modify storage splendor:visual model set value "token/gold"
