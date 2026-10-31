scoreboard players set #chosen ch_ctx 0
execute as @e[type=minecraft:marker,tag=ch.board] if score @s ch_sq = #target ch_ctx run scoreboard players operation #chosen ch_ctx = @s ch_piece
scoreboard players operation #chosen ch_ctx *= @s ch_turn
execute unless score #chosen ch_ctx matches 1..6 run return 0
scoreboard players operation @s ch_sel = #target ch_ctx
function chess:visual/select
execute if score #chosen ch_ctx matches 1 run title @a[tag=ch.actor] actionbar {text:"已选择：兵",color:"gold"}
execute if score #chosen ch_ctx matches 2 run title @a[tag=ch.actor] actionbar {text:"已选择：马",color:"gold"}
execute if score #chosen ch_ctx matches 3 run title @a[tag=ch.actor] actionbar {text:"已选择：象",color:"gold"}
execute if score #chosen ch_ctx matches 4 run title @a[tag=ch.actor] actionbar {text:"已选择：车",color:"gold"}
execute if score #chosen ch_ctx matches 5 run title @a[tag=ch.actor] actionbar {text:"已选择：后",color:"gold"}
execute if score #chosen ch_ctx matches 6 run title @a[tag=ch.actor] actionbar {text:"已选择：王",color:"gold"}
