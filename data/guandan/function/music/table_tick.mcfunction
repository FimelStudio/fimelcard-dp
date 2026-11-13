# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function guandan:system/context
execute if entity @s[tag=gd.music_suspended] run function guandan:music/resume
execute if score @s gd_audio matches 0 as @a[tag=gd.audience] if score @s gd_music matches 1.. run function guandan:music/stop
execute if score @s gd_audio matches 0 run return 0
execute unless score @s gd_state matches 1..5 run return 0
scoreboard players remove @a[tag=gd.audience,scores={gd_mtime=1..}] gd_mtime 1
execute if score @s gd_state matches 1..3 run function guandan:music/playing
execute if score @s gd_state matches 4..5 run function guandan:music/result
