$execute store result score #ui_port ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.port_types[$(port)]
execute if score #ui_port ca_ctx matches -1 if score #ui_ratio0 ca_ctx matches 4 run scoreboard players set #ui_ratio0 ca_ctx 3
execute if score #ui_port ca_ctx matches -1 if score #ui_ratio1 ca_ctx matches 4 run scoreboard players set #ui_ratio1 ca_ctx 3
execute if score #ui_port ca_ctx matches -1 if score #ui_ratio2 ca_ctx matches 4 run scoreboard players set #ui_ratio2 ca_ctx 3
execute if score #ui_port ca_ctx matches -1 if score #ui_ratio3 ca_ctx matches 4 run scoreboard players set #ui_ratio3 ca_ctx 3
execute if score #ui_port ca_ctx matches -1 if score #ui_ratio4 ca_ctx matches 4 run scoreboard players set #ui_ratio4 ca_ctx 3
execute if score #ui_port ca_ctx matches 0 run scoreboard players set #ui_ratio0 ca_ctx 2
execute if score #ui_port ca_ctx matches 1 run scoreboard players set #ui_ratio1 ca_ctx 2
execute if score #ui_port ca_ctx matches 2 run scoreboard players set #ui_ratio2 ca_ctx 2
execute if score #ui_port ca_ctx matches 3 run scoreboard players set #ui_ratio3 ca_ctx 2
execute if score #ui_port ca_ctx matches 4 run scoreboard players set #ui_ratio4 ca_ctx 2
