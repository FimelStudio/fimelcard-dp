scoreboard players operation @s ch_seen = @e[tag=ch.current,limit=1] ch_epoch
scoreboard players operation @s ch_ui_load = #ui_load ch_ctx
scoreboard players operation #ui_base ch_ctx = @s ch_seen
scoreboard players set #ui_100 ch_ctx 100
scoreboard players operation #ui_base ch_ctx *= #ui_100 ch_ctx
data modify storage chess:ui buttons set value []
scoreboard players set @s ch_action 0
scoreboard players enable @s ch_action
