scoreboard players operation #reveal_role av_ctx = @s av_role
scoreboard players operation #reveal_seat av_ctx = @s av_seat
execute if score @s av_role matches 1 run data modify storage avalon:reveal model set value "merlin"
execute if score @s av_role matches 2 run data modify storage avalon:reveal model set value "percival"
execute if score @s av_role matches 3 run data modify storage avalon:reveal model set value "loyalist"
execute if score @s av_role matches 4 run data modify storage avalon:reveal model set value "morgana"
execute if score @s av_role matches 5 run data modify storage avalon:reveal model set value "assassin"
execute if score @s av_role matches 6 run data modify storage avalon:reveal model set value "oberon"
execute if score @s av_role matches 7 run data modify storage avalon:reveal model set value "minion"
execute if score @s av_seat matches 1 positioned ~-0.85 ~1.08 ~-1.42 summon minecraft:item_display run function avalon:reveal/init with storage avalon:reveal
execute if score @s av_seat matches 2 positioned ~0.85 ~1.08 ~-1.42 summon minecraft:item_display run function avalon:reveal/init with storage avalon:reveal
execute if score @s av_seat matches 3 positioned ~1.42 ~1.08 ~-0.85 summon minecraft:item_display run function avalon:reveal/init with storage avalon:reveal
execute if score @s av_seat matches 4 positioned ~1.42 ~1.08 ~0.85 summon minecraft:item_display run function avalon:reveal/init with storage avalon:reveal
execute if score @s av_seat matches 5 positioned ~0.85 ~1.08 ~1.42 summon minecraft:item_display run function avalon:reveal/init with storage avalon:reveal
execute if score @s av_seat matches 6 positioned ~-0.85 ~1.08 ~1.42 summon minecraft:item_display run function avalon:reveal/init with storage avalon:reveal
execute if score @s av_seat matches 7 positioned ~-1.42 ~1.08 ~0.85 summon minecraft:item_display run function avalon:reveal/init with storage avalon:reveal
execute if score @s av_seat matches 8 positioned ~-1.42 ~1.08 ~-0.85 summon minecraft:item_display run function avalon:reveal/init with storage avalon:reveal
