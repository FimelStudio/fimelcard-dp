scoreboard players set #lead ma_ctx -1
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x0 ma_ctx
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x1 ma_ctx
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x2 ma_ctx
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x3 ma_ctx
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x4 ma_ctx
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x5 ma_ctx
$data modify storage magical_athlete:engine s.pending set value {kind:"copycat",owner:0,pawn:$(pawn),options:[]}
$data modify storage magical_athlete:engine s.pending.owner set from storage magical_athlete:engine s.racers[$(pawn)].owner
$data modify storage magical_athlete:engine s.copy_locks[$(pawn)] set value 1
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #lead ma_ctx unless score #p0 ma_ctx matches -1 run data modify storage magical_athlete:engine s.pending.options append value 0
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #lead ma_ctx unless score #p1 ma_ctx matches -1 run data modify storage magical_athlete:engine s.pending.options append value 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #lead ma_ctx unless score #p2 ma_ctx matches -1 run data modify storage magical_athlete:engine s.pending.options append value 2
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #lead ma_ctx unless score #p3 ma_ctx matches -1 run data modify storage magical_athlete:engine s.pending.options append value 3
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #lead ma_ctx unless score #p4 ma_ctx matches -1 run data modify storage magical_athlete:engine s.pending.options append value 4
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #lead ma_ctx unless score #p5 ma_ctx matches -1 run data modify storage magical_athlete:engine s.pending.options append value 5
execute store result score #count ma_ctx run data get storage magical_athlete:engine s.pending.options
execute unless score #count ma_ctx matches 2.. run data modify storage magical_athlete:engine s.pending set value {kind:"",owner:0,pawn:-1,options:[]}
