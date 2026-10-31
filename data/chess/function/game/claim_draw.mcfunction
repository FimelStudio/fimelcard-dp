function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute unless score @e[tag=ch.actor,limit=1] ch_side = @s ch_turn run return 0
function chess:engine/evaluate
execute if score @s ch_result matches 1..3 run return run function chess:game/finish
execute if score @s ch_repetition matches 3.. run scoreboard players set @s ch_reason 9
execute if score @s ch_half matches 100.. run scoreboard players set @s ch_reason 10
execute unless score @s ch_reason matches 9..10 run tellraw @a[tag=ch.actor] {"text": "[国际象棋] 当前局面尚未满足三次重复或五十回合认领条件。", "color": "red"}
execute unless score @s ch_reason matches 9..10 run return 0
scoreboard players set @s ch_result 3
function chess:game/finish
