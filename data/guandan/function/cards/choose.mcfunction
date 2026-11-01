# 不消耗牌：出牌生命周期在 choose 成功后自行提交。
scoreboard players set #ok gd_ctx 0
execute unless score #choice gd_ctx matches 0..999 run return 0
execute store result score #options gd_ctx run data get entity @s data.guandan.options
execute unless score #choice gd_ctx < #options gd_ctx run return 0
execute store result storage guandan:cards choice.index int 1 run scoreboard players get #choice gd_ctx
function guandan:cards/choose_index with storage guandan:cards choice
