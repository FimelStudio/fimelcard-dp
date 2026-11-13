function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
$execute unless score @s ma_table matches $(table) run return 0
$execute unless score @e[tag=ma.current,limit=1] ma_epoch matches $(epoch) run return run function magical_athlete:direct/stale
execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ma_table
execute store result storage magical_athlete:direct epoch int 1 run scoreboard players get @s ma_depoch
$scoreboard players set #code ma_ctx $(code)
execute if score #code ma_ctx matches 100..135 unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run function magical_athlete:direct/wait
execute if score #code ma_ctx matches 9997 run return run function magical_athlete:direct/special
execute if score #code ma_ctx matches 9998 run return run function magical_athlete:direct/cancel
execute if score #code ma_ctx matches 9999 run return run function magical_athlete:direct/next_page
execute if score #code ma_ctx matches 2099..2135 run return run function magical_athlete:direct/q_submit
function magical_athlete:direct/confirm
