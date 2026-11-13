execute unless score @s sp_select_kind matches 2 run return run function splendor:direct/card_reserve_select
execute unless score @s sp_select_id = @s sp_target run return run function splendor:direct/card_reserve_select
execute unless score @s sp_select_stage matches 3 run return run function splendor:direct/card_reserve_select
function splendor:direct/reserve
