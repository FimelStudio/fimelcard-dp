scoreboard players set @s bw_state 2
scoreboard players set @s bw_timer 0
scoreboard players operation #ctx bw_ctx = @s bw_id
execute as @a[tag=bw.player,scores={bw_role=1}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.smart
execute as @a[tag=bw.player,scores={bw_role=2}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.honest
execute as @a[tag=bw.player,scores={bw_role=3}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.bluffer
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run function bullshit:question/hide_answer
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tellraw @s [{text:'════ 本轮身份公布 ════',color:'yellow',bold:true}]
tag @a[tag=bw.announce] remove bw.announce
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s add bw.announce
execute as @a[tag=bw.smart] if score @s bw_id = #ctx bw_ctx run tellraw @a[tag=bw.announce] [{text:'[瞎掰王] ',color:'yellow'},{selector:'@s',color:'gold'},{text:' 是本轮大聪明。',color:'gold'}]
tag @a[tag=bw.announce] remove bw.announce
execute as @a[tag=bw.honest] if score @s bw_id = #ctx bw_ctx run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'你是老实人；答案窗口已关闭，请凭记忆在问答中如实解释。',color:'green'}]
execute as @a[tag=bw.bluffer] if score @s bw_id = #ctx bw_ctx run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'你是瞎掰人；请用关键词编出可信的解释。',color:'light_purple'}]
function bullshit:question/show
execute as @a[tag=bw.smart] if score @s bw_id = #ctx bw_ctx run function bullshit:input/give_tools
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'阅读结束，开始问答。大聪明可在准备好后Q键使用“结束问答并指认”。',color:'gray'}]
