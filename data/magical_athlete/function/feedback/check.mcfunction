data modify storage magical_athlete:feedback state set value {phase:0,turn:0,round:0,active:-1,pending:{}}
data modify storage magical_athlete:feedback state.phase set from entity @s data.magical_athlete.phase
data modify storage magical_athlete:feedback state.turn set from entity @s data.magical_athlete.turn
data modify storage magical_athlete:feedback state.round set from entity @s data.magical_athlete.round
data modify storage magical_athlete:feedback state.active set from entity @s data.magical_athlete.active
data modify storage magical_athlete:feedback state.pending set from entity @s data.magical_athlete.pending
execute store success score #state_changed ma_ctx run data modify entity @s data.ma_feedback.state set from storage magical_athlete:feedback state
execute if score #state_changed ma_ctx matches 1 run function magical_athlete:feedback/state with entity @s data.magical_athlete
