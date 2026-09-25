scoreboard players operation #ctx cp_ctx = @s cp_id
execute if score @s cp_locked matches 1 run return 0
tag @e[type=minecraft:marker,tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=1}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[type=minecraft:marker,tag=cp.current,limit=1] run return 0
kill @e[type=minecraft:item,tag=cp.signal_small_drop,distance=..1,sort=nearest,limit=1]
function critical_point:input/clear_signal_tools
tag @s add cp.signal_actor
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run tag @s add cp.audience
tellraw @a[tag=cp.audience] [{text:'[临界点] ',color:'red'},{selector:'@a[tag=cp.signal_actor,limit=1]',color:'yellow'},{text:'：我这把会出偏小的牌。',color:'gray'}]
tag @a[tag=cp.audience] remove cp.audience
tag @s remove cp.signal_actor
tag @e[type=minecraft:marker,tag=cp.current] remove cp.current
