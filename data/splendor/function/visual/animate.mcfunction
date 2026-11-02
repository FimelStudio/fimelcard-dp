execute if score @s ct_paused matches 1 run return 0
function splendor:visual/context
data modify entity @s data.splendor.visual_active set from entity @s data.splendor.last
data modify storage splendor:visual event set from entity @s data.splendor.visual_active
execute if data storage splendor:visual event{actor:0} run return 0
function splendor:visual/actor with storage splendor:visual event
data modify entity @s data.splendor.visual_active.seat set from storage splendor:visual seat
function cardtable:chairs/layout/position with storage splendor:visual
data modify storage splendor:visual end set from storage cardtable:layout position
function splendor:visual/build_motion
data modify storage splendor:visual model set value "bag"
execute if data storage splendor:visual event{code:3} run function splendor:visual/bought_card
execute if data storage splendor:visual event{code:5} run function splendor:visual/arriving_noble
execute if data storage splendor:visual event{code:1} run function splendor:visual/take_tokens
execute if data storage splendor:visual event{code:4} run function splendor:visual/return_tokens
data modify storage splendor:visual kind set value 9
data modify storage splendor:visual id set value 0
data modify storage splendor:visual pose set from entity @s data.splendor.visual_active.motion[0]
function splendor:visual/spawn
execute as @e[tag=sp.visual,scores={sp_vkind=9}] if score @s sp_table = #vis_table sp_ctx run tag @s add sp.anim
scoreboard players set @s sp_vtimer 10
scoreboard players set @s sp_vstep 0
