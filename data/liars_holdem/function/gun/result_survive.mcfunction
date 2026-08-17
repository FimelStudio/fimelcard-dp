# 1至7发未击发属于空枪；8发全装仍未击发只可能是5%卡弹
scoreboard players set #gun_survive_kind lh_ctx 0
execute as @a[tag=lh.gun_target,scores={lh_bullets=8..}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set #gun_survive_kind lh_ctx 1
execute if score #gun_survive_kind lh_ctx matches 0 run function liars_holdem:transition/misfire
execute if score #gun_survive_kind lh_ctx matches 1 run function liars_holdem:transition/jam
function liars_holdem:sound/misfire
execute if score #gun_survive_kind lh_ctx matches 0 as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx run title @s title {text:'空枪！',color:'green',bold:true}
execute if score #gun_survive_kind lh_ctx matches 1 as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx run title @s title {text:'卡弹！',color:'yellow',bold:true}
execute if score #gun_survive_kind lh_ctx matches 0 as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{selector:'@a[tag=lh.gun_target,limit=1]',color:'yellow'},{text:' 遇到空枪，存活到下一局。',color:'green'}]
execute if score #gun_survive_kind lh_ctx matches 1 as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{selector:'@a[tag=lh.gun_target,limit=1]',color:'yellow'},{text:' 遇到卡弹，存活到下一局。',color:'green'}]
