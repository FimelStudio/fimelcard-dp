# 逢人配单出时只能算级牌。
execute if score #kind gd_ctx matches 1 if score #probe_natural gd_ctx matches 0 unless score #probe_rank gd_ctx = #level gd_ctx run return 0
function guandan:hint/key
execute if score #hint_key gd_ctx < #hint_first gd_ctx run function guandan:hint/save {slot:"first"}
execute if score #hint_key gd_ctx > #hint_cursor gd_ctx if score #hint_key gd_ctx < #hint_next gd_ctx run function guandan:hint/save {slot:"next"}
