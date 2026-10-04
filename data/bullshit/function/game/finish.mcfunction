function bullshit:player/mark_audience
scoreboard players operation #ctx bw_ctx = @s bw_id
tellraw @a[tag=bw.audience] [{text:'════ 瞎掰王结算 ════',color:'yellow',bold:true}]
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tellraw @a[tag=bw.audience] [{selector:'@s',color:'gold'},{text:'：',color:'gray'},{score:{name:'@s',objective:'bw_score'},color:'yellow'},{text:' 分',color:'gray'}]
tag @a[tag=bw.audience] remove bw.audience
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run function bullshit:player/clear_state
# 分数已经写入聊天栏，立即恢复大厅，避免依赖中间结算状态的后续tick。
function bullshit:game/return_lobby
