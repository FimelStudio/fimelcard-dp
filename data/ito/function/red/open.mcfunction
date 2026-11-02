function ito:input/number_cards
execute if score @s it_done matches 1 run return 0
scoreboard players set #missing it_ctx 0
execute as @e[tag=it.cards,scores={it_owner=1..8,it_used=0},nbt={data:{description:""}}] run scoreboard players add #missing it_ctx 1
execute if score #missing it_ctx matches 1.. run tellraw @s {text:"请先让所有人提交描述，再选择搭档或单飞。",color:"yellow"}
execute if score #missing it_ctx matches 1.. run return 0
scoreboard players add #window_serial it_ctx 1
execute if score #window_serial it_ctx matches 10000001.. run scoreboard players set #window_serial it_ctx 1
scoreboard players operation @s it_window = #window_serial it_ctx
scoreboard players operation @s it_win_epoch = @e[tag=it.current,limit=1] it_epoch
scoreboard players operation #base it_ctx = @s it_window
scoreboard players operation #base it_ctx *= #hundred it_ctx
data modify storage ito:ui dialog set value {type:"minecraft:multi_action",title:{text:"命悬一线 · 红线配对",color:"red"},body:[{type:"minecraft:plain_message",width:440,contents:{text:"选择搭档；双方互选才亮牌。可以重新选择。单飞立即亮牌且本轮0分。对方的数字不会提前公开。",color:"gray"}}],actions:[],columns:2,pause:false,after_action:"close"}
data modify storage ito:ui dialog.body append value {type:"minecraft:plain_message",contents:{text:"你的累计分：",color:"gold",extra:[{score:{name:"@s",objective:"it_total"}}]}}
scoreboard players operation #self it_ctx = @s it_seat
execute as @a[tag=it.audience,scores={it_done=0}] unless score @s it_seat = #self it_ctx run function ito:red/button
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players add #button it_ctx 40
data modify storage ito:ui label set value "单飞亮牌（本轮0分）"
function ito:ui/button
function ito:ui/show with storage ito:ui
