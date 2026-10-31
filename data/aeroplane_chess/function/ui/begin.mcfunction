scoreboard players operation @s ac_seen = @e[tag=ac.current,limit=1] ac_epoch
scoreboard players operation @s ac_ui_load = #ui_load ac_ctx
scoreboard players operation #ui_base ac_ctx = @s ac_seen
scoreboard players operation #ui_base ac_ctx *= #hundred ac_ctx
scoreboard players set @s ac_action 0
scoreboard players enable @s ac_action
data modify storage aeroplane_chess:ui buttons set value []
