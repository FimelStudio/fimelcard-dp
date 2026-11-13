execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
execute store result score @s ma_dround run data get storage magical_athlete:ui hand.selected
scoreboard players add @s ma_dround 1
