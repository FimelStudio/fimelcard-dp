execute unless score @s sp_target matches 0..2 run return run function splendor:hud/notice {"text":{"text":"请选择一个有效的牌堆。","color":"yellow"}}
function splendor:direct/hand
scoreboard players set #select_kind sp_ctx 5
execute unless score @s sp_select_kind matches 5 run return run function splendor:direct/deck_select
execute unless score @s sp_select_id = @s sp_target run return run function splendor:direct/deck_select
scoreboard players add @s sp_target 12
function splendor:direct/reserve
