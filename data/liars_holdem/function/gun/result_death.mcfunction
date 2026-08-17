# Animated Java接入点：当前仅用文字、粒子和音效表示击发
function liars_holdem:transition/bang
# 每位本桌玩家各接收一次效果，避免相邻牌桌串音或串粒子
function liars_holdem:sound/gunshot
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @a[tag=lh.gun_target,limit=1] run particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1 force @s
title @a[tag=lh.gun_target,limit=1] title {text:'击发！',color:'red',bold:true}
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{selector:'@a[tag=lh.gun_target,limit=1]',color:'yellow'},{text:' 的左轮击发，已被淘汰。',color:'red'}]
function liars_holdem:gun/eliminate_seat
