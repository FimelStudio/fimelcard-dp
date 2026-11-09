# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if entity @s[nbt={Health:0.0f}] run return 0
function magical_athlete:direct/sync
execute unless entity @s[tag=ma.actor] run return 0
function magical_athlete:hud/tick
execute store result score #mirrored ma_ctx run clear @s *[minecraft:custom_data~{magical_athlete:{tool:1b}}] 0
execute unless score #mirrored ma_ctx = @s ma_expected run scoreboard players set @s ma_depoch -1
execute unless items entity @s hotbar.7 *[minecraft:custom_data~{magical_athlete:{dice:1b}}] run scoreboard players set @s ma_depoch -1
