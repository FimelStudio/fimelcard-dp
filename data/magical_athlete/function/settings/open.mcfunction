execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 23 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #set_table ma_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_id = #set_table ma_ctx run return 0
function magical_athlete:settings/defaults
function magical_athlete:settings/begin
function magical_athlete:settings/root
