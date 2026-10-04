# Record only after validation. Starting a fresh trick clears all three previous records.
execute if score @e[tag=dd.current,limit=1] dd_type matches 0 run data remove entity @e[tag=dd.current,limit=1] data.doudizhu.hud_plays
function doudizhu:hud/build_play
execute store result storage doudizhu:hud seat int 1 run scoreboard players get @s dd_seat
function doudizhu:hud/store_play with storage doudizhu:hud
