scoreboard players remove #skin_choice ct_ctx 1
execute if score @s ct_skin = #skin_choice ct_ctx run return run function cardtable:skin/open
scoreboard players operation @s ct_skin = #skin_choice ct_ctx
function cardtable:skin/apply
function cardtable:skin/open
