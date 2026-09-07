scoreboard players set @s bw_state 2
scoreboard players set @s bw_timer 0
scoreboard players operation #ctx bw_ctx = @s bw_id
execute as @a[tag=bw.player,scores={bw_role=1}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.smart
execute as @a[tag=bw.player,scores={bw_role=2}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.honest
execute as @a[tag=bw.player,scores={bw_role=3}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.bluffer
tellraw @a[tag=bw.player] [{text:'════ 本轮身份公布 ════',color:'yellow',bold:true}]
tellraw @a[tag=bw.player] [{text:'[瞎掰王] ',color:'yellow'},{selector:'@a[tag=bw.smart,limit=1]',color:'gold'},{text:' 是本轮大聪明。',color:'gold'}]
tellraw @a[tag=bw.honest] [{text:'[瞎掰王] ',color:'yellow'},{text:'你是老实人；请牢记私密答案，在问答中如实解释。',color:'green'}]
tellraw @a[tag=bw.bluffer] [{text:'[瞎掰王] ',color:'yellow'},{text:'你是瞎掰人；请用关键词编出可信的解释。',color:'light_purple'}]
function bullshit:question/show
execute as @a[tag=bw.smart] if score @s bw_id = #ctx bw_ctx run function bullshit:input/give_tools
tellraw @a[tag=bw.player] [{text:'[瞎掰王] ',color:'yellow'},{text:'阅读结束，开始问答。大聪明可在准备好后Q键使用“结束问答并指认”。',color:'gray'}]
