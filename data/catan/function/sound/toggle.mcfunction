execute unless score @s ct_game matches 21 run return 0
scoreboard players operation #sound_music ca_ctx = @s ca_music
scoreboard players set @s ca_music 1
execute if score #sound_music ca_ctx matches 1 run scoreboard players set @s ca_music 0
execute if score @s ca_music matches 0 run return run function catan:sound/stop
function catan:sound/start
