execute if score #spell ab_ctx matches 1 run function abraca:action/fail_dragon
execute if score #spell ab_ctx matches 1 run return 0
function abraca:message/fail
scoreboard players remove @a[tag=ab.actor,limit=1] ab_hp 1
function abraca:hud/update
function abraca:turn/end
