function catan:direct/turn_guard
execute unless score #direct_ready ca_ctx matches 1 run return 0
execute if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run return 1
scoreboard players set #direct_ready ca_ctx 0
function catan:direct/phase_note
