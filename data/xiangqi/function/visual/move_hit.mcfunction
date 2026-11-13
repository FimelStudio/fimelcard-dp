# 执行位置继承桌心；只将本桌该棋子的命中区迁到已提交的终点。
$tp @s ~$(x) ~1.035 ~$(z)
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players set @s xq_covered 0
function xiangqi:visual/hit_shape
