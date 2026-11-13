scoreboard players set #kind gd_ctx 8
execute if score #probe_total gd_ctx matches 4.. run function guandan:hint/bomb {size:4,power:4}
execute if score #probe_total gd_ctx matches 5.. run function guandan:hint/bomb {size:5,power:5}
execute if score #probe_total gd_ctx matches 6.. run function guandan:hint/bomb {size:6,power:7}
execute if score #probe_total gd_ctx matches 7.. run function guandan:hint/bomb {size:7,power:8}
execute if score #probe_total gd_ctx matches 8.. run function guandan:hint/bomb {size:8,power:9}
execute if score #probe_total gd_ctx matches 9.. run function guandan:hint/bomb {size:9,power:10}
execute if score #probe_total gd_ctx matches 10.. run function guandan:hint/bomb {size:10,power:11}
