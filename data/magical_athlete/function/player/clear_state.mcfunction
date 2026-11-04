function magical_athlete:sound/stop_player
clear @s *[minecraft:custom_data~{magical_athlete:{tool:1b}}]
function magical_athlete:settings/clear_session
dialog clear @s
scoreboard players reset @s ma_nonce
scoreboard players reset @s ma_action
scoreboard players reset @s ma_drop
scoreboard players reset @s ma_panel
scoreboard players reset @s ma_target
scoreboard players reset @s ma_table
scoreboard players reset @s ma_seat
scoreboard players reset @s ma_side
scoreboard players reset @s ma_seen
scoreboard players reset @s ma_ui_load
scoreboard players reset @s ma_ui_table
scoreboard players reset @s ma_ui_seat
tag @s remove ma.player
tag @s remove ma.audience
tag @s remove ma.actor
tag @s remove ma.sound_audience
