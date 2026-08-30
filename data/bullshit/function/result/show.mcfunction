# 在清理身份标签前，先把老实人ID解析成静态文本并展示在桌心。
scoreboard players operation #ctx bw_ctx = @s bw_id
data modify storage bullshit:result honest set value {text:'未知',color:'gray'}
execute as @a[tag=bw.honest] if score @s bw_id = #ctx bw_ctx at @s run function hanabi:name/resolve
execute as @a[tag=bw.honest] if score @s bw_id = #ctx bw_ctx run data modify storage bullshit:result honest set from storage hanabi:name resolved
data modify storage bullshit:result text set value [{text:'本轮老实人：',color:'yellow',bold:true}]
data modify storage bullshit:result text append from storage bullshit:result honest
execute as @e[type=minecraft:text_display,tag=bw.result] if score @s bw_id = #ctx bw_ctx run kill @s
summon minecraft:text_display ~ ~2.10 ~ {Tags:['bw.result','bw.game_entity'],text:{text:''},billboard:'vertical',alignment:'center',line_width:200,background:0,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15}}
tag @e[type=minecraft:text_display,tag=bw.result,distance=..2,sort=nearest,limit=1] add bw.new_result
scoreboard players operation @e[type=minecraft:text_display,tag=bw.new_result,distance=..2,limit=1] bw_id = #ctx bw_ctx
data modify entity @e[type=minecraft:text_display,tag=bw.new_result,distance=..2,limit=1] text set from storage bullshit:result text
tag @e[tag=bw.new_result] remove bw.new_result
