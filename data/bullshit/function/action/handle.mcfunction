scoreboard players operation #action bw_ctx = @s bw_action
scoreboard players set @s bw_action 0
execute unless entity @s[tag=bw.player,tag=bw.smart] run return fail
execute unless score @s ct_id = @s bw_id run return fail
scoreboard players operation #ctx bw_ctx = @s bw_id
scoreboard players set #valid bw_ctx 0
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=2}] if score @s bw_id = #ctx bw_ctx run scoreboard players set #valid bw_ctx 1
execute unless score #valid bw_ctx matches 1 run return fail
execute if score #action bw_ctx matches 401..408 run function bullshit:action/call
execute if score #action bw_ctx matches 301..308 run function bullshit:action/guess
