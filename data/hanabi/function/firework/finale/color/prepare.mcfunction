# 单色分支数 = 该色已接牌数 + 总分档位；完成到5时强制使用闪烁星形。

scoreboard players operation #finale_branches hb_ctx = #finale_stack hb_ctx
scoreboard players operation #finale_branches hb_ctx += #finale_tier hb_ctx
execute store result storage hanabi:firework finale.branches int 1 run scoreboard players get #finale_branches hb_ctx
data modify storage hanabi:firework finale.color_shape set from storage hanabi:firework finale.base_shape
data modify storage hanabi:firework finale.color_twinkle set from storage hanabi:firework finale.twinkle
execute if score #finale_stack hb_ctx matches 5 run data modify storage hanabi:firework finale.color_shape set value 2
execute if score #finale_stack hb_ctx matches 5 run data modify storage hanabi:firework finale.color_twinkle set value true
function hanabi:firework/finale/color/launch with storage hanabi:firework finale
