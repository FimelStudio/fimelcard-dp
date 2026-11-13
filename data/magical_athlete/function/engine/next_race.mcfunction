execute unless score #phase ma_ctx matches 4 run return run function magical_athlete:engine/error {id:5}
execute store result score #round ma_ctx run data get storage magical_athlete:engine s.round
scoreboard players add #round ma_ctx 1
execute store result storage magical_athlete:engine s.round int 1 run scoreboard players get #round ma_ctx
data modify storage magical_athlete:engine s.phase set value 2
data modify storage magical_athlete:engine s.pending set value {kind:"",owner:0,pawn:-1,options:[]}
execute store result score #mode ma_ctx run data get storage magical_athlete:engine s.track_mode
scoreboard players operation #track ma_ctx = #round ma_ctx
scoreboard players set #two ma_ctx 2
scoreboard players operation #track ma_ctx %= #two ma_ctx
scoreboard players set #one ma_ctx 1
scoreboard players operation #one ma_ctx -= #track ma_ctx
scoreboard players operation #track ma_ctx = #one ma_ctx
execute if score #mode ma_ctx matches 1 run scoreboard players set #track ma_ctx 0
execute if score #mode ma_ctx matches 2 run scoreboard players set #track ma_ctx 1
execute store result storage magical_athlete:engine s.track int 1 run scoreboard players get #track ma_ctx
data modify storage magical_athlete:engine s.p1.selected set value []
data modify storage magical_athlete:engine s.p2.selected set value []
data modify storage magical_athlete:engine s.p3.selected set value []
data modify storage magical_athlete:engine s.p4.selected set value []
data modify storage magical_athlete:engine s.p5.selected set value []
data modify storage magical_athlete:engine s.p6.selected set value []
scoreboard players set #ok ma_ctx 1
