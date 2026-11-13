$execute store result score #points ma_ctx run data get storage magical_athlete:engine s.p$(owner).points
$execute store result score #racepoints ma_ctx run data get storage magical_athlete:engine s.p$(owner).race_points
scoreboard players operation #old_points ma_ctx = #points ma_ctx
scoreboard players operation #points ma_ctx += #amount ma_ctx
execute if score #points ma_ctx matches ..-1 run scoreboard players set #points ma_ctx 0
scoreboard players operation #delta ma_ctx = #points ma_ctx
scoreboard players operation #delta ma_ctx -= #old_points ma_ctx
scoreboard players operation #racepoints ma_ctx += #delta ma_ctx
$execute store result storage magical_athlete:engine s.p$(owner).points int 1 run scoreboard players get #points ma_ctx
$execute store result storage magical_athlete:engine s.p$(owner).race_points int 1 run scoreboard players get #racepoints ma_ctx
