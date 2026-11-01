scoreboard players set #ok gd_ctx 0
execute unless score @s gd_state matches 2 run return 0
execute if score @s gd_anim matches 1.. run return 0
function guandan:system/context
tag @e[tag=gd.chooser] remove gd.chooser
execute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run tag @s add gd.chooser
execute unless entity @e[tag=gd.chooser,limit=1] run return 0
tag @e[tag=gd.pick] remove gd.pick
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_id = #card gd_ctx run tag @s add gd.pick
execute unless entity @e[tag=gd.pick,limit=1] run return 0
execute if score @s gd_phase matches 1 run function guandan:tribute/choose_gift
execute if score @s gd_phase matches 2 run function guandan:tribute/choose_return
