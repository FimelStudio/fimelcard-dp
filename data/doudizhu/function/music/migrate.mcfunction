execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.basedrum
execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.bass
execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.bell
execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.chime
execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.flute
execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.guitar
execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.harp
execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.hat
execute as @a[scores={dd_music=1..}] run stopsound @s record minecraft:block.note_block.snare
tag @a remove ddm_normal
scoreboard objectives remove ddm_normal
scoreboard objectives remove ddm_normal_t
tag @a remove ddm_exciting
scoreboard objectives remove ddm_exciting
scoreboard objectives remove ddm_exciting_t
tag @a remove ddm_win
scoreboard objectives remove ddm_win
scoreboard objectives remove ddm_win_t
tag @a remove ddm_lose
scoreboard objectives remove ddm_lose
scoreboard objectives remove ddm_lose_t
data modify storage doudizhu:music resource_audio set value 1b
