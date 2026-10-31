function uno:system/context
execute unless entity @s[type=minecraft:marker,tag=un.controller] run return fail
execute unless score @s ct_game matches 11 run return fail
execute unless score @s ct_state matches 1 run return fail
execute unless entity @e[tag=un.actor,tag=un.player,tag=ct.player,tag=un.audience,limit=1] run return fail
scoreboard players set #u_actors un_ctx 0
execute as @e[tag=un.actor] run scoreboard players add #u_actors un_ctx 1
execute unless score #u_actors un_ctx matches 1 run return fail
scoreboard players operation #u_actor un_ctx = @e[tag=un.actor,tag=un.audience,limit=1] un_seat

execute unless score @s un_state matches 2 run return fail
execute unless score #u_actor un_ctx = @s un_turn run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 现在不是你的回合。',color:'red'}]
execute unless score #u_actor un_ctx = @s un_turn run return fail

execute unless score @s un_drew matches 1 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 请先摸一张牌，不能直接跳过。',color:'red'}]
execute unless score @s un_drew matches 1 run return fail
function uno:action/end_turn
