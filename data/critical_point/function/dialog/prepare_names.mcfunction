# 只列本桌其他参与者，支持实际座号1至8；名字先解析为静态文本。
scoreboard players operation #ctx cp_ctx = @s cp_id
scoreboard players operation #viewer_seat cp_ctx = @s cp_seat
data modify storage critical_point:dialog ui set value {type:"minecraft:multi_action",title:{text:"临界点 · 最终投票",color:"red",bold:true},body:[{type:"minecraft:plain_message",width:440,contents:{text:"选择你认为是狼人的玩家。提交后不能修改，不可投自己。",color:"gray"}}],columns:2,actions:[],pause:false,can_close_with_escape:false}
execute as @a[tag=cp.player,scores={cp_seat=1}] if score @s cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat cp_ctx at @s run function critical_point:dialog/append_option
execute as @a[tag=cp.player,scores={cp_seat=2}] if score @s cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat cp_ctx at @s run function critical_point:dialog/append_option
execute as @a[tag=cp.player,scores={cp_seat=3}] if score @s cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat cp_ctx at @s run function critical_point:dialog/append_option
execute as @a[tag=cp.player,scores={cp_seat=4}] if score @s cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat cp_ctx at @s run function critical_point:dialog/append_option
execute as @a[tag=cp.player,scores={cp_seat=5}] if score @s cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat cp_ctx at @s run function critical_point:dialog/append_option
execute as @a[tag=cp.player,scores={cp_seat=6}] if score @s cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat cp_ctx at @s run function critical_point:dialog/append_option
execute as @a[tag=cp.player,scores={cp_seat=7}] if score @s cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat cp_ctx at @s run function critical_point:dialog/append_option
execute as @a[tag=cp.player,scores={cp_seat=8}] if score @s cp_id = #ctx cp_ctx unless score @s cp_seat = #viewer_seat cp_ctx at @s run function critical_point:dialog/append_option

