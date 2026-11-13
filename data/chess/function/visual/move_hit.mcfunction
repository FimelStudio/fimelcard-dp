# 执行位置继承桌心；只将本桌该棋子的命中区迁到已提交的终点。
$tp @s ~$(x) ~1.035 ~$(z)
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
scoreboard players operation @s ch_piece = #vis_piece ch_ctx
function chess:visual/hit_shape
