# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] run return run function catan:direct/steal_look
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run return run function catan:input/aim
execute unless entity @e[tag=ca.current,scores={ca_state=3},limit=1] run return run function catan:direct/roll_note
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
function catan:ui/simple {code:10}
