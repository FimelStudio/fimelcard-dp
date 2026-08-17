scoreboard players operation #finale_branches hb_ctx = #finale_stack hb_ctx
scoreboard players operation #finale_branches hb_ctx += #finale_tier hb_ctx
execute store result storage hanabi:firework finale.branches int 1 run scoreboard players get #finale_branches hb_ctx
data modify storage hanabi:firework finale.color_shape set from storage hanabi:firework finale.base_shape
data modify storage hanabi:firework finale.color_twinkle set value true
execute if score #finale_stack hb_ctx matches 5 run data modify storage hanabi:firework finale.color_shape set value 2
function hanabi:firework/finale/color/launch_multicolor with storage hanabi:firework finale
