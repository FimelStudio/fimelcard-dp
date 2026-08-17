# 当前执行者为花火控制器，位置在牌桌中心上方。
# 将颜色参数集中写入存储；彩色牌使用独立的五色爆炸参数。

data modify storage hanabi:firework success set value {life:15,shape:2,count:1,twinkle:false,primary:16777215,accent:14931153,fade:11184810}

# 1白、2红、3蓝、4黄、5绿
execute if score #played_color hb_ctx matches 1 run data modify storage hanabi:firework success merge value {primary:16777215,accent:14931153,fade:11184810}
execute if score #played_color hb_ctx matches 2 run data modify storage hanabi:firework success merge value {primary:16733525,accent:11141120,fade:16755200}
execute if score #played_color hb_ctx matches 3 run data modify storage hanabi:firework success merge value {primary:5592575,accent:43690,fade:5636095}
execute if score #played_color hb_ctx matches 4 run data modify storage hanabi:firework success merge value {primary:16777045,accent:16755200,fade:16777215}
execute if score #played_color hb_ctx matches 5 run data modify storage hanabi:firework success merge value {primary:5635925,accent:43520,fade:16777045}
execute if score #played_color hb_ctx matches 6 run return run function hanabi:firework/success/multicolor

# 每种颜色的数字5代表整组烟花完成，使用更高、更大且闪烁的双重爆炸。
execute if score #played_rank hb_ctx matches 5 run data modify storage hanabi:firework success merge value {life:21,shape:1,count:2,twinkle:true}

function hanabi:firework/success/launch with storage hanabi:firework success
