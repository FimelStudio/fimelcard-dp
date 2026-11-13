execute store result score #round ma_ctx run data get entity @s data.magical_athlete.round
execute if score @s ma_fround = #round ma_ctx run return 0
scoreboard players operation @s ma_fround = #round ma_ctx
execute if data entity @s data.magical_athlete.racers[0] run function magical_athlete:feedback/reveal_racer {index:0}
execute if data entity @s data.magical_athlete.racers[1] run function magical_athlete:feedback/reveal_racer {index:1}
execute if data entity @s data.magical_athlete.racers[2] run function magical_athlete:feedback/reveal_racer {index:2}
execute if data entity @s data.magical_athlete.racers[3] run function magical_athlete:feedback/reveal_racer {index:3}
execute if data entity @s data.magical_athlete.racers[4] run function magical_athlete:feedback/reveal_racer {index:4}
execute if data entity @s data.magical_athlete.racers[5] run function magical_athlete:feedback/reveal_racer {index:5}
