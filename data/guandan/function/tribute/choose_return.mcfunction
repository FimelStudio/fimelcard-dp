execute unless entity @e[tag=gd.chooser,scores={gd_return=1},limit=1] run return 0
scoreboard players set #small gd_ctx 0
scoreboard players set #min gd_ctx 99
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_point matches 2..10 run scoreboard players set #small gd_ctx 1
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #min gd_ctx < @s gd_strength
execute if score #small gd_ctx matches 1 unless score @e[tag=gd.pick,limit=1] gd_point matches 2..10 run return 0
execute if score #small gd_ctx matches 0 unless score @e[tag=gd.pick,limit=1] gd_strength = #min gd_ctx run return 0
scoreboard players operation @e[tag=gd.chooser,limit=1] gd_returnid = #card gd_ctx
scoreboard players set @e[tag=gd.chooser,limit=1] gd_return 2
function guandan:game/bump_epoch
execute unless entity @e[tag=gd.board,scores={gd_return=1}] run function guandan:tribute/returns_ready
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
