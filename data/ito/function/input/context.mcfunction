scoreboard players set #valid it_ctx 0
tag @e[tag=it.current] remove it.current
tag @a[tag=it.actor] remove it.actor
execute unless entity @s[tag=it.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s it_table run return 0
scoreboard players operation #request_table it_ctx = @s it_table
execute as @e[tag=it.controller,scores={ct_game=19,it_state=1..4}] if score @s ct_id = #request_table it_ctx run tag @s add it.current
execute unless entity @e[tag=it.current,limit=1] run return 0
execute as @e[tag=it.current,limit=1] run function ito:system/context
scoreboard players operation #actor it_ctx = @s it_seat
tag @s add it.actor
scoreboard players set #valid it_ctx 1
