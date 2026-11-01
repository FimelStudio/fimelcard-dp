tag @s add ll.controller
execute if score @s ct_state matches 0 run return run function love_letter:game/init_table
function love_letter:system/context
function love_letter:game/bump_epoch
function love_letter:visual/refresh
execute as @a[tag=ll.audience] run function love_letter:input/give
function love_letter:hud/refresh
# 保留牌库、备用牌、手牌、当前角色子阶段和结算倒计时，不重新洗牌。
