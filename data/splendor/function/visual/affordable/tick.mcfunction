# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s ct_paused matches 1 run return 0
execute unless score @s ct_state matches 1 run return 0
execute unless score @s sp_state matches 1 run return 0
execute unless score @s sp_anim matches 0 run return 0
scoreboard players operation #aff_table sp_ctx = @s ct_id
scoreboard players operation #aff_turn sp_ctx = @s sp_turn
tag @a[tag=sp.affordable_viewer] remove sp.affordable_viewer
execute as @a[tag=sp.player,tag=ct.player] if score @s sp_table = #aff_table sp_ctx if score @s ct_id = #aff_table sp_ctx if score @s sp_side = #aff_turn sp_ctx run tag @s add sp.affordable_viewer
execute unless entity @a[tag=sp.affordable_viewer] run return 0
data modify storage splendor:affordable market set from entity @s data.splendor.market
function splendor:visual/affordable/player with entity @s data.splendor
execute as @e[type=minecraft:interaction,tag=sp.hit,scores={sp_vkind=2}] if score @s sp_table = #aff_table sp_ctx at @s run function splendor:visual/affordable/card
tag @a[tag=sp.affordable_viewer] remove sp.affordable_viewer
