execute unless score #bot_choice gd_ctx < #options gd_ctx run return 0
scoreboard players operation #choice gd_ctx = #bot_choice gd_ctx
function guandan:cards/choose
execute if score #ok gd_ctx matches 1 run function guandan:bot/evaluate
scoreboard players add #bot_choice gd_ctx 1
function guandan:bot/options
