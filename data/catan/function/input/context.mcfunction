tag @a[tag=ca.actor] remove ca.actor
tag @e[tag=ca.current] remove ca.current
execute unless entity @s[tag=ct.player,tag=ca.player] run return 0
execute unless score @s ca_table = @s ct_id run return 0
scoreboard players operation #input_table ca_ctx = @s ca_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ca.controller,scores={ct_game=21,ct_state=1}] if score @s ct_id = #input_table ca_ctx run tag @s add ca.current
execute unless entity @e[tag=ca.current,limit=1] run return 0
tag @s add ca.actor
execute as @e[tag=ca.current,limit=1] at @s run function catan:system/context
