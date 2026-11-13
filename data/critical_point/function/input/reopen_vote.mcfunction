# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s cp_drop_reopen 0
execute unless entity @e[tag=cp.input_drop,limit=1] run return 0
kill @e[tag=cp.input_drop,limit=1]
execute if score @s cp_locked matches 1 run return 0
scoreboard players operation #ctx cp_ctx = @s cp_id
tag @e[tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=3}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[tag=cp.current,limit=1] run return 0
function critical_point:dialog/open_vote
function critical_point:input/give_vote_reopen
tag @e[tag=cp.current] remove cp.current
