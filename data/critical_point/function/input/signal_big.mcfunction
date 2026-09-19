scoreboard players operation #ctx cp_ctx = @s cp_id
execute if score @s cp_locked matches 1 run return 0
tag @e[type=minecraft:marker,tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=1}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[type=minecraft:marker,tag=cp.current,limit=1] run return 0
kill @e[type=minecraft:item,tag=cp.signal_big_drop,distance=..1,sort=nearest,limit=1]
give @s minecraft:black_dye[minecraft:item_name='本轮倾向出偏大的牌（Q）',minecraft:custom_data={critical_point:{tool:'signal_big'}},minecraft:max_stack_size=1]
tag @s add cp.signal_actor
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run tag @s add cp.audience
tellraw @a[tag=cp.audience] [{text:'[临界点] ',color:'red'},{selector:'@a[tag=cp.signal_actor,limit=1]',color:'yellow'},{text:'：我这把会出偏大的牌。',color:'gray'}]
tag @a[tag=cp.audience] remove cp.audience
tag @s remove cp.signal_actor
tag @e[type=minecraft:marker,tag=cp.current] remove cp.current
