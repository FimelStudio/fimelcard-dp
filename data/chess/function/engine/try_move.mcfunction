# #from/#to=棋格，#promo=0等待升变或2马3象4车5后。非法绝不修改真实局面。
function chess:system/context
function chess:engine/cache
scoreboard players set #legal ch_ctx 0
execute unless score #cache_ok ch_ctx matches 1 run return 0
execute unless score #from ch_ctx matches 0..63 run return 0
execute unless score #to ch_ctx matches 0..63 run return 0
execute unless score #promo ch_ctx matches 0..5 run return 0
execute if score #promo ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1..3 run return 0
execute unless score @s ch_state matches 1 unless score @s ch_state matches 3 run return 0
function chess:engine/check_move
execute unless score #legal ch_ctx matches 1 run return 0
execute if score #promotion ch_ctx matches 1 if score #promo ch_ctx matches 0 run return run function chess:engine/promotion_pending
function chess:engine/commit
return 1
