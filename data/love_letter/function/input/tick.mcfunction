execute as @a[tag=ll.player,scores={ll_drop=1..}] at @s run function love_letter:input/drop
execute as @a[tag=ll.player,scores={ll_action=1..}] at @s run function love_letter:input/submit
execute as @a[scores={ll_settings=1..}] at @s run function love_letter:settings/save
