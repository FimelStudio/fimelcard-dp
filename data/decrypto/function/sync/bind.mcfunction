scoreboard players set #sync_ok dc_ctx 0
execute unless entity @s[tag=dc.player,tag=ct.player] run return 0
execute if score @s ct_paused matches 1 run return 0
execute unless score @s dc_id = @s ct_id run return 0
scoreboard players operation #ctx dc_ctx = @s dc_id
tag @e[tag=dc.sync_controller] remove dc.sync_controller
execute as @e[tag=dc.controller,scores={dc_sync=1,dc_state=2..5}] if score @s dc_id = #ctx dc_ctx run tag @s add dc.sync_controller
execute if entity @e[tag=dc.sync_controller,limit=1] run scoreboard players set #sync_ok dc_ctx 1
