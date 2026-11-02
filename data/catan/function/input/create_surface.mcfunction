function catan:input/clear_surface
execute if score @s ct_capacity matches 4 positioned ~ ~1.025 ~ summon minecraft:interaction run function catan:input/surface {width:2.70f}
execute if score @s ct_capacity matches 8 positioned ~ ~1.025 ~ summon minecraft:interaction run function catan:input/surface {width:3.60f}
