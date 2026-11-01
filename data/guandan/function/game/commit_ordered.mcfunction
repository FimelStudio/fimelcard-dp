# Consume public cards in deterministic combination order, preserving physical identities.
scoreboard players operation #pub_kind gd_ctx = @s gd_kind
execute store result score #pub_high gd_ctx run data get entity @s data.guandan.chosen.point
scoreboard players set #pub_low gd_ctx 2
scoreboard players set #pub_end gd_ctx 16
scoreboard players set #pub_multi gd_ctx 0
execute if score #pub_kind gd_ctx matches 5..7 run function guandan:game/public_sequence
execute if score #pub_kind gd_ctx matches 9 run function guandan:game/public_sequence
function guandan:game/public_rank_loop
# Remaining wildcards/non-sequence cards retain their real identity.
function guandan:game/public_remaining
