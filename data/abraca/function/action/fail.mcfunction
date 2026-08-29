execute if score #spell ab_ctx matches 1 run function abraca:action/fail_dragon
execute if score #spell ab_ctx matches 1 run return 0
execute store result storage abraca:debug id int 1 run scoreboard players get @s ab_id
execute store result storage abraca:debug seat int 1 run scoreboard players get @a[tag=ab.actor,limit=1] ab_seat
execute store result storage abraca:debug spell int 1 run scoreboard players get #spell ab_ctx
function abraca:debug/log_fail with storage abraca:debug
function abraca:message/fail
scoreboard players remove @a[tag=ab.actor,limit=1] ab_hp 1
function abraca:hud/update
function abraca:turn/end
