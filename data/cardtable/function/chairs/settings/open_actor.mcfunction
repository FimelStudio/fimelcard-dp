tag @s add ct.chair_actor
execute as @e[tag=ct.chair_controller,limit=1] at @s run function cardtable:chairs/settings/open
tag @s remove ct.chair_actor
tag @e[tag=ct.chair_controller] remove ct.chair_controller
