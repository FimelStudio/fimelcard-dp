execute unless entity @s[tag=ab.player,tag=ab.turn] run return 0
# 施法和结束都只接受合法掉落，旧聊天链接不再生效。
execute unless entity @s[tag=ab.q_input] run scoreboard players set @s ab_action 0
execute unless score @s ab_action matches 1..9 run return 0
scoreboard players operation #ctx ab_ctx = @s ab_id
tag @a[tag=ab.actor] remove ab.actor
tag @s add ab.actor
execute if score @s ab_action matches 9 run execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=2}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:turn/end
execute if score @s ab_action matches 9 run tag @s remove ab.actor
execute if score @s ab_action matches 9 run scoreboard players set @s ab_action 0
execute if score @s ab_action matches 9 run return 0
execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=2}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:action/resolve
tag @s remove ab.actor
scoreboard players set @s ab_action 0
