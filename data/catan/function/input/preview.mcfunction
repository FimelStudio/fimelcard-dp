# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify entity @s data.catan.preview set value {type:1,target:0,building:1}
execute store result entity @s data.catan.preview.target int 1 run scoreboard players get @a[tag=ca.actor,limit=1] ca_pick
execute if score @a[tag=ca.actor,limit=1] ca_mode matches 2 run data modify entity @s data.catan.preview.type set value 2
execute if score @a[tag=ca.actor,limit=1] ca_mode matches 3 run data modify entity @s data.catan.preview.type set value 3
execute if score @a[tag=ca.actor,limit=1] ca_mode matches 4 run data modify entity @s data.catan.preview.type set value 2
execute if score @a[tag=ca.actor,limit=1] ca_mode matches 4 run data modify entity @s data.catan.preview.building set value 2
function catan:visual/select
