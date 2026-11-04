# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @a[scores={ma_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function magical_athlete:settings/save
execute as @a[scores={ma_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function magical_athlete:ui/handle
execute as @a[tag=ma.player,scores={ma_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function magical_athlete:input/drop
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_game=23,ct_state=1}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function magical_athlete:game/tick
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_game=23,ct_state=1}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function magical_athlete:game/tick
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_game=23,ct_state=1}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function magical_athlete:game/tick
execute as @a[tag=ma.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] unless entity @s[tag=ct.player] run function magical_athlete:player/clear_state

execute as @a[tag=ma.player,scores={ma_dye=1..}] at @s run function magical_athlete:direct/dye_drop

scoreboard players remove @a[scores={ma_notice=1..}] ma_notice 1
