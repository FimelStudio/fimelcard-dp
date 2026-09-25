function wenfei:game/init_table
scoreboard players operation @a[tag=ct.settings_actor,limit=1] wq_settable = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] wq_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] wq_settings
function wenfei:settings/dialog
execute store result storage wenfei:ui dialog.inputs[0].initial int 1 run scoreboard players get @s wq_duo
execute store result storage wenfei:ui dialog.inputs[1].initial int 1 run scoreboard players get @s wq_multi
execute as @a[tag=ct.settings_actor,limit=1] run function wenfei:ui/show with storage wenfei:ui
