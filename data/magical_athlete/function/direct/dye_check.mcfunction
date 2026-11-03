scoreboard players set #dye_owner ma_ctx 0
execute on origin if entity @s[tag=ma.dye_owner] run scoreboard players set #dye_owner ma_ctx 1
execute unless score #dye_owner ma_ctx matches 1 run return 0
execute as @a[tag=ma.dye_owner,limit=1] run function magical_athlete:ui/open
execute as @a[tag=ma.dye_owner,limit=1] run function magical_athlete:input/give
kill @s
