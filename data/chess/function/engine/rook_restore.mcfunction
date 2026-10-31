$scoreboard players set #b$(rook_to) ch_ctx 0
$scoreboard players operation #b$(rook_from) ch_ctx = #side ch_ctx
$scoreboard players operation #b$(rook_from) ch_ctx *= #four ch_ctx
