execute if score @s ca_confirm = #code ca_ctx if score @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch run return run function catan:direct/submit
scoreboard players operation @s ca_confirm = #code ca_ctx
scoreboard players operation @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch
function catan:hud/notice {"text":{"text":"再次按Q确认；取消选项可撤销。","color":"aqua"}}
