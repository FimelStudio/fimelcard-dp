scoreboard players operation @s gd_owner = #to gd_ctx
scoreboard players set @s gd_sel 0
data modify storage guandan:runtime transfer set value {}
execute store result storage guandan:runtime transfer.from int 1 run scoreboard players get #from gd_ctx
execute store result storage guandan:runtime transfer.to int 1 run scoreboard players get #to gd_ctx
execute store result storage guandan:runtime transfer.type int 1 run scoreboard players get @s gd_type
execute store result storage guandan:runtime transfer.id int 1 run scoreboard players get @s gd_id
data modify entity @e[tag=gd.current,limit=1] data.guandan.exchange append from storage guandan:runtime transfer
