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

execute if score @s un_drew matches 1 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 本回合已经摸过牌，只能打刚摸的牌或结束回合。',color:'red'}]
execute if score @s un_drew matches 1 run return fail
scoreboard players operation #seat un_ctx = #u_actor un_ctx
scoreboard players set #amount un_ctx 1
function uno:deck/draw
scoreboard players set @e[tag=un.actor,limit=1] un_pick -1
execute if score #draw_idx un_ctx matches 0 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 当前没有可摸的牌，回合结束。',color:'yellow'}]
execute if score #draw_idx un_ctx matches 0 run return run function uno:action/end_turn
scoreboard players operation @s un_drawn = #draw_idx un_ctx
scoreboard players set @s un_drew 1
scoreboard players operation #u_color un_ctx = @s un_color
scoreboard players operation #u_value un_ctx = @s un_value
scoreboard players set #u_valid un_ctx 0
execute if score @e[tag=un.selected,limit=1] un_color = #u_color un_ctx run scoreboard players set #u_valid un_ctx 1
execute if score @e[tag=un.selected,limit=1] un_value = #u_value un_ctx run scoreboard players set #u_valid un_ctx 1
execute if score @e[tag=un.selected,limit=1] un_card matches 52..53 run scoreboard players set #u_valid un_ctx 1
# 关闭质疑时，刚摸的非法 +4 也不能打出，直接结束回合。
scoreboard players set #u_hascolor un_ctx 0
execute as @e[type=minecraft:marker,tag=un.cards] if score @s un_owner = #u_actor un_ctx if score @s un_color = #u_color un_ctx run scoreboard players set #u_hascolor un_ctx 1
execute if score @e[tag=un.selected,limit=1] un_card matches 53 if score @s un_challenge matches 0 if score #u_hascolor un_ctx matches 1 run scoreboard players set #u_valid un_ctx 0
execute if score #u_valid un_ctx matches 0 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 摸到的牌不能出，回合结束。',color:'yellow'}]
execute if score #u_valid un_ctx matches 0 run return run function uno:action/end_turn
scoreboard players operation @e[tag=un.actor,limit=1] un_pick = @e[tag=un.selected,limit=1] un_card
tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 刚摸的牌可以出。按 Q 选择打出它或结束回合。',color:'yellow'}]
function uno:system/advance
