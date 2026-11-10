$execute unless predicate {condition:"minecraft:value_check",value:$(target),range:{min:0,max:5}} run return 0
scoreboard players set #choice_targets_pawn ma_ctx 0
execute if data entity @s data.ma_feedback.choice{kind:"hypnotist"} run scoreboard players set #choice_targets_pawn ma_ctx 1
execute if data entity @s data.ma_feedback.choice{kind:"flip"} run scoreboard players set #choice_targets_pawn ma_ctx 1
execute if data entity @s data.ma_feedback.choice{kind:"duel"} run scoreboard players set #choice_targets_pawn ma_ctx 1
execute if data entity @s data.ma_feedback.choice{kind:"mastermind"} run scoreboard players set #choice_targets_pawn ma_ctx 1
execute if data entity @s data.ma_feedback.choice{kind:"copycat"} run scoreboard players set #choice_targets_pawn ma_ctx 1
execute unless score #choice_targets_pawn ma_ctx matches 1 run return 0
$data modify storage magical_athlete:feedback racer set from entity @s data.magical_athlete.racers[$(target)]
data modify storage magical_athlete:feedback event set value {source:-1,source_actor:-1,actor:0,name:""}
data modify storage magical_athlete:feedback event.source_actor set from entity @s data.ma_feedback.choice.pawn
function magical_athlete:feedback/choice_source with storage magical_athlete:feedback event
function magical_athlete:feedback/event_name with storage magical_athlete:feedback racer
function magical_athlete:feedback/source with storage magical_athlete:feedback event
