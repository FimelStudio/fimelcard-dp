function guandan:cards/context
scoreboard players set #hint_cursor gd_ctx 0
scoreboard players operation #hint_cursor gd_ctx = @s gd_hint
scoreboard players set #hint_first gd_ctx 2147483647
scoreboard players set #hint_next gd_ctx 2147483647
scoreboard players set #probe_rank gd_ctx 0
scoreboard players set #probe_pair_rank gd_ctx 0
scoreboard players set #probe_first gd_ctx 0
scoreboard players set #probe_end gd_ctx 0
scoreboard players set #probe_copies gd_ctx 0
scoreboard players set #probe_suit gd_ctx 0
scoreboard players set #probe_hint gd_ctx 1
function guandan:autopass/probe
scoreboard players set #probe_hint gd_ctx 0
execute if score #hint_first gd_ctx matches 2147483647 run return 0
execute if score #hint_next gd_ctx matches 2147483647 run data modify storage guandan:hint next set from storage guandan:hint first
execute if score #hint_next gd_ctx matches 2147483647 run scoreboard players operation #hint_next gd_ctx = #hint_first gd_ctx
execute store result storage guandan:hint next.seat int 1 run scoreboard players get #actor gd_ctx
scoreboard players operation @s gd_hint = #hint_next gd_ctx
tag @e[tag=gd.hint_saved] remove gd.hint_saved
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #actor gd_ctx run tag @s add gd.hint_saved
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players set @s gd_sel 0
function guandan:hint/apply with storage guandan:hint next
function guandan:game/select_context
function guandan:cards/analyze
function guandan:hint/find_option
execute if score #hint_choice gd_ctx matches 0.. run data modify entity @s data.guandan.hint_label set from storage guandan:hint option.label
execute unless score #hint_choice gd_ctx matches 0.. run function guandan:hint/restore
tag @e[tag=gd.hint_saved] remove gd.hint_saved
