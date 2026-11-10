function decrypto:sync/bind
execute if score #sync_ok dc_ctx matches 1 run return run function decrypto:sync/trigger
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #choice dc_ctx = @s dc_action
scoreboard players set @s dc_action 0
execute unless score #choice dc_ctx matches 101..104 run return 0
scoreboard players operation #ctx dc_ctx = @s dc_id
tag @e[tag=dc.current] remove dc.current
execute as @e[type=minecraft:marker,tag=dc.controller] if score @s dc_id = #ctx dc_ctx run tag @s add dc.current
execute unless entity @e[tag=dc.current,limit=1] run return 0
execute as @e[tag=dc.current,limit=1] run function decrypto:roles/ensure
scoreboard players operation #phase dc_ctx = @e[tag=dc.current,limit=1] dc_state
function decrypto:player/can_input
execute unless score #authorized dc_ctx matches 1 run tag @e[tag=dc.current] remove dc.current
execute unless score #authorized dc_ctx matches 1 run return 0
scoreboard players remove #choice dc_ctx 100
tag @s add dc.actor
execute as @e[tag=dc.current] at @s run function decrypto:action/save_digit
tag @s remove dc.actor
tag @e[tag=dc.current] remove dc.current
