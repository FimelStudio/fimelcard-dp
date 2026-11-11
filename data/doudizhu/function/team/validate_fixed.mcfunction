function doudizhu:team/fixed_span
scoreboard players set #paired dd_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx run function doudizhu:team/check_opposite
execute unless score #paired dd_ctx matches 4 run tellraw @a[tag=ct.start_actor,limit=1] {text:"固定组队需要四人坐成两对正对座位。",color:"red"}
execute unless score #paired dd_ctx matches 4 run return fail
return 1
