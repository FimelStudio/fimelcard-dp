# 构造候选前先按模板计算排序键；仍由正式牌型判定检查实际选中的牌。
$scoreboard players set #hint_rank dd_ctx $(high)
$scoreboard players set #hint_span dd_ctx $(high)
$scoreboard players remove #hint_span dd_ctx $(low)
scoreboard players add #hint_span dd_ctx 1
$scoreboard players set #hint_kind dd_ctx $(copies)
scoreboard players operation #hint_size dd_ctx = #hint_span dd_ctx
scoreboard players operation #hint_size dd_ctx *= #hint_kind dd_ctx
$scoreboard players set #hint_wings dd_ctx $(wings)
$scoreboard players set #hint_unit dd_ctx $(unit)
scoreboard players operation #hint_wings dd_ctx *= #hint_unit dd_ctx
scoreboard players operation #hint_size dd_ctx += #hint_wings dd_ctx
execute if score #hint_span dd_ctx matches 2.. run scoreboard players add #hint_kind dd_ctx 5
execute if score #hint_kind dd_ctx matches 8 if score #hint_wings dd_ctx matches 1.. run scoreboard players operation #hint_kind dd_ctx += #hint_unit dd_ctx
execute if score #hint_kind dd_ctx matches 4 if score #hint_span dd_ctx matches 1 if score #hint_wings dd_ctx matches 1.. run scoreboard players set #hint_kind dd_ctx 10
execute if score #hint_kind dd_ctx matches 10 if score #hint_span dd_ctx matches 1 run scoreboard players operation #hint_kind dd_ctx += #hint_unit dd_ctx
execute if score #hint_kind dd_ctx matches 4 if score #hint_span dd_ctx matches 1 if score #hint_wings dd_ctx matches 0 run scoreboard players set #hint_kind dd_ctx 13
execute if score #hint_kind dd_ctx matches 3 if score #hint_wings dd_ctx matches 1.. run scoreboard players operation #hint_kind dd_ctx += #hint_unit dd_ctx
execute if score #hint_span dd_ctx matches 2 if score #hint_kind dd_ctx matches 6 if score #hint_rank dd_ctx matches 17 run scoreboard players set #hint_kind dd_ctx 14
function doudizhu:hint/key
execute if score #hint_key dd_ctx < #hint_first dd_ctx run return 1
execute if score #hint_key dd_ctx > #hint_cursor dd_ctx if score #hint_key dd_ctx < #hint_next dd_ctx run return 1
return 0
