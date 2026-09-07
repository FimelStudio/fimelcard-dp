scoreboard players set @s cp_state 4
scoreboard players set @s cp_timer 100
function critical_point:input/clear_tools
function critical_point:player/mark_audience
tellraw @a[tag=cp.audience] [{text:'════════ 村民阵营获胜 ════════',color:'green',bold:true}]
tellraw @a[tag=cp.audience] [{text:'狼人是：',color:'gray'},{selector:'@a[tag=cp.wolf,tag=cp.audience,limit=1]',color:'dark_red',bold:true}]
title @a[tag=cp.audience] title {text:'村民获胜',color:'green',bold:true}
tag @a[tag=cp.audience] remove cp.audience
