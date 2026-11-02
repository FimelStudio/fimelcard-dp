$data modify storage splendor:engine state.p$(actor).nobles append from storage splendor:engine state.nobles[$(noble_slot)]
$data modify storage splendor:engine state.last.noble set from storage splendor:engine state.nobles[$(noble_slot)]
$data modify storage splendor:engine state.nobles[$(noble_slot)] set value -1
scoreboard players add #vp sp_ctx 3
function splendor:engine/save_actor with storage splendor:engine request
data modify storage splendor:engine state.eligible set value []
