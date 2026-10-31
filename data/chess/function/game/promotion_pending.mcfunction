scoreboard players operation @s ch_pfrom = #from ch_ctx
scoreboard players operation @s ch_pto = #to ch_ctx
scoreboard players set @s ch_state 3
function chess:hints/clear
scoreboard players add @s ch_epoch 1
execute as @a[tag=ch.actor] run function chess:ui/promotion
