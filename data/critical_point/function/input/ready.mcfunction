scoreboard players set @s cp_drop_lime 0
scoreboard players operation #ctx cp_ctx = @s cp_id
execute unless entity @e[tag=cp.input_drop,limit=1] run return 0
kill @e[tag=cp.input_drop,limit=1]
tag @e[tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=2}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[tag=cp.current,limit=1] run return 0
scoreboard players set @s cp_ready 1
tellraw @s [{text:'[临界点] ',color:'red'},{text:'已准备进入下一轮。',color:'green'}]
execute as @e[tag=cp.current,limit=1] at @s run function critical_point:round/check_ready
tag @e[tag=cp.current] remove cp.current
