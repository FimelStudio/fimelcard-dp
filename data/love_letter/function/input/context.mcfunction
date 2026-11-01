tag @a[tag=ll.actor] remove ll.actor
tag @e[tag=ll.me] remove ll.me
tag @e[tag=ll.current] remove ll.current
execute unless entity @s[tag=ct.player,tag=ll.player] run return 0
execute unless score @s ct_id = @s ll_table run return 0
scoreboard players operation #ui_table ll_ctx = @s ll_table
scoreboard players operation #ui_seat ll_ctx = @s ll_seat
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1,ll_state=1..4}] if score @s ct_id = #ui_table ll_ctx run tag @s add ll.current
execute unless entity @e[tag=ll.current,limit=1] run return 0
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:system/context
execute as @e[tag=ll.board] if score @s ll_seat = #ui_seat ll_ctx run tag @s add ll.me
execute unless entity @e[tag=ll.me,limit=1] run return 0
tag @s add ll.actor
scoreboard players operation #actor ll_ctx = @s ll_seat
