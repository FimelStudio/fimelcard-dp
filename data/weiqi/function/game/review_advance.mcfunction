scoreboard players operation #review_auto go_ctx = @s go_autoplay
scoreboard players set @s go_state 5
execute store result score #frames go_ctx run data get entity @s data.weiqi.history
scoreboard players remove #frames go_ctx 1
execute if score @s go_review < #frames go_ctx run scoreboard players add @s go_review 1
execute if score @s go_review >= #frames go_ctx run scoreboard players set @s go_autoplay 0
# 自动复盘只是更新只读帧，不使已打开的暂停按钮每 0.75 秒失效。
execute unless score #review_auto go_ctx matches 1 run scoreboard players add @s go_epoch 1
function weiqi:game/review_render
