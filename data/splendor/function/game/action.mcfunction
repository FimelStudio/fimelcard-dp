execute if score @s ct_paused matches 1 run return 0
function splendor:system/context
execute unless entity @a[tag=sp.actor,tag=sp.audience,limit=1] run return 0
execute if score @s sp_anim matches 1.. run return 0
function splendor:engine/action
execute unless score #ok sp_ctx matches 1 run return run function splendor:game/illegal
function splendor:game/after_action
