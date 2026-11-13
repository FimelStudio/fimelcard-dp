execute if score @s ca_state matches 10 run return 0
data modify storage catan:feedback state set value {phase:0,turn:0}
data modify storage catan:feedback state.phase set from entity @s data.catan.phase
data modify storage catan:feedback state.turn set from entity @s data.catan.turn
execute store success score #state_changed ca_ctx run data modify entity @s data.ca_feedback.state set from storage catan:feedback state
execute if score #state_changed ca_ctx matches 1 run function catan:feedback/state with entity @s data.catan
