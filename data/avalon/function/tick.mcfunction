# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[type=minecraft:item] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if items entity @s contents *[minecraft:custom_data~{avalon:{ballot:1b}}] run function avalon:input/drop_ballot
execute as @e[type=minecraft:marker,tag=av.controller,scores={av_state=5}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function avalon:game/ending_tick
execute as @e[type=minecraft:item] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if items entity @s contents *[minecraft:custom_data~{avalon:{role_card:1b}}] run function avalon:input/drop_role
execute as @a[tag=av.player,scores={av_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function avalon:input/handle
execute as @e[type=minecraft:item] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if items entity @s contents *[minecraft:custom_data~{avalon:{menu:1b}}] run function avalon:input/drop
execute as @e[type=minecraft:marker,tag=av.controller,scores={av_state=1..4}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function avalon:game/tick
execute as @a[tag=av.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] unless entity @s[tag=ct.player] run function avalon:player/clear
scoreboard players add #maintenance av_ctx 1
execute if score #maintenance av_ctx matches 20.. as @a[tag=av.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function avalon:player/check
execute if score #maintenance av_ctx matches 20.. run scoreboard players set #maintenance av_ctx 0

# Keep completed public status visible until the next state update.
execute as @e[tag=av.hud_animated,tag=fimel.anim_text.positional.typewriter] unless data entity @s data.input[0] run tag @s remove fimel.anim_text.positional.typewriter
