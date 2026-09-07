scoreboard players set @s cp_drop_reopen 0
tag @e[tag=cp.reopen_drop] remove cp.reopen_drop
execute at @s as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{critical_point:{tool:'vote_reopen'}}] run tag @s add cp.reopen_drop
execute unless entity @e[tag=cp.reopen_drop,limit=1] run return 0
kill @e[tag=cp.reopen_drop,distance=..3,sort=nearest,limit=1]
tag @e[tag=cp.reopen_drop] remove cp.reopen_drop
execute if score @s cp_locked matches 1 run return 0
scoreboard players operation #ctx cp_ctx = @s cp_id
tag @e[tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=3}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[tag=cp.current,limit=1] run return 0
function critical_point:dialog/open_vote
function critical_point:input/give_vote_reopen
tag @e[tag=cp.current] remove cp.current
