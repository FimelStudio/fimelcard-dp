scoreboard players remove @s dc_timer 1
execute if score @s dc_timer matches 0 if score @s dc_state matches 2 run return run function decrypto:timer/encoding_timeout
execute if score @s dc_timer matches 0 if score @s dc_state matches 5 run return run function decrypto:timer/guess_timeout
scoreboard players operation #seconds_left dc_ctx = @s dc_timer
scoreboard players add #seconds_left dc_ctx 19
scoreboard players operation #seconds_left dc_ctx /= #ticks_per_second dc_ctx
execute if score @s dc_seconds = #seconds_left dc_ctx run return 0
scoreboard players operation @s dc_seconds = #seconds_left dc_ctx
function decrypto:title/render_all
