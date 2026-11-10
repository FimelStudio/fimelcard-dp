execute if score @s ca_step matches 0 run return run function catan:direct/plenty_first
scoreboard players operation @s ca_b = #resource ca_ctx
scoreboard players set @s ca_step 0
function catan:hud/notice {"text":{"text":"两张资源已选好，可以同种；使用“确认丰收”按Q一次提交。","color":"aqua"}}
