tag @a[tag=ct.rules_actor] remove ct.rules_actor
tag @s add ct.rules_actor
execute as @e[tag=ca.current,limit=1] at @s run function catan:rules/show
tag @s remove ct.rules_actor
