$execute if items entity @s hotbar.$(slot) * run return 0
$scoreboard players set #choice_index ma_ctx $(slot)
scoreboard players operation #choice_index ma_ctx += @s ma_choicepage
execute unless score #choice_index ma_ctx < #choice_count ma_ctx run return 0
execute store result storage magical_athlete:ui index int 1 run scoreboard players get #choice_index ma_ctx
$data modify storage magical_athlete:ui slot set value $(slot)
function magical_athlete:ui/option with storage magical_athlete:ui
