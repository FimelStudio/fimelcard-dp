scoreboard players set @s cp_drop_red 0
scoreboard players operation #ctx cp_ctx = @s cp_id
execute unless entity @e[tag=cp.input_drop,limit=1] run return 0
kill @e[tag=cp.input_drop,limit=1]
tag @e[tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=2,cp_vote_used=0}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[tag=cp.current,limit=1] run return 0
execute as @e[tag=cp.current,limit=1] at @s run function critical_point:vote/start
tag @e[tag=cp.current] remove cp.current
