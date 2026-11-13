$data modify storage magical_athlete:engine s.motion.targets[$(pawn)] set from storage magical_athlete:engine s.motion.before[$(target)]
$data modify storage magical_athlete:engine s.motion.targets[$(target)] set from storage magical_athlete:engine s.motion.before[$(pawn)]
$data modify storage magical_athlete:engine s.motion.group set value [$(pawn),$(target)]
