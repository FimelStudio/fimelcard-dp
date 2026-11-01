execute unless entity @e[tag=gd.chooser,scores={gd_tribute=1},limit=1] run return 0
execute if entity @e[tag=gd.pick,scores={gd_wild=1},limit=1] run return 0
scoreboard players set #max gd_ctx -1
execute as @e[tag=gd.cards,scores={gd_wild=0}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #max gd_ctx > @s gd_strength
execute unless score @e[tag=gd.pick,limit=1] gd_strength = #max gd_ctx run return 0
scoreboard players operation @e[tag=gd.chooser,limit=1] gd_giftid = #card gd_ctx
scoreboard players set @e[tag=gd.chooser,limit=1] gd_tribute 2
function guandan:game/bump_epoch
execute unless entity @e[tag=gd.board,scores={gd_tribute=1}] run function guandan:tribute/gifts_ready
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
