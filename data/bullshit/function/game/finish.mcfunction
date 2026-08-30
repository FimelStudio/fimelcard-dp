scoreboard players operation #ctx bw_ctx = @s bw_id
tellraw @a[tag=bw.player] [{text:'════ 瞎掰王结算 ════',color:'yellow',bold:true}]
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tellraw @a[tag=bw.player] [{selector:'@s',color:'gold'},{text:'：',color:'gray'},{score:{name:'@s',objective:'bw_score'},color:'yellow'},{text:' 分',color:'gray'}]
function bullshit:result/show
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run function bullshit:player/clear_state
# 保留控制器驱动结算面板，6秒后才恢复大厅。
scoreboard players set @s bw_state 3
scoreboard players set @s bw_timer 120
