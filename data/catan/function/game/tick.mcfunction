# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:system/context
function catan:visual/tick
function catan:sound/tick
scoreboard players add @s ca_pulse 1
execute if score @s ca_pulse matches 20.. run function catan:game/hud
execute if score @s ca_finish matches 1.. run return run function catan:game/finish_tick
function catan:game/online
execute if score @s ca_anim matches 1.. run function catan:input/clear_pending
execute if score @s ca_vtimer matches 1.. run function catan:input/clear_pending
execute if score @s ca_anim matches 1.. run scoreboard players remove @s ca_anim 1
execute if score @s ca_anim matches 1.. run return 0
execute if score @s ca_vtimer matches 1.. run return 0
function catan:engine/tick
execute if score #changed ca_ctx matches 1 run function catan:game/after_action
execute as @e[type=minecraft:interaction,tag=ca.surface] if score @s ct_id = #table ca_ctx if data entity @s interaction run function catan:input/cell
execute as @a[tag=ca.audience] run function catan:input/give
# direct-v2
execute as @e[tag=ca.surface] if score @s ct_id = #table ca_ctx if data entity @s attack run function catan:direct/left
execute as @a[tag=ca.audience] run function catan:hud/tick
execute as @e[tag=ca.deck_hit] if score @s ct_id = #table ca_ctx if data entity @s interaction run function catan:direct/deck_click
execute if score @s ca_state matches 7 if data entity @s data.catan.eligible[0] unless data entity @s data.catan.eligible[1] as @a[tag=ca.audience] if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run function catan:direct/auto_steal
scoreboard players add @s ca_dclock 1
execute if score @s ca_dclock matches 5.. run scoreboard players set @s ca_dclock 0
execute if score @s ca_dclock matches 0 as @a[tag=ca.audience] at @s if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run function catan:direct/look_highlight
# feedback-v1
execute if score @s ca_pulse matches 0 run function catan:feedback/guide
