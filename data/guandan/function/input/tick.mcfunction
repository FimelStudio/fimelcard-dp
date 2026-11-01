execute as @a[tag=gd.player,scores={gd_drop=1..}] at @s run function guandan:input/drop
execute as @a[tag=gd.player,scores={gd_action=1..}] at @s run function guandan:input/submit
execute as @a[scores={gd_settings=1..}] at @s run function guandan:settings/save
execute as @a[tag=gd.player] run function guandan:input/sync_turn_tool
