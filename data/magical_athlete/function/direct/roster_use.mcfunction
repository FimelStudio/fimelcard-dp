function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
$execute unless score @s ma_table matches $(table) run return 0
$data modify storage magical_athlete:direct id set value $(char)
execute unless entity @e[tag=ma.current,scores={ma_state=2},limit=1] run return run function magical_athlete:direct/roster_info with storage magical_athlete:direct
execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
$execute unless data storage magical_athlete:ui hand{hand:[$(char)]} run return run function magical_athlete:direct/used_roster
execute store result score #submitted ma_ctx run data get storage magical_athlete:ui hand.selected
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #submitted ma_ctx matches 2.. run return run function magical_athlete:direct/lineup_wait
execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #submitted ma_ctx matches 1.. run return run function magical_athlete:direct/lineup_wait
$scoreboard players set #code ma_ctx $(char)
scoreboard players add #code ma_ctx 200
function magical_athlete:direct/confirm
