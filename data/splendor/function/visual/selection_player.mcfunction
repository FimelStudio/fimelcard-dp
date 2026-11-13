scoreboard players operation #vis_id sp_ctx = @s sp_select_id
scoreboard players operation #vis_kind sp_ctx = @s sp_select_kind
execute if score #vis_kind sp_ctx matches 2..5 run function splendor:visual/highlight
execute if score @s sp_pick0 matches 1.. run function splendor:visual/highlight_gem {id:0}
execute if score @s sp_pick1 matches 1.. run function splendor:visual/highlight_gem {id:1}
execute if score @s sp_pick2 matches 1.. run function splendor:visual/highlight_gem {id:2}
execute if score @s sp_pick3 matches 1.. run function splendor:visual/highlight_gem {id:3}
execute if score @s sp_pick4 matches 1.. run function splendor:visual/highlight_gem {id:4}
execute if score @s sp_pick5 matches 1.. run function splendor:visual/highlight_gem {id:5}
