tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=ct.chair_controller,limit=1] at @s run function cardtable:skin/open
tag @s remove ct.settings_actor
tag @e[tag=ct.chair_controller] remove ct.chair_controller
