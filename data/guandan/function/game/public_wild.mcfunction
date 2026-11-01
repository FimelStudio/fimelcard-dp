execute if score #pub_count gd_ctx >= #pub_multi gd_ctx run return 0
scoreboard players set #pub_id gd_ctx 999
execute as @e[tag=gd.cards,scores={gd_sel=1,gd_wild=1}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #pub_id gd_ctx < @s gd_id
execute if score #pub_id gd_ctx matches 999 run return 0
execute store result storage guandan:runtime wildcard.level int 1 run scoreboard players get @s gd_level
execute store result storage guandan:runtime wildcard.point int 1 run scoreboard players get #pub_point gd_ctx
execute if score #pub_point gd_ctx matches 11 run data modify storage guandan:runtime wildcard.point set value "J"
execute if score @s gd_level matches 11 run data modify storage guandan:runtime wildcard.level set value "J"
execute if score #pub_point gd_ctx matches 12 run data modify storage guandan:runtime wildcard.point set value "Q"
execute if score @s gd_level matches 12 run data modify storage guandan:runtime wildcard.level set value "Q"
execute if score #pub_point gd_ctx matches 13 run data modify storage guandan:runtime wildcard.point set value "K"
execute if score @s gd_level matches 13 run data modify storage guandan:runtime wildcard.level set value "K"
execute if score #pub_point gd_ctx matches 14 run data modify storage guandan:runtime wildcard.point set value "A"
execute if score @s gd_level matches 14 run data modify storage guandan:runtime wildcard.level set value "A"
data modify storage guandan:runtime wildcard.label set from entity @s data.guandan.action.label
function guandan:game/public_wild_label with storage guandan:runtime wildcard
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #actor gd_ctx if score @s gd_id = #pub_id gd_ctx run function guandan:game/commit_card
scoreboard players add #pub_count gd_ctx 1
function guandan:game/public_wild
