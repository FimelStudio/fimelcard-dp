function uno:system/context
execute unless entity @s[type=minecraft:marker,tag=un.controller] run return fail
execute unless score @s ct_game matches 11 run return fail
execute unless score @s ct_state matches 1 run return fail
execute unless entity @e[tag=un.actor,tag=un.player,tag=ct.player,tag=un.audience,limit=1] run return fail
scoreboard players set #u_actors un_ctx 0
execute as @e[tag=un.actor] run scoreboard players add #u_actors un_ctx 1
execute unless score #u_actors un_ctx matches 1 run return fail
scoreboard players operation #u_actor un_ctx = @e[tag=un.actor,tag=un.audience,limit=1] un_seat

execute unless score @s un_state matches 4 run return fail
execute unless score #u_actor un_ctx = @s un_challenger run return fail

execute if score @s un_wildbad matches 1 run return run function uno:action/challenge_success
scoreboard players operation #seat un_ctx = @s un_challenger
scoreboard players set #amount un_ctx 6
function uno:deck/draw
tellraw @a[tag=un.audience] [{text:'[UNO] 质疑失败：+4 合法。质疑者摸六张并跳过回合。',color:'yellow'}]
scoreboard players operation @s un_turn = @s un_challenger
function uno:round/step
execute if score @s un_winner matches 1..8 run return run function uno:round/win
function uno:round/turn_begin
