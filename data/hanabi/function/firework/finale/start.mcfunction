# 当前执行者为花火控制器，位置为牌桌中心。
# 得分分档只在结算事件执行一次，不加入 tick 扫描。

scoreboard players set #finale_tier hb_ctx 0
execute if score @s hb_score matches 1..5 run scoreboard players set #finale_tier hb_ctx 1
execute if score @s hb_score matches 6..10 run scoreboard players set #finale_tier hb_ctx 2
execute if score @s hb_score matches 11..15 run scoreboard players set #finale_tier hb_ctx 3
execute if score @s hb_score matches 16..20 run scoreboard players set #finale_tier hb_ctx 4
execute if score @s hb_score matches 21..24 run scoreboard players set #finale_tier hb_ctx 5
execute if score @s hb_score matches 25..29 run scoreboard players set #finale_tier hb_ctx 6
execute if score @s hb_score matches 30 run scoreboard players set #finale_tier hb_ctx 7

# 默认参数对应最低分档；更高档位逐步增加扩散速度、持续时间、踪迹和闪烁。
data modify storage hanabi:firework finale set value {colors:[],tier:0,base_shape:0,grand_shape:0,trail:false,twinkle:false,v:0.25d,g:0.025d,t0:10,t1:17,grand_life:40}
execute store result storage hanabi:firework finale.tier int 1 run scoreboard players get #finale_tier hb_ctx
execute if score #finale_tier hb_ctx matches 2 run data modify storage hanabi:firework finale merge value {base_shape:4,grand_shape:4,trail:true,v:0.31d,g:0.023d,t0:11,t1:19}
execute if score #finale_tier hb_ctx matches 3 run data modify storage hanabi:firework finale merge value {base_shape:2,grand_shape:2,trail:true,twinkle:true,v:0.38d,g:0.021d,t0:13,t1:22}
execute if score #finale_tier hb_ctx matches 4 run data modify storage hanabi:firework finale merge value {base_shape:1,grand_shape:1,trail:true,twinkle:true,v:0.45d,g:0.019d,t0:15,t1:25}
execute if score #finale_tier hb_ctx matches 5 run data modify storage hanabi:firework finale merge value {base_shape:1,grand_shape:2,trail:true,twinkle:true,v:0.53d,g:0.017d,t0:17,t1:28}
execute if score #finale_tier hb_ctx matches 6 run data modify storage hanabi:firework finale merge value {base_shape:2,grand_shape:1,trail:true,twinkle:true,v:0.62d,g:0.015d,t0:20,t1:32}
execute if score #finale_tier hb_ctx matches 7 run data modify storage hanabi:firework finale merge value {base_shape:2,grand_shape:1,trail:true,twinkle:true,v:0.72d,g:0.013d,t0:22,t1:36,grand_life:48}

# 只把本局实际接出过的颜色加入终场随机颜色池。
execute if score @s hb_wstack matches 1.. run data modify storage hanabi:firework finale.colors append value {from:[I;16777215,14931153],to:[I;11184810]}
execute if score @s hb_rstack matches 1.. run data modify storage hanabi:firework finale.colors append value {from:[I;16733525,11141120],to:[I;16755200]}
execute if score @s hb_bstack matches 1.. run data modify storage hanabi:firework finale.colors append value {from:[I;5592575,43690],to:[I;5636095]}
execute if score @s hb_ystack matches 1.. run data modify storage hanabi:firework finale.colors append value {from:[I;16777045,16755200],to:[I;16777215]}
execute if score @s hb_gstack matches 1.. run data modify storage hanabi:firework finale.colors append value {from:[I;5635925,43520],to:[I;16777045]}
execute if score @s hb_mstack matches 1.. run data modify storage hanabi:firework finale.colors append value {from:[I;16777215,16733525,5592575,16777045,5635925],to:[I;16711935,65535]}

# 0分以熄火效果收尾；其余分数按各色牌堆高度分别发射。
execute if score @s hb_score matches 0 run return run function hanabi:firework/finale/fizzle
execute if score @s hb_wstack matches 1.. positioned ~-0.60 ~0.35 ~ run function hanabi:firework/finale/color/white
execute if score @s hb_rstack matches 1.. positioned ~-0.36 ~0.35 ~ run function hanabi:firework/finale/color/red
execute if score @s hb_bstack matches 1.. positioned ~-0.12 ~0.35 ~ run function hanabi:firework/finale/color/blue
execute if score @s hb_ystack matches 1.. positioned ~0.12 ~0.35 ~ run function hanabi:firework/finale/color/yellow
execute if score @s hb_gstack matches 1.. positioned ~0.36 ~0.35 ~ run function hanabi:firework/finale/color/green
execute if score @s hb_mstack matches 1.. positioned ~0.60 ~0.35 ~ run function hanabi:firework/finale/color/multicolor

# 11分起追加一层使用本局实际颜色池的中央大烟花，分支数直接取最终得分。
execute if score #finale_tier hb_ctx matches 3.. positioned ~ ~0.5 ~ run function hanabi:firework/finale/grand/prepare
function hanabi:log {text:"已按最终得分与颜色进度生成花火终场烟花"}
