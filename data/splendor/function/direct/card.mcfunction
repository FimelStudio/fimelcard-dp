execute unless score @s sp_target matches 0..11 run return run function splendor:hud/notice {"text":{"text":"请选择市场中的发展卡。","color":"yellow"}}
function splendor:direct/hand
function splendor:direct/read_card
execute unless score #card sp_ctx matches 0..89 run return run function splendor:hud/notice {"text":{"text":"这张发展卡已不在市场中。","color":"yellow"}}
scoreboard players set #select_kind sp_ctx 2
execute unless score @s sp_select_kind matches 2 run return run function splendor:direct/card_select
execute unless score @s sp_select_id = @s sp_target run return run function splendor:direct/card_select
execute if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{flags:{is_sneaking:true}}} run return run function splendor:direct/reserve
execute if score @s sp_select_stage matches 2 run return run function splendor:direct/reserve
function splendor:direct/quote
execute if score #quote_gold sp_ctx > #quote_owned sp_ctx run return run function splendor:direct/card_unaffordable
scoreboard players set #action_code sp_ctx 3
function splendor:direct/submit
