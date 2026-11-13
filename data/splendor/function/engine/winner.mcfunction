$execute store result score #pv sp_ctx run data get storage splendor:engine state.p$(actor).vp
$execute store result score #pc sp_ctx run data get storage splendor:engine state.p$(actor).cards
execute if score #pv sp_ctx < #best_vp sp_ctx run return 0
execute if score #pv sp_ctx = #best_vp sp_ctx if score #pc sp_ctx > #best_cards sp_ctx run return 0
execute if score #pv sp_ctx > #best_vp sp_ctx run data modify storage splendor:engine state.winners set value []
execute if score #pv sp_ctx = #best_vp sp_ctx if score #pc sp_ctx < #best_cards sp_ctx run data modify storage splendor:engine state.winners set value []
scoreboard players operation #best_vp sp_ctx = #pv sp_ctx
scoreboard players operation #best_cards sp_ctx = #pc sp_ctx
$data modify storage splendor:engine state.winners append value $(actor)
