# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #owner ca_ctx 0
execute on origin if entity @s[tag=ca.dropper] run scoreboard players set #owner ca_ctx 1
execute unless score #owner ca_ctx matches 1 run return 0
data modify storage catan:input drop set value {action:-1,table:-1,epoch:-1}
data modify storage catan:input drop merge from entity @s Item.components."minecraft:custom_data".catan
function catan:input/use_drop
kill @s
