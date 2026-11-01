tag @a[tag=gd.actor] remove gd.actor
tag @e[tag=gd.me] remove gd.me
tag @e[tag=gd.current] remove gd.current
execute unless entity @s[tag=ct.player,tag=gd.player] run return 0
execute unless score @s ct_id = @s gd_table run return 0
scoreboard players operation #ui_table gd_ctx = @s gd_table
scoreboard players operation #ui_seat gd_ctx = @s gd_seat
execute as @e[type=minecraft:marker,tag=ct.controller,tag=gd.controller,scores={ct_game=18,ct_state=1,gd_state=1..5}] if score @s ct_id = #ui_table gd_ctx run tag @s add gd.current
execute unless entity @e[tag=gd.current,limit=1] run return 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:system/context
execute as @e[tag=gd.board] if score @s gd_seat = #ui_seat gd_ctx run tag @s add gd.me
execute unless entity @e[tag=gd.me,limit=1] run return 0
tag @s add gd.actor
scoreboard players operation #actor gd_ctx = @s gd_seat
