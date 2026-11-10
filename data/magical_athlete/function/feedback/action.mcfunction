scoreboard players set #feedback_epoch ma_ctx -1
execute store result score #feedback_epoch ma_ctx run data get storage magical_athlete:engine request.epoch
scoreboard players set #feedback_logged ma_ctx -2
execute store result score #feedback_logged ma_ctx run data get entity @s data.ma_feedback.action_epoch
execute if score #feedback_epoch ma_ctx = #feedback_logged ma_ctx run return 0
execute store result entity @s data.ma_feedback.action_epoch int 1 run scoreboard players get #feedback_epoch ma_ctx
data modify entity @s data.ma_feedback.last_actor set from storage magical_athlete:engine request.actor
execute if data storage magical_athlete:engine request{code:1} run function magical_athlete:feedback/draft with storage magical_athlete:engine request
execute if data storage magical_athlete:engine request{code:2} run function magical_athlete:feedback/lineup with storage magical_athlete:engine request
execute if data storage magical_athlete:engine request{code:4} run function magical_athlete:feedback/choice with storage magical_athlete:engine request
