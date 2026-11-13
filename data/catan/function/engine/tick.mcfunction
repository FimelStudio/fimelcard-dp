# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #changed ca_ctx 0
execute unless data entity @s data.catan{phase:10} run return 0
function catan:engine/context
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step
execute unless data storage catan:engine state.job.stack[-1] run function catan:engine/job/advance
execute unless score #changed ca_ctx matches 1 run data modify entity @s data.catan set from storage catan:engine state
execute if score #changed ca_ctx matches 1 run function catan:engine/commit
return run scoreboard players get #changed ca_ctx
