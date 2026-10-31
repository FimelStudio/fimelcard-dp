execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{avalon:{ballot:1b}}] run function avalon:input/drop_ballot
execute as @e[type=minecraft:marker,tag=av.controller,scores={av_state=5}] at @s run function avalon:game/ending_tick
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{avalon:{role_card:1b}}] run function avalon:input/drop_role
execute as @a[tag=av.player,scores={av_action=1..}] at @s run function avalon:input/handle
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{avalon:{menu:1b}}] run function avalon:input/drop
execute as @e[type=minecraft:marker,tag=av.controller,scores={av_state=1..4}] at @s run function avalon:game/tick
execute as @a[tag=av.player] unless entity @s[tag=ct.player] run function avalon:player/clear
scoreboard players add #maintenance av_ctx 1
execute if score #maintenance av_ctx matches 20.. as @a[tag=av.player] run function avalon:player/check
execute if score #maintenance av_ctx matches 20.. run scoreboard players set #maintenance av_ctx 0
