execute as @e[type=minecraft:interaction,tag=go.cell] if data entity @s interaction at @s run function weiqi:input/cell
execute as @a[tag=go.player,scores={go_drop=1..}] at @s run function weiqi:input/drop
execute as @a[tag=go.player,scores={go_action=1..}] at @s run function weiqi:input/submit
execute as @a[scores={go_settings=1..}] at @s run function weiqi:settings/save
execute as @a[tag=go.player,scores={go_coord=1..}] at @s run function weiqi:input/coordinate_submit
