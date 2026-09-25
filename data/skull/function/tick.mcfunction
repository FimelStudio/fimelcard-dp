execute as @a[tag=sk.player,scores={sk_action=1..}] run function skull:action/handle
scoreboard players add #clock sk_ctx 1
execute if score #clock sk_ctx matches 10.. as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=1..7}] at @s run function skull:system/maintenance
execute if score #clock sk_ctx matches 10.. run scoreboard players set #clock sk_ctx 0
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=7}] at @s run function skull:deal/tick
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=4}] at @s run function skull:challenge/tick
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=6}] at @s run function skull:round/settle_tick
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=1..6}] at @s run function skull:input/scan
tag @a[tag=sk.audience] remove sk.audience
