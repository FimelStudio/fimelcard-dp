execute as @a[scores={it_settings=1..}] at @s run function ito:settings/save
execute as @a[tag=it.player,scores={it_action=1..}] at @s run function ito:input/submit
execute in minecraft:overworld run function ito:system/tick_dimension
execute in minecraft:the_nether run function ito:system/tick_dimension
execute in minecraft:the_end run function ito:system/tick_dimension
