scoreboard players set #ui_ratio0 ca_ctx 4
scoreboard players set #ui_ratio1 ca_ctx 4
scoreboard players set #ui_ratio2 ca_ctx 4
scoreboard players set #ui_ratio3 ca_ctx 4
scoreboard players set #ui_ratio4 ca_ctx 4
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[0]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:0}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[3]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:0}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[11]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:1}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[16]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:1}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[27]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:2}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[33]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:2}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[47]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:3}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[51]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:3}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[49]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:4}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[52]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:4}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[46]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:5}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[50]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:5}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[26]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:6}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[32]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:6}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[10]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:7}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[15]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:7}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[2]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:8}
execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[5]
execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {port:8}
execute store result storage catan:ui ratio0 int 1 run scoreboard players get #ui_ratio0 ca_ctx
execute store result storage catan:ui ratio1 int 1 run scoreboard players get #ui_ratio1 ca_ctx
execute store result storage catan:ui ratio2 int 1 run scoreboard players get #ui_ratio2 ca_ctx
execute store result storage catan:ui ratio3 int 1 run scoreboard players get #ui_ratio3 ca_ctx
execute store result storage catan:ui ratio4 int 1 run scoreboard players get #ui_ratio4 ca_ctx
data modify storage catan:ui bank0 set from storage catan:ui bank[0]
data modify storage catan:ui bank1 set from storage catan:ui bank[1]
data modify storage catan:ui bank2 set from storage catan:ui bank[2]
data modify storage catan:ui bank3 set from storage catan:ui bank[3]
data modify storage catan:ui bank4 set from storage catan:ui bank[4]
