# 五种基础颜色各含1×3、2×2、3×2、4×2、5×1，共50张
scoreboard players set #deck_card hb_ctx 0
scoreboard players set #deck_reward hb_ctx 0
scoreboard players set #deck_color hb_ctx 1
function hanabi:deck/create_color
scoreboard players set #deck_color hb_ctx 2
function hanabi:deck/create_color
scoreboard players set #deck_color hb_ctx 3
function hanabi:deck/create_color
scoreboard players set #deck_color hb_ctx 4
function hanabi:deck/create_color
scoreboard players set #deck_color hb_ctx 5
function hanabi:deck/create_color

# 彩色风暴为第六种颜色，数字1至5各一张
execute if score @s hb_storm matches 1 run function hanabi:deck/create_storm

scoreboard players operation @s hb_deck_count = #deck_card hb_ctx
function hanabi:log {text:"本桌普通花火牌库已创建；奖励牌不混入普通牌库"}
