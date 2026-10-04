# 保留发牌、结算计时；仅恢复当前施法入口。
execute unless score @s ab_state matches 2 run return 0
function abraca:hud/update
function abraca:title/update_all
scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #resume_turn ab_ctx = @s ab_turn
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.turn
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_seat = #resume_turn ab_ctx run tag @s add ab.turn
execute as @a[tag=ab.turn] if score @s ab_id = #ctx ab_ctx run function abraca:ui/open_cast
