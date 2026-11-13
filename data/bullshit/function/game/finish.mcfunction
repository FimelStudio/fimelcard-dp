function bullshit:player/mark_audience
scoreboard players operation #ctx bw_ctx = @s bw_id
tellraw @a[tag=bw.audience] [{text:'════ 瞎掰王结算 ════',color:'yellow',bold:true}]
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tellraw @a[tag=bw.audience] [{selector:'@s',color:'gold'},{text:'：',color:'gray'},{score:{name:'@s',objective:'bw_score'},color:'yellow'},{text:' 分',color:'gray'}]
scoreboard players set #best bw_ctx -2147483648
execute as @a[tag=bw.audience] run scoreboard players operation #best bw_ctx > @s bw_score
tag @a[tag=ct.final_winner] remove ct.final_winner
execute as @a[tag=bw.audience] if score @s bw_score = #best bw_ctx run tag @s add ct.final_winner
execute if entity @a[tag=ct.final_winner] run function cardtable:game/result/title {audience:"@a[tag=bw.audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:{selector:"@a[tag=ct.final_winner]"}}
tag @a[tag=ct.final_winner] remove ct.final_winner
tag @a[tag=bw.audience] remove bw.audience
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run function bullshit:player/clear_state
# 分数已经写入聊天栏，立即恢复大厅，避免依赖中间结算状态的后续tick。
function bullshit:game/return_lobby
