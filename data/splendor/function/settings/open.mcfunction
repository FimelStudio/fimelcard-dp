execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 22 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #set_table sp_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_id = #set_table sp_ctx run return 0
function splendor:settings/defaults
function splendor:settings/begin
function splendor:settings/root
