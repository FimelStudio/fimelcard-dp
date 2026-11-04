scoreboard players set #dye_owner sp_ctx 0
execute on origin if entity @s[tag=sp.dye_owner] run scoreboard players set #dye_owner sp_ctx 1
execute unless score #dye_owner sp_ctx matches 1 run return 0
execute as @a[tag=sp.dye_owner,limit=1] run function splendor:ui/open
execute as @a[tag=sp.dye_owner,limit=1] run function splendor:input/give
kill @s
