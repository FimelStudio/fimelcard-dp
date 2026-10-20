scoreboard players operation #skin_value ct_ctx = #skin_choice ct_ctx
# 保留旧按钮1/2与导航3/4；新增皮肤按钮5至9映射为皮肤2至6。
execute if score #skin_value ct_ctx matches 5..9 run scoreboard players remove #skin_value ct_ctx 2
scoreboard players remove #skin_value ct_ctx 1
execute if score @s ct_skin = #skin_value ct_ctx run return run function cardtable:skin/open
scoreboard players operation @s ct_skin = #skin_value ct_ctx
function cardtable:skin/apply
function cardtable:skin/open
