# 彩色风暴终场分支使用五色混合爆炸
scoreboard players operation #finale_stack hb_ctx = @s hb_mstack
data modify storage hanabi:firework finale merge value {life:20}
function hanabi:firework/finale/color/prepare_multicolor
