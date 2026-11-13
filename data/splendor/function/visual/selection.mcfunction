scoreboard players operation #vis_table sp_ctx = @s ct_id
scoreboard players set #vis_turn sp_ctx 0
scoreboard players set #vis_epoch sp_ctx -1
execute store result score #vis_turn sp_ctx run data get entity @s data.splendor.turn
execute store result score #vis_epoch sp_ctx run data get entity @s data.splendor.epoch
execute as @e[type=minecraft:item_display,tag=sp.selected] if score @s sp_table = #vis_table sp_ctx run data merge entity @s {Glowing:0b}
execute as @e[tag=sp.selected] if score @s sp_table = #vis_table sp_ctx run tag @s remove sp.selected
execute if score @s sp_state matches 3 run function splendor:visual/eligible_nobles
execute as @a[tag=sp.player,tag=ct.player] if score @s sp_table = #vis_table sp_ctx if score @s ct_id = #vis_table sp_ctx if score @s sp_side = #vis_turn sp_ctx if score @s sp_select_epoch = #vis_epoch sp_ctx run function splendor:visual/selection_player
