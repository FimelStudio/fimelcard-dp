scoreboard players set #dye_owner ca_ctx 0
execute on origin if entity @s[tag=ca.dye_owner] run scoreboard players set #dye_owner ca_ctx 1
execute unless score #dye_owner ca_ctx matches 1 run return 0
execute as @a[tag=ca.dye_owner,limit=1] run function catan:ui/open
execute as @a[tag=ca.dye_owner,limit=1] run function catan:input/give
kill @s
