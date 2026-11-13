scoreboard players set #power gd_ctx 0
execute if score #probe_total gd_ctx matches 1.. run function guandan:hint/lead_size {size:1}
execute if score #probe_total gd_ctx matches 2.. run function guandan:hint/lead_size {size:2}
execute if score #probe_total gd_ctx matches 3.. run function guandan:hint/lead_size {size:3}
