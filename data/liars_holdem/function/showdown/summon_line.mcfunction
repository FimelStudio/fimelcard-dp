# 四人桌和八人桌共用桌心锚点与显示大小。直接初始化新实体，高行不受距离筛选限制。
scoreboard players operation #display_owner lh_ctx = @s lh_id
$execute positioned ~ ~$(y) ~ summon minecraft:text_display run function liars_holdem:showdown/init_line with storage liars_holdem:showdown spawn
