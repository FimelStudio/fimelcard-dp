function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
$execute unless score @s ma_table matches $(table) run return 0
$execute unless score @e[tag=ma.current,limit=1] ma_epoch matches $(epoch) run return 0
execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return 0
$scoreboard players set #code ma_ctx $(code)
execute if score #code ma_ctx matches 9999 run clear @s minecraft:paper[minecraft:custom_data~{magical_athlete:{choice:1b}}]
execute if score #code ma_ctx matches 9999 run scoreboard players add @s ma_choicepage 6
execute if score #code ma_ctx matches 9999 run return run function magical_athlete:direct/choices
scoreboard players operation @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch
function magical_athlete:ui/dispatch
function magical_athlete:direct/choices
