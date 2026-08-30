scoreboard players operation #ctx ab_ctx = @s ab_id
execute store result storage abraca:debug id int 1 run scoreboard players get @s ab_id
execute store result storage abraca:debug seat int 1 run scoreboard players get @a[tag=ab.actor,limit=1] ab_seat
execute store result storage abraca:debug spell int 1 run scoreboard players get #spell ab_ctx
function abraca:debug/log_fail with storage abraca:debug
tag @a[tag=ab.audience] remove ab.audience
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s add ab.audience
function abraca:message/fail_order_spell
tag @a[tag=ab.audience] remove ab.audience
function abraca:sound/fail
scoreboard players remove @a[tag=ab.actor,limit=1] ab_hp 1
function abraca:hud/update
function abraca:turn/end
