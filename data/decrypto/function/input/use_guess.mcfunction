# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @e[tag=dc.current] remove dc.current
execute as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=5..8}] if score @s dc_id = #ctx dc_ctx run tag @s add dc.current
execute unless entity @e[tag=dc.current,limit=1] run return 0
execute as @e[tag=dc.current,limit=1] run function decrypto:roles/ensure
scoreboard players operation #phase dc_ctx = @e[tag=dc.current,limit=1] dc_state
function decrypto:player/can_input
execute unless score #authorized dc_ctx matches 1 run tag @e[tag=dc.current] remove dc.current
execute unless score #authorized dc_ctx matches 1 run return 0
kill @e[type=minecraft:item,tag=dc.guess_drop,limit=1]
function decrypto:input/give_guess
function decrypto:dialog/digits
tag @e[tag=dc.current] remove dc.current
