execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 15 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #setting_table ac_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #setting_table ac_ctx run return 0
function aeroplane_chess:settings/begin
function aeroplane_chess:settings/root
