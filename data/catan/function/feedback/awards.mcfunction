execute store success score #award_changed ca_ctx run data modify entity @s data.ca_feedback.longest set from entity @s data.catan.longest
execute if score #award_changed ca_ctx matches 1 run function catan:feedback/award_longest with entity @s data.catan
execute store success score #award_changed ca_ctx run data modify entity @s data.ca_feedback.army set from entity @s data.catan.army
execute if score #award_changed ca_ctx matches 1 run function catan:feedback/award_army with entity @s data.catan
