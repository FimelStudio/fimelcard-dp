$scoreboard players set #reactor ma_ctx $(reactor)
$scoreboard players set #mover ma_ctx $(pawn)
$scoreboard players set #from ma_ctx $(from)
$scoreboard players set #to ma_ctx $(to)
$scoreboard players set #moved ma_ctx $(moved)
execute if score #reactor ma_ctx matches 0 run scoreboard players operation #rpower ma_ctx = #p0 ma_ctx
execute if score #reactor ma_ctx matches 0 run scoreboard players operation #rstatus ma_ctx = #s0 ma_ctx
execute if score #reactor ma_ctx matches 0 run scoreboard players operation #rpos ma_ctx = #x0 ma_ctx
execute if score #reactor ma_ctx matches 1 run scoreboard players operation #rpower ma_ctx = #p1 ma_ctx
execute if score #reactor ma_ctx matches 1 run scoreboard players operation #rstatus ma_ctx = #s1 ma_ctx
execute if score #reactor ma_ctx matches 1 run scoreboard players operation #rpos ma_ctx = #x1 ma_ctx
execute if score #reactor ma_ctx matches 2 run scoreboard players operation #rpower ma_ctx = #p2 ma_ctx
execute if score #reactor ma_ctx matches 2 run scoreboard players operation #rstatus ma_ctx = #s2 ma_ctx
execute if score #reactor ma_ctx matches 2 run scoreboard players operation #rpos ma_ctx = #x2 ma_ctx
execute if score #reactor ma_ctx matches 3 run scoreboard players operation #rpower ma_ctx = #p3 ma_ctx
execute if score #reactor ma_ctx matches 3 run scoreboard players operation #rstatus ma_ctx = #s3 ma_ctx
execute if score #reactor ma_ctx matches 3 run scoreboard players operation #rpos ma_ctx = #x3 ma_ctx
execute if score #reactor ma_ctx matches 4 run scoreboard players operation #rpower ma_ctx = #p4 ma_ctx
execute if score #reactor ma_ctx matches 4 run scoreboard players operation #rstatus ma_ctx = #s4 ma_ctx
execute if score #reactor ma_ctx matches 4 run scoreboard players operation #rpos ma_ctx = #x4 ma_ctx
execute if score #reactor ma_ctx matches 5 run scoreboard players operation #rpower ma_ctx = #p5 ma_ctx
execute if score #reactor ma_ctx matches 5 run scoreboard players operation #rstatus ma_ctx = #s5 ma_ctx
execute if score #reactor ma_ctx matches 5 run scoreboard players operation #rpos ma_ctx = #x5 ma_ctx
execute unless score #rstatus ma_ctx matches 0 run return 0
$execute store success score #joint ma_ctx if data storage magical_athlete:engine job{group:[$(reactor)]}
execute if score #rpower ma_ctx matches 2 if score #moved ma_ctx matches 1 unless score #reactor ma_ctx = #mover ma_ctx run function magical_athlete:engine/react/banana with storage magical_athlete:engine job
execute if score #rpower ma_ctx matches 4 if score #moved ma_ctx matches 1 if score #reactor ma_ctx = #mover ma_ctx run function magical_athlete:engine/react/centaur with storage magical_athlete:engine job
execute if score #rpower ma_ctx matches 1 run function magical_athlete:engine/react/baba with storage magical_athlete:engine job
execute if score #rpower ma_ctx matches 25 if score #reactor ma_ctx = #mover ma_ctx run function magical_athlete:engine/react/mouth with storage magical_athlete:engine job
execute if score #rpower ma_ctx matches 28 run function magical_athlete:engine/react/romantic with storage magical_athlete:engine job
execute if score #rpower ma_ctx matches 9 run function magical_athlete:engine/react/duel with storage magical_athlete:engine job
