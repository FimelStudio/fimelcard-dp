execute if score #est_side go_ctx matches 1 if score @s go_bdist > #est_next go_ctx run scoreboard players operation @s go_bdist = #est_next go_ctx
execute if score #est_side go_ctx matches -1 if score @s go_wdist > #est_next go_ctx run scoreboard players operation @s go_wdist = #est_next go_ctx
