data modify storage guandan:bot need set from entity @s data.guandan.bot.todo[0].ranks
data remove entity @s data.guandan.bot.todo[0]
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players set @s gd_sel 0
scoreboard players set #bot_valid gd_ctx 1
function guandan:bot/select_ranks
execute unless score #bot_valid gd_ctx matches 1 run return 0
function guandan:game/select_context
function guandan:cards/analyze
scoreboard players set #bot_choice gd_ctx 0
function guandan:bot/options
