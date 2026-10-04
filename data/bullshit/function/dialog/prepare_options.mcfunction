# 普通玩家用trigger提交；只列本桌其他玩家，名字固化为静态组件。
scoreboard players operation #ctx bw_ctx = @s bw_id
scoreboard players operation #caller_seat bw_ctx = @s bw_seat
data modify storage bullshit:dialog ui set value {type:"minecraft:multi_action",title:{text:"选择玩家",color:"yellow"},columns:2,actions:[],pause:false,exit_action:{label:{text:"取消"}}}
execute as @a[tag=bw.player,scores={bw_seat=1}] if score @s bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat bw_ctx at @s run function bullshit:dialog/append_option
execute as @a[tag=bw.player,scores={bw_seat=2}] if score @s bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat bw_ctx at @s run function bullshit:dialog/append_option
execute as @a[tag=bw.player,scores={bw_seat=3}] if score @s bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat bw_ctx at @s run function bullshit:dialog/append_option
execute as @a[tag=bw.player,scores={bw_seat=4}] if score @s bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat bw_ctx at @s run function bullshit:dialog/append_option
execute as @a[tag=bw.player,scores={bw_seat=5}] if score @s bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat bw_ctx at @s run function bullshit:dialog/append_option
execute as @a[tag=bw.player,scores={bw_seat=6}] if score @s bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat bw_ctx at @s run function bullshit:dialog/append_option
execute as @a[tag=bw.player,scores={bw_seat=7}] if score @s bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat bw_ctx at @s run function bullshit:dialog/append_option
execute as @a[tag=bw.player,scores={bw_seat=8}] if score @s bw_id = #ctx bw_ctx unless score @s bw_seat = #caller_seat bw_ctx at @s run function bullshit:dialog/append_option
