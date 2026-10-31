execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 12 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #ui_setting_table ch_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #ui_setting_table ch_ctx run return 0
function chess:settings/begin
function chess:settings/root
