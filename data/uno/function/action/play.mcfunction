# 验证期间仅用临时分数，拒绝动作不改变控制器和手牌。
scoreboard players operation #u_say un_ctx = #say un_ctx
scoreboard players operation #u_chosen un_ctx = #color un_ctx

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

scoreboard players operation #u_pick un_ctx = @e[tag=un.actor,limit=1] un_pick
scoreboard players operation #u_drawn un_ctx = @s un_drawn
scoreboard players operation #u_drew un_ctx = @s un_drew
execute unless score #u_pick un_ctx matches 0..53 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 请先选择一张手牌。',color:'red'}]
execute unless score #u_pick un_ctx matches 0..53 run return fail
execute as @e[type=minecraft:marker,tag=un.cards] if score @s un_owner = #u_actor un_ctx if score @s un_card = #u_pick un_ctx unless entity @e[tag=un.selected] if score #u_drew un_ctx matches 0 run tag @s add un.selected
execute as @e[type=minecraft:marker,tag=un.cards] if score @s un_owner = #u_actor un_ctx if score @s un_card = #u_pick un_ctx if score @s un_idx = #u_drawn un_ctx if score #u_drew un_ctx matches 1 run tag @s add un.selected
execute unless entity @e[type=minecraft:marker,tag=un.selected,limit=1] run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 这张牌不属于你，或不是本回合刚摸的牌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=un.selected,limit=1] run return fail
scoreboard players operation #u_color un_ctx = @s un_color
scoreboard players operation #u_value un_ctx = @s un_value
scoreboard players set #u_valid un_ctx 0
execute if score @e[tag=un.selected,limit=1] un_color = #u_color un_ctx run scoreboard players set #u_valid un_ctx 1
execute if score @e[tag=un.selected,limit=1] un_value = #u_value un_ctx run scoreboard players set #u_valid un_ctx 1
execute if score #u_pick un_ctx matches 52..53 run scoreboard players set #u_valid un_ctx 1
execute if score #u_valid un_ctx matches 0 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 需匹配当前颜色、数字或功能符号。',color:'red'}]
execute if score #u_valid un_ctx matches 0 run return fail
execute if score #u_pick un_ctx matches 52..53 unless score #u_chosen un_ctx matches 0..3 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 请选择红、黄、绿或蓝。',color:'red'}]
execute if score #u_pick un_ctx matches 52..53 unless score #u_chosen un_ctx matches 0..3 run return fail
scoreboard players set #u_wildbad un_ctx 0
execute if score #u_pick un_ctx matches 53 as @e[type=minecraft:marker,tag=un.cards] if score @s un_owner = #u_actor un_ctx if score @s un_color = #u_color un_ctx run scoreboard players set #u_wildbad un_ctx 1
execute if score #u_pick un_ctx matches 53 if score #u_wildbad un_ctx matches 1 if score @s un_challenge matches 0 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 你仍有当前颜色牌，关闭质疑时不能打出 +4。',color:'red'}]
execute if score #u_pick un_ctx matches 53 if score #u_wildbad un_ctx matches 1 if score @s un_challenge matches 0 run return fail
function uno:action/commit_play
