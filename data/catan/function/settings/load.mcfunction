# ca_ctx is installed by catan:load before this hook.
scoreboard players add #settings_load ca_ctx 1
execute as @a run function catan:settings/clear_session
