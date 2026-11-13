execute store result storage guandan:runtime value int 1 run scoreboard players get @s gd_type
data modify entity @e[tag=gd.current,limit=1] data.guandan.action.cardtypes append from storage guandan:runtime value
execute store result storage guandan:runtime value int 1 run scoreboard players get @s gd_id
data modify entity @e[tag=gd.current,limit=1] data.guandan.action.ids append from storage guandan:runtime value
scoreboard players set @s gd_owner -2
scoreboard players set @s gd_sel 0
scoreboard players set @s gd_used 1
