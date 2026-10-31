scoreboard players operation @s gm_seen = @e[tag=gm.current,limit=1] gm_epoch
scoreboard players operation @s gm_ui_load = #ui_load gm_ctx
scoreboard players operation #ui_base gm_ctx = @s gm_seen
scoreboard players set #ui_100 gm_ctx 100
scoreboard players operation #ui_base gm_ctx *= #ui_100 gm_ctx
data modify storage gomoku:ui buttons set value []
scoreboard players set @s gm_action 0
scoreboard players enable @s gm_action
