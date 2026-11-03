$execute store result score #destination ma_ctx run data get storage magical_athlete:engine s.racers[$(baby)].pos
scoreboard players remove #destination ma_ctx 1
$execute store result storage magical_athlete:engine s.racers[$(pawn)].pos int 1 run scoreboard players get #destination ma_ctx
$data modify storage magical_athlete:engine e set value {kind:2,pawn:$(pawn),from:0,to:0,source:16,amount:0,die:0}
data modify storage magical_athlete:engine e.from set from storage magical_athlete:engine s.motion.to
execute store result storage magical_athlete:engine e.to int 1 run scoreboard players get #destination ma_ctx
data modify storage magical_athlete:engine s.events append from storage magical_athlete:engine e
$execute unless data storage magical_athlete:engine s.motion{warp:1} if score #p$(pawn) ma_ctx matches 2 if data storage magical_athlete:engine s.motion{group:[$(baby)]} run data modify storage magical_athlete:engine s.queue prepend value {"type":"trip","pawn":$(baby),"source":2}
$data modify storage magical_athlete:engine baby_hook set value {type:"land",pawn:$(pawn),from:0,to:0,source:16,group:[$(pawn)],before:[],moved:0}
$data modify storage magical_athlete:engine baby_hook.from set from storage magical_athlete:engine s.motion.before[$(pawn)]
$data modify storage magical_athlete:engine baby_hook.to set from storage magical_athlete:engine s.racers[$(pawn)].pos
data modify storage magical_athlete:engine baby_hook.before set from storage magical_athlete:engine s.motion.before
$execute unless data storage magical_athlete:engine s.motion{group:[$(pawn)]} run data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine baby_hook
$data modify storage magical_athlete:engine baby_hook set value {type:"power",pawn:$(baby)}
data modify storage magical_athlete:engine s.queue append from storage magical_athlete:engine baby_hook
