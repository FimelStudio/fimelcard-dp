execute as @a[scores={ca_settings=1..}] run function catan:settings/save
execute as @a[scores={ca_action=1..}] run function catan:ui/handle
execute as @a[tag=ca.player,scores={ca_drop=1..}] at @s run function catan:input/drop
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21,ct_state=1}] at @s run function catan:game/tick
execute as @a[tag=ca.player] unless entity @s[tag=ct.player] run function catan:player/clear_state
