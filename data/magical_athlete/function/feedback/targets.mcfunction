$data modify storage magical_athlete:feedback target_options set value $(options)
scoreboard players set #target_kind ma_ctx 0
execute if data entity @s data.magical_athlete.pending{kind:"hypnotist"} run scoreboard players set #target_kind ma_ctx 1
execute if data entity @s data.magical_athlete.pending{kind:"flip"} run scoreboard players set #target_kind ma_ctx 1
execute if data entity @s data.magical_athlete.pending{kind:"duel"} run scoreboard players set #target_kind ma_ctx 1
execute if data entity @s data.magical_athlete.pending{kind:"mastermind"} run scoreboard players set #target_kind ma_ctx 1
execute if data entity @s data.magical_athlete.pending{kind:"copycat"} run scoreboard players set #target_kind ma_ctx 1
execute if score #target_kind ma_ctx matches 1 as @e[tag=ma.racer] if score @s ct_id = #table ma_ctx at @s run function magical_athlete:feedback/racer_target
execute if data entity @s data.magical_athlete.pending{kind:"thirdwheel"} as @e[tag=ma.hit,scores={ma_dtype=3}] if score @s ct_id = #table ma_ctx at @s run function magical_athlete:feedback/cell_target
