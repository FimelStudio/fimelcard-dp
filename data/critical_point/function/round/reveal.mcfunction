scoreboard players operation #ctx cp_ctx = @s cp_id
scoreboard players set #sum cp_ctx 0
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players operation #sum cp_ctx += @s cp_play
# 只有安全轮在聊天栏公开个人点数；不再在桌面生成实体牌。
function critical_point:player/mark_audience
execute unless score #sum cp_ctx > @s cp_threshold run tellraw @a[tag=cp.audience] [{text:'════ 同时翻牌 ════',color:'gold',bold:true}]
execute unless score #sum cp_ctx > @s cp_threshold as @a[tag=cp.audience] run tellraw @a[tag=cp.audience] [{selector:'@s',color:'white'},{text:'：',color:'gray'},{score:{name:'@s',objective:'cp_play'},color:'gold',bold:true},{text:' 点',color:'gray'}]
execute if score #sum cp_ctx > @s cp_threshold run tellraw @a[tag=cp.audience] [{text:'[临界点] ',color:'red',bold:true},{text:'本轮触发危机，各玩家出的具体点数不予公开。',color:'yellow'}]
tellraw @a[tag=cp.audience] [{text:'本轮总点数：',color:'gray'},{score:{name:'#sum',objective:'cp_ctx'},color:'gold',bold:true},{text:'　安全线：',color:'gray'},{score:{name:'@s',objective:'cp_threshold'},color:'aqua'}]
execute if score #sum cp_ctx > @s cp_threshold run tellraw @a[tag=cp.audience] [{text:'总点数越过安全线，危机发生！立即进入最终投票。',color:'red',bold:true}]
tag @a[tag=cp.audience] remove cp.audience
execute if score #sum cp_ctx > @s cp_threshold run function critical_point:vote/start
execute if score #sum cp_ctx > @s cp_threshold run return 1
function critical_point:player/mark_audience
tellraw @a[tag=cp.audience] [{text:'本轮安全。',color:'green',bold:true}]
execute if score @s cp_round matches 5 run tellraw @a[tag=cp.audience] [{text:'五轮全部安全，村民完成任务。',color:'green'}]
tag @a[tag=cp.audience] remove cp.audience
execute if score @s cp_round matches 5 run function critical_point:game/finish_villagers
execute if score @s cp_round matches 5 run return 1
scoreboard players set @s cp_state 2
function critical_point:input/give_discussion_tools
