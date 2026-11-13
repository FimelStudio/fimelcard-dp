scoreboard objectives add ca_music dummy
scoreboard objectives add ca_bgm dummy
scoreboard objectives add ca_bgm_on dummy
scoreboard objectives add ca_bgm_table dummy
# ca_ctx belongs to the game installer, not to this module.
execute as @a run function catan:sound/stop_player
