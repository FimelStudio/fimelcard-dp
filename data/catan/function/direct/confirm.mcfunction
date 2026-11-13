execute if score #code ca_ctx matches 352..354 run return run function catan:direct/submit
execute if score #code ca_ctx matches 401..404 run return run function catan:direct/submit
execute if score #code ca_ctx matches 23 run function catan:direct/buy_check
execute if score #code ca_ctx matches 29 run function catan:direct/main_guard
execute if score #code ca_ctx matches 23 unless score #direct_ready ca_ctx matches 1 run return 0
execute if score #code ca_ctx matches 29 unless score #direct_ready ca_ctx matches 1 run return 0
execute if score #code ca_ctx matches 23 run return run function catan:direct/submit
execute if score #code ca_ctx matches 29 run return run function catan:direct/submit
execute if score @s ca_confirm = #code ca_ctx if score @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch run return run function catan:direct/submit
scoreboard players operation @s ca_confirm = #code ca_ctx
scoreboard players operation @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch
function catan:hud/notice {"text":{"text":"再次按Q确认；取消选项可撤销。","color":"aqua"}}
