scoreboard players operation #action bw_ctx = @s bw_action
scoreboard players set @s bw_action 0
execute unless entity @s[tag=bw.smart] run return fail
scoreboard players operation #ctx bw_ctx = @s bw_id
execute unless entity @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=2}] if score @s bw_id = #ctx bw_ctx run return fail
execute if score #action bw_ctx matches 401..404 run function bullshit:action/call
execute if score #action bw_ctx matches 301..304 run function bullshit:action/guess
